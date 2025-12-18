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

  /// Le nom complet de la langue
  ///
  /// In fr, this message translates to:
  /// **'Français'**
  String get nameLanguage;

  /// Le titre pour la sélection de la langue
  ///
  /// In fr, this message translates to:
  /// **'Langue'**
  String get titleLanguageSelect;

  /// Le titre pour le guide d'utilisation
  ///
  /// In fr, this message translates to:
  /// **'Guide d\'utilisation'**
  String get titleUserGuide;

  /// Message de succès après la mise à jour d'un élément spécifique
  ///
  /// In fr, this message translates to:
  /// **'Le {context} a été mis à jour avec succès'**
  String successUpdate(String context);

  /// Un avertissement lorsqu'aucune donnée n'est disponible
  ///
  /// In fr, this message translates to:
  /// **'Aucune données'**
  String get warningEmptyData;

  /// Un message d'erreur global
  ///
  /// In fr, this message translates to:
  /// **'Une erreur s\'est produite'**
  String get errorGlobal;

  /// Message d'erreur pour le guide utilisateur
  ///
  /// In fr, this message translates to:
  /// **'Erreur: Impossible de lire le guide utilisateur'**
  String get errorReadUserGuide;

  /// Message d'erreur lors du chargement d'une ressource
  ///
  /// In fr, this message translates to:
  /// **'Erreur: Impossible de charger le fichier'**
  String get errorLoadingAssets;

  /// Message affiché lorsqu'une validation de formulaire échoue
  ///
  /// In fr, this message translates to:
  /// **'Erreur dans le formulaire. Veuillez vérifier vos entrées'**
  String get errorForm;

  /// Message d'erreur lors du chargement des données
  ///
  /// In fr, this message translates to:
  /// **'Erreur de chargement des données'**
  String get errorLoadingContent;

  /// Le titre à afficher selon le contexte des paramètres
  ///
  /// In fr, this message translates to:
  /// **'{target, select, language{Langue de l\'application} luminosity{Luminosité de l\'application} color{Couleurs personnalisées} other{Paramètres}}'**
  String titleSettingsSections(String target);

  /// Titre affichant le nombre d'analyses quotidiennes
  ///
  /// In fr, this message translates to:
  /// **'{count, plural, zero{Aucune analyse} one{Analyse (1)} other{Analyses ({count})}}'**
  String titleDailyAnalisis(int count);

  /// Titre pour l'écran des paramètres
  ///
  /// In fr, this message translates to:
  /// **'Paramètres'**
  String get titleSettings;

  /// Titre pour l'écran d'historique
  ///
  /// In fr, this message translates to:
  /// **'Historique'**
  String get titleHistory;

  /// Titre pour le tableau de bord principal
  ///
  /// In fr, this message translates to:
  /// **'Tableau de bord'**
  String get titleDashboard;

  /// Titre pour l'écran d'accueil
  ///
  /// In fr, this message translates to:
  /// **'Accueil'**
  String get titleHome;

  /// Titre pour la section caméra
  ///
  /// In fr, this message translates to:
  /// **'Caméra'**
  String get titleCamera;

  /// Titre pour la section de commentaires
  ///
  /// In fr, this message translates to:
  /// **'Commentaire'**
  String get titleFeedback;

  /// Titre pour la section du résumé quotidien
  ///
  /// In fr, this message translates to:
  /// **'Résumé quotidien'**
  String get titleDailySummary;

  /// Libellé du bouton pour consulter l'historique
  ///
  /// In fr, this message translates to:
  /// **'Voir l\'historique'**
  String get titleBtnSeeHistory;

  /// Affichage du compte de calories
  ///
  /// In fr, this message translates to:
  /// **'{count, plural, zero{Calorie : 0} one{Calorie : 1} other{Calories : {count}}}'**
  String statsCalorie(int count);

  /// Titre pour l'écran de profil
  ///
  /// In fr, this message translates to:
  /// **'Profil'**
  String get titleProfile;

  /// Titre pour la préférence du système d'unité
  ///
  /// In fr, this message translates to:
  /// **'Système d\'unité'**
  String get titleProfileUnitSystem;

  /// Infobulle montrant les deux options d'un interrupteur
  ///
  /// In fr, this message translates to:
  /// **'{option1} ou {option2}'**
  String tooltipSwitch(String option1, String option2);

  /// Libellé du bouton de sauvegarde avec contexte
  ///
  /// In fr, this message translates to:
  /// **'Sauvegarder {context}'**
  String titleBtnSave(String context);

  /// Sélection du mode de luminosité de l'application
  ///
  /// In fr, this message translates to:
  /// **'{target, select, default{Défaut du système} light{Mode clair} dark{Mode sombre} other{Aucun}}'**
  String titleSettingsLuminosity(String target);

  /// Libellé pour le nom de l'utilisateur dans le profil
  ///
  /// In fr, this message translates to:
  /// **'Nom'**
  String get titleProfileName;

  /// Sélection de l'objectif de forme physique de l'utilisateur
  ///
  /// In fr, this message translates to:
  /// **'{target, select, weightLoss{Perte de poids} muscleGain{Gain musculaire} maintain{Maintien} other{Maintien}}'**
  String titleProfileGoal(String target);
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
