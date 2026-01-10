import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:macro_vision/helpers/helpers.dart';
import 'package:macro_vision/models/user_profile.dart'; // Ensure this path is correct
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

  // Unit State Variables (Default to Metric)
  WeightUnit _weightUnit = WeightUnit.kg;
  HeightUnit _heightUnit = HeightUnit.cm;

  // Conversion Constants
  static const double _kgToLbs = 2.20462;
  static const double _cmToFt = 0.0328084;

  String _getDietaryLabel(DietaryPreference preference) {
    switch (preference) {
      case DietaryPreference.vegetarian:
        return "Végétarien";
      case DietaryPreference.vegan:
        return "Végan";
      case DietaryPreference.glutenFree:
        return "Sans Gluten";
      case DietaryPreference.keto:
        return "Keto";
      case DietaryPreference.lactoseFree:
        return "Sans Lactose";
      case DietaryPreference.none:
        return "Aucune";
    }
  }

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
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

  Future<void> _saveUserProfile() async {
    if (!_formKey.currentState!.validate()) {
      if (mounted) showSnackBar(context, context.l10n.appErrorForm, true);
      return;
    }

    // 1. Parse Display Values
    final double displayWeight =
        double.tryParse(_weightController.text.replaceAll(',', '.')) ?? 0.0;
    final double displayHeight =
        double.tryParse(_heightController.text.replaceAll(',', '.')) ?? 0.0;
    final int age = int.tryParse(_ageController.text) ?? 0;

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

  @override
  void dispose() {
    _nameController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    _ageController.dispose();
    super.dispose();
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
              dropdownInitialValue: _profile.weightUnit,
              dropdownOptions: WeightUnit.values,
              onDropdownChanged: _onWeightUnitChanged,
              validationText: context.l10n.appWarningFormValidation('weight'),
            ),

            // 4. HEIGHT INPUT
            buildFormTextFieldWDropdown(
              label: context.l10n.profileScreenInpLbl('height'),
              controller: _heightController,
              context: context,
              dropdownInitialValue: _profile.heightUnit,
              dropdownOptions: HeightUnit.values,
              onDropdownChanged: _onHeightUnitChanged,
              validationText: context.l10n.appWarningFormValidation('height'),
            ),

            // 5. ACTIVITY LEVEL DROPDOWN
            buildFormDropdown(
              label: context.l10n.profileScreenActivityLevelInpLbl,
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

            const Divider(height: 30),

            // 6. GENDER & GOAL
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 6.1. GENDER SEGMENTED BUTTON
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(context.l10n.profileScreenGenderInpLbl),
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
                                context.l10n.profileScreenGenderOption(
                                  'female',
                                ),
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
                ),

                // 6.2. GOAL CHOICE CHIPS
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(context.l10n.profileScreenGoalInpLbl),
                      const SizedBox(height: 5),
                      SizedBox(
                        width: double.infinity,
                        child: Wrap(
                          spacing: 10.0, // Space between chips
                          alignment: WrapAlignment.center, // Center them nicely
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
                                      ? Theme.of(context).colorScheme.onPrimary
                                      : Theme.of(context).colorScheme.primary,
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
                                    _profile.goal == Goal.weightLoss
                                    ? Theme.of(context).colorScheme.primary
                                    : Colors.transparent,
                                child: Icon(
                                  Icons.balance_rounded,
                                  size: 18,
                                  // Keep Icon color CONSTANT (or adjust if needed)
                                  color: _profile.goal == Goal.weightLoss
                                      ? Theme.of(context).colorScheme.onPrimary
                                      : Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              selected: _profile.goal == Goal.maintain,
                              onSelected: (bool selected) {
                                if (selected) {
                                  setState(() => _profile.goal = Goal.maintain);
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
                                    _profile.goal == Goal.weightLoss
                                    ? Theme.of(context).colorScheme.primary
                                    : Colors.transparent,
                                child: Icon(
                                  Icons.fitness_center_rounded,
                                  size: 18,
                                  // Keep Icon color CONSTANT (or adjust if needed)
                                  color: _profile.goal == Goal.weightLoss
                                      ? Theme.of(context).colorScheme.onPrimary
                                      : Theme.of(context).colorScheme.primary,
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
              ],
            ),

            // 7. DIETARY PREFERENCE
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Préférences Alimentaires", // context.l10n.dietaryLabel
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 5),
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
                            label: Text(_getDietaryLabel(preference)),
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
            ),

            const Divider(height: 30),

            // 7. SAVE BUTTON
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
