import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr'),
  ];

  /// Le titre pour les boîte de dialogue
  ///
  /// In fr, this message translates to:
  /// **'{target, select, legalWarning{Avertissement légale} userGuide{Guide de l\'utilisateur} other{Langue non supportée}}'**
  String appDialogTitle(String target);

  /// Le nom de la langue de l'application
  ///
  /// In fr, this message translates to:
  /// **'{target, select, fr{Français} en{Anglais} other{Langue non supportée}}'**
  String appLanguageName(String target);

  /// No description provided for @appLoadingLbl.
  ///
  /// In fr, this message translates to:
  /// **'Initialisation...'**
  String get appLoadingLbl;

  /// Libellé du bouton de sauvegarde avec contexte
  ///
  /// In fr, this message translates to:
  /// **'Sauvegarder {context}'**
  String appSaveBtn(String context);

  /// Libellé du bouton pour consulter l'historique
  ///
  /// In fr, this message translates to:
  /// **'Voir l\'historique'**
  String get appSeeHistoryBtn;

  /// Titre pour le tableau de bord principal
  ///
  /// In fr, this message translates to:
  /// **'Tableau de bord'**
  String get dashboardScreenTitle;

  /// Message d'erreur lors de la suppression
  ///
  /// In fr, this message translates to:
  /// **'Erreur de suppression'**
  String get errorDelete;

  /// Message affiché lorsqu'une validation de formulaire échoue
  ///
  /// In fr, this message translates to:
  /// **'Erreur dans le formulaire. Veuillez vérifier vos entrées'**
  String get errorForm;

  /// Un message d'erreur global
  ///
  /// In fr, this message translates to:
  /// **'Une erreur s\'est produite'**
  String get errorGlobal;

  /// Message d'erreur lors du chargement d'une ressource
  ///
  /// In fr, this message translates to:
  /// **'Erreur: Impossible de charger le fichier'**
  String get errorLoadingAssets;

  /// Message d'erreur lors du chargement des données
  ///
  /// In fr, this message translates to:
  /// **'Erreur de chargement des données'**
  String get errorLoadingContent;

  /// Message d'erreur pour la lecture d'un fichier
  ///
  /// In fr, this message translates to:
  /// **'{context, select, legalWarning{Erreur: Impossible de lire l\'avertissement légale} userGuide{Erreur: Impossible de lire le guide utilisateur} other{Erreur: Impossible de lire le fichier}}'**
  String errorReadFile(String context);

  /// Titre pour la section de commentaires
  ///
  /// In fr, this message translates to:
  /// **'Commentaire'**
  String get feedbackScreenTitle;

  /// Titre affichant le nombre d'analyses quotidiennes
  ///
  /// In fr, this message translates to:
  /// **'{count, plural, zero{Aucune analyse} one{Analyse (1)} other{Analyses ({count})}}'**
  String homeScreenDailyAnalisisLbl(int count);

  /// Texte pour la suppression d'un élément
  ///
  /// In fr, this message translates to:
  /// **'L\'entrée du {date} a été supprimée de l\'historique'**
  String historyScreenDeleteSuccessLbl(String date);

  /// Titre pour la page de l'historique
  ///
  /// In fr, this message translates to:
  /// **'Historique'**
  String get historyScreenTitle;

  /// Titre pour la section du résumé quotidien
  ///
  /// In fr, this message translates to:
  /// **'Résumé quotidien'**
  String get homeScreenDailySummaryLbl;

  /// Texte pour les statistiques du résumé quotidien
  ///
  /// In fr, this message translates to:
  /// **'sur {stat} g'**
  String homeScreenDailySummaryStatLbl(int stat);

  /// Texte pour les cartes du résumé quotidien
  ///
  /// In fr, this message translates to:
  /// **'{field, select, carbohydrate{Glu} protein{Pro} fat{Lip} other{Stat}}'**
  String homeScreenDailySummaryMacroCardLbl(String field);

  /// Text pour commencer une analyse
  ///
  /// In fr, this message translates to:
  /// **'Analyser un repas'**
  String get homeScreenStartAnalysisBtn;

  /// Titre pour l'écran d'accueil
  ///
  /// In fr, this message translates to:
  /// **'Accueil'**
  String get homeScreenTitle;

  /// Message de bienvenue
  ///
  /// In fr, this message translates to:
  /// **'Bienvenue sur MacroVision'**
  String get homeScreenWelcomeLbl;

  /// No description provided for @initializationScreenDialogDefaultLbl.
  ///
  /// In fr, this message translates to:
  /// **'{target, select, legalWarning{Chargement de l\'avertissement légale...} userGuide{Chargement des instructions...} other{Chargement du contenu...}}'**
  String initializationScreenDialogDefaultLbl(String target);

  /// No description provided for @profileScreenActivityLevelLbl.
  ///
  /// In fr, this message translates to:
  /// **'Niveau d\'activité physique'**
  String get profileScreenActivityLevelLbl;

  /// Sélection du genre de l'utilisateur
  ///
  /// In fr, this message translates to:
  /// **'{target, select, sedentary{Sédentaire (peu ou pas d\'exercice)} lightly{Légèrement actif (1-3 jours/semaine)} moderate{Modérément actif (3-5 jours/semaine)} very{Très actif (6-7 jours/semaine)} extra{Extrêmement actif (2x/jour)} other{Aucun}}'**
  String profileScreenActivityLevelOption(String target);

  /// No description provided for @profileScreenGenderLbl.
  ///
  /// In fr, this message translates to:
  /// **'Sexe'**
  String get profileScreenGenderLbl;

  /// Sélection du genre de l'utilisateur
  ///
  /// In fr, this message translates to:
  /// **'{target, select, male{Homme} female{Femme} other{Autre}}'**
  String profileScreenGenderOption(String target);

  /// No description provided for @profileScreenGoalLbl.
  ///
  /// In fr, this message translates to:
  /// **'Objectif principal'**
  String get profileScreenGoalLbl;

  /// Sélection de l'objectif de forme physique de l'utilisateur
  ///
  /// In fr, this message translates to:
  /// **'{target, select, weightLoss{Perte de poids} muscleGain{Gain musculaire} maintain{Maintien} other{Aucun}}'**
  String profileScreenGoalOption(String target);

  /// Libellé pour la saisie de la taille avec unité
  ///
  /// In fr, this message translates to:
  /// **'Grandeur ({unit})'**
  String profileScreenHeightLbl(String unit);

  /// Libellé dynamique pour les entrées du profil
  ///
  /// In fr, this message translates to:
  /// **'{target, select, weight{Poids ({unit})} height{Grandeur ({unit})} other{{unit}}}'**
  String profileScreenInpLbl(String target, String unit);

  /// Libellé pour le nom de l'utilisateur dans le profil
  ///
  /// In fr, this message translates to:
  /// **'Nom d\'utilisateur'**
  String get profileScreenNameLbl;

  /// Titre pour l'écran de profil
  ///
  /// In fr, this message translates to:
  /// **'Profil'**
  String get profileScreenTitle;

  /// Options pour le système d'unité
  ///
  /// In fr, this message translates to:
  /// **'{unit, select, metric{Métrique} imperial{Impérial} other{Aucun}}'**
  String profileScreenUnitOption(String unit);

  /// Titre pour la préférence du système d'unité
  ///
  /// In fr, this message translates to:
  /// **'Système d\'unité'**
  String get profileScreenUnitSystemLbl;

  /// Libellé pour la saisie du poids avec unité
  ///
  /// In fr, this message translates to:
  /// **'Poids ({unit})'**
  String profileScreenWeightLbl(String unit);

  /// No description provided for @resultScreenEstimatedWeightLbl.
  ///
  /// In fr, this message translates to:
  /// **'Portion estimé par l\'IA : {weight} {unit}'**
  String resultScreenEstimatedWeightLbl(String weight, String unit);

  /// No description provided for @resultScreenAnalysisOutputLbl.
  ///
  /// In fr, this message translates to:
  /// **'{context, select, energy{Énergie} calories{Calories} totalFat{Lipides} saturatedFat{Saturés} transFat{Trans} cholesterol{Cholestérol} sodium{Sodium} potassium{Potassium} totalCarbohydrate{Glucides} dietaryFiber{Fibres} sugar{Sucres} protein{Protéines} other{Nutriments}}'**
  String resultScreenAnalysisOutputLbl(String context);

  /// No description provided for @resultScreenAnalysisSummaryLbl.
  ///
  /// In fr, this message translates to:
  /// **'Analyse nutrionnelle pour {weight} {unit}'**
  String resultScreenAnalysisSummaryLbl(String weight, String unit);

  /// No description provided for @resultScreenNewAnalysisBtn.
  ///
  /// In fr, this message translates to:
  /// **'Analyser une nouvelle photo'**
  String get resultScreenNewAnalysisBtn;

  /// No description provided for @resultScreenPortionLbl.
  ///
  /// In fr, this message translates to:
  /// **'Poid réel ({unit})'**
  String resultScreenPortionLbl(String unit);

  /// No description provided for @resultScreenRefineAnalysisBtn.
  ///
  /// In fr, this message translates to:
  /// **'Ajuster l\'analyse'**
  String get resultScreenRefineAnalysisBtn;

  /// Libellé pour corrigé l'analyse avec le poids et son unité
  ///
  /// In fr, this message translates to:
  /// **'Analyse ajustée pour {weight} ({unit})'**
  String resultScreenRefineAnalysisLbl(String weight, String unit);

  /// No description provided for @resultScreenSwitchLbl.
  ///
  /// In fr, this message translates to:
  /// **'{unit, select, kJ{Afficher en kcal/cal} cal{Afficher en kJ} other{changer d\'unitée}}'**
  String resultScreenSwitchLbl(String unit);

  /// No description provided for @resultScreenTitle.
  ///
  /// In fr, this message translates to:
  /// **'Résultat'**
  String get resultScreenTitle;

  /// Sélection du thème personnalisé pour l'application
  ///
  /// In fr, this message translates to:
  /// **'{color, select, mint{Menthe} ocean{Océan} passion{Passion} neon{Néon} platinum{Platine} merlot{Merlot} lemon{Citron} lime{Lime} peacock{Paon} azure{Azure} candy{Bonbon} pumpkin{Citrouille} lapis{Lapis} scarlet{Écarlate} other{Couleur}}'**
  String settingsScreenCustomThemeOption(String color);

  /// Le titre pour la sélection de la langue
  ///
  /// In fr, this message translates to:
  /// **'Langue'**
  String get settingsScreenLanguageSelectLbl;

  /// Sélection du mode de luminosité de l'application
  ///
  /// In fr, this message translates to:
  /// **'{target, select, default{Défaut du système} light{Mode clair} dark{Mode sombre} other{Aucun}}'**
  String settingsScreenLuminosityOption(String target);

  /// Le titre à afficher selon le contexte des paramètres
  ///
  /// In fr, this message translates to:
  /// **'{target, select, language{Langue de l\'application} luminosity{Luminosité de l\'application} color{Couleurs personnalisées} other{Paramètres}}'**
  String settingsScreenSectionLbl(String target);

  /// Titre pour l'écran des paramètres
  ///
  /// In fr, this message translates to:
  /// **'Paramètres'**
  String get settingsScreenTitle;

  /// Affichage du compte de calories
  ///
  /// In fr, this message translates to:
  /// **'{count, plural, zero{Calorie : 0} one{Calorie : 1} other{Calories : {count}}}'**
  String statsCalorie(int count);

  /// Message de succès après la mise à jour d'un élément spécifique
  ///
  /// In fr, this message translates to:
  /// **'{context, select, profile{Le profile a été mis à jour avec succès} history{L\'historique a été mis à jour avec succès} other{Mise à jour réussie}}'**
  String successUpdate(String context);

  /// Infobulle montrant les deux options d'un interrupteur
  ///
  /// In fr, this message translates to:
  /// **'{option1} ou {option2}'**
  String tooltipSwitch(String option1, String option2);

  /// Un avertissement lorsqu'aucune donnée n'est disponible
  ///
  /// In fr, this message translates to:
  /// **'Aucune données'**
  String get warningEmptyData;

  /// Messages de validation pour les champs de formulaire
  ///
  /// In fr, this message translates to:
  /// **'{target, select, weight{Entrez un poids valide} height{Entrez une grandeur valide} age{Entrez un âge valide} other{Entrée invalide}}'**
  String warningFormValidation(String target);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
