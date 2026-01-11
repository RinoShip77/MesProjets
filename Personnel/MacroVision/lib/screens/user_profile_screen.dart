import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:macro_vision/helpers/helpers.dart';
import 'package:macro_vision/models/user_profile.dart'; // Ensure this path is correct
import 'package:macro_vision/services/nutrition_calculator.dart';
import 'package:macro_vision/widgets/custom_app_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:macro_vision/utils/l10n_extension.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late UserProfile _profile;
  bool _isLoading = true;

  // Controllers
  late TextEditingController _nameController;
  late TextEditingController _weightController;
  late TextEditingController _heightController;
  late TextEditingController _ageController;
  late TextEditingController _bodyFatController;

  // Unit State Variables (Default to Metric)
  WeightUnit _weightUnit = WeightUnit.kg;
  HeightUnit _heightUnit = HeightUnit.cm;

  // Conversion Constants
  static const double _kgToLbs = 2.20462;
  static const double _cmToFt = 0.0328084;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  Future<void> _loadUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('userProfile');

    if (userJson != null) {
      _profile = UserProfile.fromJson(jsonDecode(userJson));
    } else {
      _profile = UserProfile();
    }

    // 1. LOAD SAVED PREFERENCES
    _nameController = TextEditingController(text: _profile.name);
    _ageController = TextEditingController(text: _profile.age.toString());
    _weightUnit = _profile.weightUnit;
    _heightUnit = _profile.heightUnit;
    _bodyFatController = TextEditingController(
      text: _profile.bodyFat?.toStringAsFixed(1),
    );

    double displayWeight = _profile.weight; // stored as kg
    double displayHeight = _profile.height; // stored as cm

    if (_weightUnit == WeightUnit.lbs) displayWeight *= _kgToLbs;
    if (_heightUnit == HeightUnit.ft) displayHeight *= _cmToFt;

    _weightController = TextEditingController(
      text: displayWeight > 0 ? displayWeight.toStringAsFixed(1) : '',
    );
    _heightController = TextEditingController(
      text: displayHeight > 0 ? displayHeight.toStringAsFixed(1) : '',
    );

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _saveUserProfile() async {
    if (!_formKey.currentState!.validate()) {
      if (mounted) showSnackBar(context, context.l10n.appErrorForm, true);
      return;
    }

    // 1. Parse Display Values
    final int age = int.tryParse(_ageController.text) ?? 0;
    final double displayWeight =
        double.tryParse(_weightController.text.replaceAll(',', '.')) ?? 0.0;
    final double displayHeight =
        double.tryParse(_heightController.text.replaceAll(',', '.')) ?? 0.0;
    final double? bodyFat = double.tryParse(
      _bodyFatController.text.replaceAll(',', '.'),
    );

    // 2. Normalize to Storage Format (Metric: kg / cm)
    double storageWeight = displayWeight;
    double storageHeight = displayHeight;

    if (_weightUnit == WeightUnit.lbs) storageWeight = displayWeight / _kgToLbs;
    if (_heightUnit == HeightUnit.ft) storageHeight = displayHeight / _cmToFt;

    // 3. Update Profile Object
    _profile.name = _nameController.text;
    _profile.age = age;
    _profile.weight = storageWeight;
    _profile.height = storageHeight;
    _profile.bodyFat = bodyFat;

    // SAVE THE UNITPREFERENCES
    _profile.weightUnit = _weightUnit;
    _profile.heightUnit = _heightUnit;
    _profile.isMetric =
        (_weightUnit == WeightUnit.kg && _heightUnit == HeightUnit.cm);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userProfile', jsonEncode(_profile.toJson()));

    if (mounted) {
      showSnackBar(context, context.l10n.appSuccessUpdate('profile'), false);
    }
  }

  // --- CONVERSION LOGIC ---

  void _onWeightUnitChanged(WeightUnit? newUnit) {
    if (newUnit == null || newUnit == _weightUnit) return;

    // 1. Get CURRENT value from text field (prevent reset)
    final double? currentValue = double.tryParse(
      _weightController.text.replaceAll(',', '.'),
    );

    if (currentValue != null) {
      // 2. Perform Math based on switch direction
      double convertedValue;
      if (newUnit == WeightUnit.lbs) {
        // kg -> lbs
        convertedValue = currentValue * _kgToLbs;
      } else {
        // lbs -> kg
        convertedValue = currentValue / _kgToLbs;
      }
      // 3. Update Text
      _weightController.text = convertedValue.toStringAsFixed(1);
    }

    // 4. Update State
    setState(() {
      _weightUnit = newUnit;
    });
  }

  void _onHeightUnitChanged(HeightUnit? newUnit) {
    if (newUnit == null || newUnit == _heightUnit) return;

    final double? currentValue = double.tryParse(
      _heightController.text.replaceAll(',', '.'),
    );

    if (currentValue != null) {
      double convertedValue;
      if (newUnit == HeightUnit.ft) {
        // cm -> ft
        convertedValue = currentValue * _cmToFt;
      } else {
        // ft -> cm
        convertedValue = currentValue / _cmToFt;
      }
      _heightController.text = convertedValue.toStringAsFixed(1);
    }

    setState(() {
      _heightUnit = newUnit;
    });
  }

  void _calculateWaterNeeds() {
    // 1. Parse Input
    final double? val = double.tryParse(_weightController.text.replaceAll(',', '.'));
    if (val == null) return; // Exit if empty/invalid

    // 2. Normalize to KG (Simple check)
    final double weightInKg = (_weightUnit == WeightUnit.lbs) ? val / 2.20462 : val;

    // 3. Update State (Delegate math to the Model!)
    setState(() {
      _profile.waterGoal = NutritionCalculator.calculateWaterGoal(weightInKg);
    });

    // 4. Optional Feedback
    if (mounted) {
      showSnackBar(
        context,
        context.l10n.profileScreenWaterGoalCalculationResult(
          '${_profile.waterGoal}',
        ),
        false,
        duration: 500,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: CustomAppBar(title: context.l10n.profileScreenTitle),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: CustomAppBar(title: context.l10n.profileScreenTitle),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            // 1. NAME INPUT
            buildFormTextField(
              controller: _nameController,
              label: context.l10n.appUserNameInpLbl,
              keyboardType: TextInputType.name,
            ),

            // 2. AGE INPUT
            buildFormTextField(
              controller: _ageController,
              label: context.l10n.profileScreenInpLbl('age'),
              keyboardType: TextInputType.number,
              formatters: [FilteringTextInputFormatter.digitsOnly],
            ),

            // 3. WEIGHT INPUT
            buildFormTextFieldWDropdown(
              label: context.l10n.profileScreenInpLbl('weight'),
              controller: _weightController,
              context: context,
              dropdownInitialValue: _weightUnit,
              dropdownOptions: WeightUnit.values,
              onDropdownChanged: _onWeightUnitChanged,
              validationText: context.l10n.appWarningFormValidation('weight'),
            ),

            // 4. HEIGHT INPUT
            buildFormTextFieldWDropdown(
              label: context.l10n.profileScreenInpLbl('height'),
              controller: _heightController,
              context: context,
              dropdownInitialValue: _heightUnit,
              dropdownOptions: HeightUnit.values,
              onDropdownChanged: _onHeightUnitChanged,
              validationText: context.l10n.appWarningFormValidation('height'),
            ),

            // 5. BODY FAT INPUT
            buildFormTextField(
              controller: _bodyFatController,
              label: context.l10n.profileScreenInpLbl('bodyFat'),
              hint: 'Ex: 15',
              suffix: const Icon(Icons.percent_rounded, size: 14),
              // suffix: '%',
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              formatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[\d.,]')),
              ],
            ),

            // 6. ACTIVITY LEVEL DROPDOWN
            buildFormDropdown(
              label: context.l10n.profileScreenInpLbl('activityLevel'),
              initialValue: _profile.activityLevel,
              options: ActivityLevel.values.map((ActivityLevel level) {
                return DropdownMenuItem<ActivityLevel>(
                  value: level,
                  child: Text(
                    context.l10n.profileScreenActivityLevelOption(level.name),
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              }).toList(),
              onChanged: (val) => setState(() => _profile.activityLevel = val),
            ),

            // 7. WATER GOAL INPUT
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(context.l10n.profileScreenInpLbl('waterGoal')),
                    // The "Smart" Button
                    InkWell(
                      onTap: _calculateWaterNeeds,
                      child: Text(
                        context.l10n.profileScreenWaterGoalLabel,
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Expanded(
                      child: Slider(
                        value: _profile.waterGoal,
                        min: 1.0, // Minimum 1L
                        max: 5.0, // Maximum 5L
                        divisions: 40, // Allows 0.1L steps (1.0, 1.1, 1.2...)
                        label: '${_profile.waterGoal.toStringAsFixed(1)} L',
                        onChanged: (double value) {
                          setState(() {
                            _profile.waterGoal = value;
                          });
                        },
                      ),
                    ),
                    // Display the Value
                    Container(
                      width: 60,
                      alignment: Alignment.center,
                      child: Text(
                        '${_profile.waterGoal.toStringAsFixed(1)} L',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const Divider(height: 30),

            // 8. GENDER & GOAL & DIETARY PREFERENCES
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 8.1. GENDER SEGMENTED BUTTON
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(context.l10n.profileScreenInpLbl('gender')),
                    SizedBox(
                      width: double.infinity,
                      child: SegmentedButton<Gender>(
                        segments: [
                          ButtonSegment<Gender>(
                            value: Gender.male,
                            label: Text(
                              context.l10n.profileScreenGenderOption('male'),
                            ),
                            icon: const Icon(Icons.male),
                          ),
                          ButtonSegment<Gender>(
                            value: Gender.female,
                            label: Text(
                              context.l10n.profileScreenGenderOption('female'),
                            ),
                            icon: const Icon(Icons.female),
                          ),
                        ],
                        selected: {_profile.gender},
                        onSelectionChanged: (Set<Gender> newSelection) {
                          setState(() {
                            _profile.gender = newSelection.first;
                          });
                        },
                        style: const ButtonStyle(
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          visualDensity: VisualDensity.compact,
                        ),
                      ),
                    ),
                  ],
                ),

                // 8.2. GOAL & WEEKLY PACE
                Column(
                  children: [
                    // 8.2.1. GOAL CHOICE CHIPS
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(context.l10n.profileScreenInpLbl('goal')),
                          SizedBox(
                            width: double.infinity,
                            child: Wrap(
                              spacing: 10.0, // Space between chips
                              alignment:
                                  WrapAlignment.center, // Center them nicely
                              children: [
                                ChoiceChip(
                                  label: Text(
                                    context.l10n.profileScreenGoalOption(
                                      Goal.weightLoss.name,
                                    ),
                                  ),
                                  showCheckmark: false,
                                  avatar: CircleAvatar(
                                    // Change BACKGROUND color when selected
                                    backgroundColor:
                                        _profile.goal == Goal.weightLoss
                                        ? Theme.of(context).colorScheme.primary
                                        : Colors.transparent,
                                    child: Icon(
                                      Icons.trending_down_rounded,
                                      size: 18,
                                      // Keep Icon color CONSTANT (or adjust if needed)
                                      color: _profile.goal == Goal.weightLoss
                                          ? Theme.of(
                                              context,
                                            ).colorScheme.onPrimary
                                          : Theme.of(
                                              context,
                                            ).colorScheme.primary,
                                    ),
                                  ),
                                  selected: _profile.goal == Goal.weightLoss,
                                  onSelected: (bool selected) {
                                    if (selected) {
                                      setState(
                                        () => _profile.goal = Goal.weightLoss,
                                      );
                                    }
                                  },
                                ),
                                ChoiceChip(
                                  label: Text(
                                    context.l10n.profileScreenGoalOption(
                                      Goal.maintain.name,
                                    ),
                                  ),
                                  showCheckmark: false,
                                  avatar: CircleAvatar(
                                    // Change BACKGROUND color when selected
                                    backgroundColor:
                                        _profile.goal == Goal.maintain
                                        ? Theme.of(context).colorScheme.primary
                                        : Colors.transparent,
                                    child: Icon(
                                      Icons.balance_rounded,
                                      size: 18,
                                      // Keep Icon color CONSTANT (or adjust if needed)
                                      color: _profile.goal == Goal.maintain
                                          ? Theme.of(
                                              context,
                                            ).colorScheme.onPrimary
                                          : Theme.of(
                                              context,
                                            ).colorScheme.primary,
                                    ),
                                  ),
                                  selected: _profile.goal == Goal.maintain,
                                  onSelected: (bool selected) {
                                    if (selected) {
                                      setState(
                                        () => _profile.goal = Goal.maintain,
                                      );
                                    }
                                  },
                                ),
                                ChoiceChip(
                                  label: Text(
                                    context.l10n.profileScreenGoalOption(
                                      Goal.muscleGain.name,
                                    ),
                                  ),
                                  showCheckmark: false,
                                  avatar: CircleAvatar(
                                    // Change BACKGROUND color when selected
                                    backgroundColor:
                                        _profile.goal == Goal.muscleGain
                                        ? Theme.of(context).colorScheme.primary
                                        : Colors.transparent,
                                    child: Icon(
                                      Icons.fitness_center_rounded,
                                      size: 18,
                                      // Keep Icon color CONSTANT (or adjust if needed)
                                      color: _profile.goal == Goal.muscleGain
                                          ? Theme.of(
                                              context,
                                            ).colorScheme.onPrimary
                                          : Theme.of(
                                              context,
                                            ).colorScheme.primary,
                                    ),
                                  ),
                                  selected: _profile.goal == Goal.muscleGain,
                                  onSelected: (bool selected) {
                                    if (selected) {
                                      setState(
                                        () => _profile.goal = Goal.muscleGain,
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // 8.2.2. WEEKLY PACE (Only show if the goal is NOT Maintain)
                    if (_profile.goal != Goal.maintain) ...[
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                context.l10n.profileScreenInpLbl('weeklyPace'),
                              ),
                              // Dynamic Label showing the exact value
                              Text(
                                context.l10n.profileScreenWeelyPaceLabel(
                                  '${_weightUnit.convertPace(_profile.weeklyPace).toStringAsFixed(1)} ${_weightUnit.name}',
                                ),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ],
                          ),

                          Slider(
                            // We always work in KG internally (0.0 to 1.0 kg)
                            value: _profile.weeklyPace,
                            min: 0.1, // Minimum pace
                            max:
                                1.0, // Maximum pace (1kg/week is very aggressive)
                            divisions: 9, // Snaps to 0.1, 0.2 ... 1.0
                            label: context.l10n.profileScreenWeelyPaceLabel(
                              '${_weightUnit.convertPace(_profile.weeklyPace).toStringAsFixed(1)} ${_weightUnit.name}',
                            ),
                            onChanged: (double value) {
                              setState(() {
                                _profile.weeklyPace = value;
                              });
                            },
                          ),

                          // Helper text to explain the difficulty
                          Text(
                            context.l10n.profileScreenWeelyPaceOption(
                              _profile.paceIntensity.name,
                            ),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              color: switch (_profile.paceIntensity) {
                                PaceIntensity.intense => Colors.redAccent,
                                PaceIntensity.moderate => Colors.green,
                                PaceIntensity.slow => Colors.blue,
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),

                // 8.3. DIETARY PREFERENCE
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Divider(height: 15),
                    Text(
                      context.l10n.profileScreenInpLbl('dietaryPreferences'),
                    ),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 4.0,
                      children: DietaryPreference.values
                          // Don't show 'none' as a chip (empty list = none)
                          .where((pref) => pref != DietaryPreference.none)
                          .map((DietaryPreference preference) {
                            // 1. CHECK LIST: Is this option inside our list?
                            final bool isSelected = _profile.dietaryPreferences
                                .contains(preference);

                            return FilterChip(
                              label: Text(
                                context.l10n
                                    .profileScreenDietaryPreferencesOption(
                                      preference.name,
                                    ),
                              ),
                              selected: isSelected,
                              showCheckmark: false,

                              // Style
                              selectedColor: Theme.of(
                                context,
                              ).colorScheme.primary,
                              labelStyle: TextStyle(
                                color: isSelected
                                    ? Theme.of(context).colorScheme.onPrimary
                                    : null,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),

                              // 2. TOGGLE LIST: Add or Remove
                              onSelected: (bool selected) {
                                setState(() {
                                  if (selected) {
                                    _profile.dietaryPreferences.add(preference);
                                  } else {
                                    _profile.dietaryPreferences.remove(
                                      preference,
                                    );
                                  }
                                });
                              },
                            );
                          })
                          .toList(),
                    ),
                  ],
                ),
              ],
            ),

            const Divider(height: 30),

            // 9. SAVE BUTTON
            ElevatedButton.icon(
              icon: const Icon(Icons.save_alt_rounded),
              label: Text(context.l10n.profileScreenSaveBtn),
              onPressed: _saveUserProfile,
            ),
          ],
        ),
      ),
    );
  }
}
