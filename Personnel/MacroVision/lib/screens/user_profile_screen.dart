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
  String _weightUnit = 'kg'; // Options: 'kg', 'lbs'
  String _heightUnit = 'cm'; // Options: 'cm', 'ft'

  // Conversion Constants
  static const double _kgToLbs = 2.20462;
  static const double _cmToFt = 0.0328084;

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
    if (_weightUnit.isEmpty) _weightUnit = 'kg';
    if (_heightUnit.isEmpty) _heightUnit = 'cm';

    double displayWeight = _profile.weight; // stored as kg
    double displayHeight = _profile.height; // stored as cm

    if (_weightUnit == 'lbs') displayWeight *= _kgToLbs;
    if (_heightUnit == 'ft') displayHeight *= _cmToFt;

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

  void _onWeightUnitChanged(String? newUnit) {
    if (newUnit == null || newUnit == _weightUnit) return;

    // 1. Get CURRENT value from text field (prevent reset)
    double? currentValue = double.tryParse(
      _weightController.text.replaceAll(',', '.'),
    );

    if (currentValue != null) {
      // 2. Perform Math based on switch direction
      double convertedValue;
      if (newUnit == 'lbs') {
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

  void _onHeightUnitChanged(String? newUnit) {
    if (newUnit == null || newUnit == _heightUnit) return;

    double? currentValue = double.tryParse(
      _heightController.text.replaceAll(',', '.'),
    );

    if (currentValue != null) {
      double convertedValue;
      if (newUnit == 'ft') {
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

    if (_weightUnit == 'lbs') storageWeight = displayWeight / _kgToLbs;
    if (_heightUnit == 'ft') storageHeight = displayHeight / _cmToFt;

    // 3. Update Profile Object
    _profile.name = _nameController.text;
    _profile.age = age;
    _profile.weight = storageWeight;
    _profile.height = storageHeight;

    // SAVE THE UNITPREFERENCES
    _profile.weightUnit = _weightUnit;
    _profile.heightUnit = _heightUnit;
    _profile.isMetric = (_weightUnit == 'kg' && _heightUnit == 'cm')
        ? true
        : false;

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

  // --- UI WIDGETS ---

  Widget _buildUnitDropdown(
    String value,
    List<String> items,
    Function(String?) onChanged,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: DropdownButton<String>(
        value: value,
        icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
        underline: Container(), // Remove default underline
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
        onChanged: onChanged,
        items: items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(value: value, child: Text(value));
        }).toList(),
      ),
    );
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

            // 2. WEIGHT INPUT
            buildFormTextFieldWDropdown(
              label: context.l10n.profileScreenInpLbl('weight'),
              controller: _weightController,
              context: context,
              dropdownInitialValue: _weightUnit,
              dropdownOptions: ['kg', 'lbs'],
              onDropdownChanged: _onWeightUnitChanged,
              validationText: context.l10n.appWarningFormValidation('weight'),
            ),

            // 3. HEIGHT INPUT
            buildFormTextFieldWDropdown(
              label: context.l10n.profileScreenInpLbl('height'),
              controller: _heightController,
              context: context,
              dropdownInitialValue: _heightUnit,
              dropdownOptions: ['cm', 'ft'],
              onDropdownChanged: _onHeightUnitChanged,
              validationText: context.l10n.appWarningFormValidation('height'),
            ),

            // 4. AGE (Simple Text Field Helper with Formatters)
            buildFormTextField(
              controller: _ageController,
              label: context.l10n.profileScreenInpLbl('age'),
              keyboardType: TextInputType.number,
              formatters: [FilteringTextInputFormatter.digitsOnly],
            ),

            // 6. ACTIVITY LEVEL DROPDOWN
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

            // DropdownButtonFormField<ActivityLevel>(
            //   decoration: InputDecoration(
            //     labelText: context.l10n.profileScreenActivityLevelInpLbl,
            //   ),
            //   initialValue: _profile.activityLevel,
            //   items: ActivityLevel.values.map((ActivityLevel level) {
            //     return DropdownMenuItem<ActivityLevel>(
            //       value: level,
            //       child: Text(
            //         context.l10n.profileScreenActivityLevelOption(level.name),
            //       ),
            //     );
            //   }).toList(),
            //   onChanged: (ActivityLevel? newValue) {
            //     if (newValue != null)
            //       setState(() => _profile.activityLevel = newValue);
            //   },
            // ),
            const Divider(height: 30),

            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // GENDER SEGMENTED BUTTON
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

                // 7. GOAL CHOICE CHIPS
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
                                    ? Theme.of(context)
                                          .colorScheme
                                          .primary
                                    : Colors
                                          .transparent,
                                child: Icon(
                                  Icons.trending_down_rounded,
                                  size: 18,
                                  // Keep Icon color CONSTANT (or adjust if needed)
                                  color: _profile.goal == Goal.weightLoss
                                      ? Theme.of(context)
                                            .colorScheme
                                            .onPrimary
                                      : Theme.of(context)
                                            .colorScheme
                                            .primary,
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
                                    ? Theme.of(context)
                                          .colorScheme
                                          .primary
                                    : Colors
                                          .transparent,
                                child: Icon(
                                  Icons.balance_rounded,
                                  size: 18,
                                  // Keep Icon color CONSTANT (or adjust if needed)
                                  color: _profile.goal == Goal.weightLoss
                                      ? Theme.of(context)
                                            .colorScheme
                                            .onPrimary
                                      : Theme.of(context)
                                            .colorScheme
                                            .primary,
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
                                    ? Theme.of(context)
                                          .colorScheme
                                          .primary
                                    : Colors
                                          .transparent,
                                child: Icon(
                                  Icons.fitness_center_rounded,
                                  size: 18,
                                  // Keep Icon color CONSTANT (or adjust if needed)
                                  color: _profile.goal == Goal.weightLoss
                                      ? Theme.of(context)
                                            .colorScheme
                                            .onPrimary
                                      : Theme.of(context)
                                            .colorScheme
                                            .primary,
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

            const Divider(height: 30),

            // Save Button
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
