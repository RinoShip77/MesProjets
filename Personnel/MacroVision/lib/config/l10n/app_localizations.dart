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

  /// Un message d'erreur global
  ///
  /// In fr, this message translates to:
  /// **'Une erreur s\'est produite'**
  String get appError;

  /// Message d'erreur lors de la suppression
  ///
  /// In fr, this message translates to:
  /// **'Erreur de suppression'**
  String get appErrorDelete;

  /// Message affiché lorsqu'une validation de formulaire échoue
  ///
  /// In fr, this message translates to:
  /// **'Erreur dans le formulaire. Veuillez vérifier vos entrées'**
  String get appErrorForm;

  /// Message d'erreur lors du chargement d'une ressource
  ///
  /// In fr, this message translates to:
  /// **'Erreur: Impossible de charger le fichier'**
  String get appErrorLoadingAssets;

  /// Message d'erreur lors du chargement des données
  ///
  /// In fr, this message translates to:
  /// **'Erreur de chargement des données'**
  String get appErrorLoadingContent;

  /// Message d'erreur pour la lecture d'un fichier
  ///
  /// In fr, this message translates to:
  /// **'{context, select, legalWarning{Erreur: Impossible de lire l\'avertissement légale} userGuide{Erreur: Impossible de lire le guide utilisateur} other{Erreur: Impossible de lire le fichier}}'**
  String appErrorReadFile(String context);

  /// Le nom de la langue de l'application
  ///
  /// In fr, this message translates to:
  /// **'{target, select, fr{Français} en{Anglais} other{Langue non supportée}}'**
  String appLanguageName(String target);

  /// Libellé affiché pendant l'initialisation de l'application
  ///
  /// In fr, this message translates to:
  /// **'Initialisation...'**
  String get appLoadingLbl;

  /// Libellé pour l'action de rafraîchissement des données
  ///
  /// In fr, this message translates to:
  /// **'Rafraîchir les données'**
  String get appRefreshDataLbl;

  /// Libellé du bouton pour consulter l'historique
  ///
  /// In fr, this message translates to:
  /// **'Voir l\'historique'**
  String get appSeeHistoryBtn;

  /// Message de succès après la mise à jour d'un élément spécifique
  ///
  /// In fr, this message translates to:
  /// **'{context, select, profile{Le profile a été mis à jour avec succès} history{L\'historique a été mis à jour avec succès} other{Mise à jour réussie}}'**
  String appSuccessUpdate(String context);

  /// Libellé pour la section du résumé
  ///
  /// In fr, this message translates to:
  /// **'{duration, select, daily{Résumé quotidion} weekly{Résumé hebdomadaire} other{}}'**
  String appSummaryLbl(String duration);

  /// Libellé pour le nom de l'utilisateur
  ///
  /// In fr, this message translates to:
  /// **'Nom d\'utilisateur'**
  String get appUserNameInpLbl;

  /// Un avertissement lorsqu'aucune donnée n'est disponible
  ///
  /// In fr, this message translates to:
  /// **'Aucune données'**
  String get appWarningEmptyData;

  /// Messages de validation pour les champs de formulaire
  ///
  /// In fr, this message translates to:
  /// **'{target, select, weight{Entrez un poids valide} height{Entrez une grandeur valide} age{Entrez un âge valide} comment{Veuillez saisir votre commentaire} other{Entrée invalide}}'**
  String appWarningFormValidation(String target);

  /// Libellé du bouton de sauvegarde avec contexte
  ///
  /// In fr, this message translates to:
  /// **'Sauvegarder {context}'**
  String btnSaveLbl(String context);

  /// Libellé du bouton pour consulter l'historique
  ///
  /// In fr, this message translates to:
  /// **'Voir l\'historique'**
  String get btnSeeHistoryLbl;

  /// Message indiquant que l'analyse de l'image est en cours
  ///
  /// In fr, this message translates to:
  /// **'Analyse en cours par l\'IA...'**
  String get cameraScreenAnalysisInProgressLbl;

  /// Libellés des boutons de l'écran caméra
  ///
  /// In fr, this message translates to:
  /// **'{context, select, flash{Basculement du flash} gallery{Sélectionner une image depuis la galerie} camera{Prendre une photo} other{Caméra}}'**
  String cameraScreenBtn(String context);

  /// Message pour la fenêtre de dialogue
  ///
  /// In fr, this message translates to:
  /// **'Confirmer les valeurs'**
  String get cameraScreenConfirmFactsLbl;

  /// Messages d'erreur liés à l'utilisation de la caméra
  ///
  /// In fr, this message translates to:
  /// **'{type, select, initialization{Erreur d\'initialisation de la caméra} flash{Erreur lors du basculement du flash} capture{Erreur de capture} analysis{Erreur d\'analyse} permissions{Impossible d\'accéder à la caméra. Vérifiez les permissions de l\'application} other{Erreur dde caméra}}'**
  String cameraScreenErrors(String type);

  /// Titre de l'écran d'analyse par caméra
  ///
  /// In fr, this message translates to:
  /// **'Analyse alimentaire'**
  String get cameraScreenTitle;

  /// Conseil visuel pour l'utilisateur sur l'écran caméra
  ///
  /// In fr, this message translates to:
  /// **'Conseil : Ciblez un aliment à la fois, avec une bonne lumière'**
  String get cameraScreenVisualHintLbl;

  /// Options pour le type de graphique dans le tableau de bord
  ///
  /// In fr, this message translates to:
  /// **'{type, select, bars{Barres} lines{Lignes} other{Graphique}}'**
  String dashboardScreenChartTypeOption(String type);

  /// Libellés pour les objectifs nutritionnels quotidiens
  ///
  /// In fr, this message translates to:
  /// **'{target, select, calories{Calories} protein{Protéines} totalFat{Lipides} totalCarbohydrate{Glucides} other{Nutriments}}'**
  String dashboardScreenDailyObjectiveLbl(String target);

  /// Titre de la section des objectifs quotidiens
  ///
  /// In fr, this message translates to:
  /// **'Objectifs du jour'**
  String get dashboardScreenDailyObjectivesLbl;

  /// Un avertissement lorsque l'historique est insuffisant
  ///
  /// In fr, this message translates to:
  /// **'Historique insuffisant pour le graphique'**
  String get dashboardScreenNotEnoughDataLbl;

  /// Instruction pour choisir le type de graphique
  ///
  /// In fr, this message translates to:
  /// **'Afficher les données dans un graphiques à barres ou à lignes'**
  String get dashboardScreenSelectChartTypeLbl;

  /// Titre pour le tableau de bord principal
  ///
  /// In fr, this message translates to:
  /// **'Tableau de bord'**
  String get dashboardScreenTitle;

  /// Titre du résumé des calories sur la semaine
  ///
  /// In fr, this message translates to:
  /// **'Résumé hebdomadaire (Calories)'**
  String get dashboardScreenWeeklySummaryLbl;

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

  /// Message d'erreur pour le guide utilisateur
  ///
  /// In fr, this message translates to:
  /// **'Erreur: Impossible de lire le guide utilisateur'**
  String get errorReadUserGuide;

  /// Libellé pour les détails de l'erreur
  ///
  /// In fr, this message translates to:
  /// **'Détails (visible en mode Débogage) :'**
  String get errorScreenDetailsLbl;

  /// Libellé du bouton pour aller à un écran donné
  ///
  /// In fr, this message translates to:
  /// **'{target, select, comment{Soumettre un commentaire} restart{Redémarrer l\'application} other {}}'**
  String errorScreenGoToBtn(String target);

  /// Titre pour la page d'erreur
  ///
  /// In fr, this message translates to:
  /// **'Erreur'**
  String get errorScreenTitle;

  /// Message d'incice pour l'espace commentaire
  ///
  /// In fr, this message translates to:
  /// **'Décrivez votre expérience, signalez un bug ou proposez une idée...'**
  String get feedbackScreenCommentHintLbl;

  /// Message temporaire pour l'espace commentaire
  ///
  /// In fr, this message translates to:
  /// **'Votre message ...'**
  String get feedbackScreenCommentPaceholderLbl;

  /// Message d'information
  ///
  /// In fr, this message translates to:
  /// **'J\'apprécie vos retours ! Aidez-moi à améliorer MacroVision'**
  String get feedbackScreenEncouragingMessageLbl;

  /// Message d'erreur lors de l'ouverture de l'application de messagerie
  ///
  /// In fr, this message translates to:
  /// **'Impossible d\'ouvrir l\'application d\'e-mail'**
  String get feedbackScreenNoEmailClientLbl;

  /// Message d'erreur lors de la lecture de l'adresse email
  ///
  /// In fr, this message translates to:
  /// **'L\'adresse e-mail de feedback est manquante'**
  String get feedbackScreenNoRecipientEmailLbl;

  /// Message d'information pour le lien 'mailto:'
  ///
  /// In fr, this message translates to:
  /// **'Ouverture de l\'application de messagerie'**
  String get feedbackScreenOpeningEmailLbl;

  /// Libellé du bouton de succès pour l'envoie du commentaire
  ///
  /// In fr, this message translates to:
  /// **'{state, select, true{Envoi en cours...} false{Envoyer la rétroaction} other{}}'**
  String feedbackScreenSendBtn(String state);

  /// Libellé du bouton pour la copie du commentaire
  ///
  /// In fr, this message translates to:
  /// **'Envoyer mon message vers le presse-papiers'**
  String get feedbackScreenSendToClipboard;

  /// Libellé du bouton de succès pour l'envoie du commentaire
  ///
  /// In fr, this message translates to:
  /// **'Envoyer la rétroaction'**
  String get feedbackScreenSendTooltip;

  /// Libellé du bouton de succès pour la copie
  ///
  /// In fr, this message translates to:
  /// **'{context, select, comment{Commentaire envoyé dans le presse-papiers} email{Adresse courriel envoyé dans le presse-papiers} other{Envoyé dans le presse-papiers}}'**
  String feedbackScreenSendedToClipboard(String context);

  /// Message d'erreur lors de l'envoi de commentaire
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors de l\'envoi du feedback'**
  String get feedbackScreenSendingError;

  /// Titre pour la section de commentaires
  ///
  /// In fr, this message translates to:
  /// **'Commentaire'**
  String get feedbackScreenTitle;

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

  /// Titre affichant le nombre d'analyses quotidiennes
  ///
  /// In fr, this message translates to:
  /// **'{count, plural, zero{Aucune analyse} one{Analyse (1)} other{Analyses ({count})}}'**
  String homeScreenDailyAnalisisLbl(int count);

  /// Texte pour les cartes du résumé quotidien
  ///
  /// In fr, this message translates to:
  /// **'{field, select, carbohydrate{Glucides} protein{Protéines} fat{Lipides} other{Nutriments}}'**
  String homeScreenDailySummaryMacroCardLbl(String field);

  /// Texte pour les statistiques du résumé quotidien
  ///
  /// In fr, this message translates to:
  /// **'sur {stat} g'**
  String homeScreenDailySummaryStatLbl(int stat);

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

  /// Message par défaut lors de l'initialisation
  ///
  /// In fr, this message translates to:
  /// **'{target, select, legalWarning{Chargement de l\'avertissement légale...} userGuide{Chargement des instructions...} other{Chargement du contenu...}}'**
  String initializationScreenDialogDefaultLbl(String target);

  /// Libellé pour le champ du niveau d'activité physique
  ///
  /// In fr, this message translates to:
  /// **'Niveau d\'activité physique'**
  String get profileScreenActivityLevelInpLbl;

  /// Options pour le niveau d'activité physique
  ///
  /// In fr, this message translates to:
  /// **'{target, select, sedentary{Sédentaire (peu ou pas d\'exercice)} lightly{Légèrement actif (1-3 jours/semaine)} moderate{Modérément actif (3-5 jours/semaine)} very{Très actif (6-7 jours/semaine)} extra{Extrêmement actif (2x/jour)} other{Aucun}}'**
  String profileScreenActivityLevelOption(String target);

  /// Libellé pour le champ du sexe de l'utilisateur
  ///
  /// In fr, this message translates to:
  /// **'Sexe'**
  String get profileScreenGenderInpLbl;

  /// Sélection du genre de l'utilisateur
  ///
  /// In fr, this message translates to:
  /// **'{target, select, male{Homme} female{Femme} other{Autre}}'**
  String profileScreenGenderOption(String target);

  /// Libellé pour le champ de l'objectif principal
  ///
  /// In fr, this message translates to:
  /// **'Objectif principal'**
  String get profileScreenGoalInpLbl;

  /// Sélection de l'objectif de forme physique de l'utilisateur
  ///
  /// In fr, this message translates to:
  /// **'{target, select, weightLoss{Perte de poids} muscleGain{Gain musculaire} maintain{Maintien} other{Aucun}}'**
  String profileScreenGoalOption(String target);

  /// Libellé dynamique pour les entrées du profil
  ///
  /// In fr, this message translates to:
  /// **'{target, select, weight{Poids ({unit})} height{Grandeur ({unit})} other{Âge}}'**
  String profileScreenInpLbl(String target, String unit);

  /// Libellé du bouton de sauvegarde avec contexte
  ///
  /// In fr, this message translates to:
  /// **'Sauvegarder le profil'**
  String get profileScreenSaveBtn;

  /// Titre pour l'écran de profil
  ///
  /// In fr, this message translates to:
  /// **'Profil'**
  String get profileScreenTitle;

  /// Infobulle montrant les deux options d'un interrupteur
  ///
  /// In fr, this message translates to:
  /// **'Métrique (kg, cm) ou Impérial (lb, in)'**
  String get profileScreenUnitSystemSwitch;

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

  /// Libellés des nutriments dans les résultats d'analyse
  ///
  /// In fr, this message translates to:
  /// **'{context, select, energy{Énergie} calories{Calories} totalFat{Lipides} saturatedFat{Saturés} transFat{Trans} cholesterol{Cholestérol} sodium{Sodium} potassium{Potassium} carbohydrate{Glucides} fiber{Fibres} sugar{Sucres} protein{Protéines} other{Nutriments}}'**
  String resultScreenAnalysisOutputLbl(String context);

  /// Titre du résumé de l'analyse avec poids et unité
  ///
  /// In fr, this message translates to:
  /// **'Analyse nutrionnelle pour {weight} {unit}'**
  String resultScreenAnalysisSummaryLbl(String weight, String unit);

  /// Poids de la portion tel qu'estimé par l'intelligence artificielle
  ///
  /// In fr, this message translates to:
  /// **'Portion estimé par l\'IA : {weight} {unit}'**
  String resultScreenEstimatedWeightLbl(String weight, String unit);

  /// Libellé du bouton pour recommencer une analyse
  ///
  /// In fr, this message translates to:
  /// **'Analyser une nouvelle photo'**
  String get resultScreenNewAnalysisBtn;

  /// Libellé pour la saisie du poids réel
  ///
  /// In fr, this message translates to:
  /// **'Poid réel ({unit})'**
  String resultScreenPortionLbl(String unit);

  /// Libellé du bouton pour affiner l'analyse
  ///
  /// In fr, this message translates to:
  /// **'Ajuster l\'analyse'**
  String get resultScreenRefineAnalysisBtn;

  /// Libellé pour corrigé l'analyse avec le poids et son unité
  ///
  /// In fr, this message translates to:
  /// **'Analyse ajustée pour {weight} ({unit})'**
  String resultScreenRefineAnalysisLbl(String weight, String unit);

  /// Libellé pour changer l'unité d'énergie affichée
  ///
  /// In fr, this message translates to:
  /// **'{unit, select, kJ{Afficher en kcal/cal} cal{Afficher en kJ} other{changer d\'unitée}}'**
  String resultScreenSwitchLbl(String unit);

  /// Titre de l'écran des résultats
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
