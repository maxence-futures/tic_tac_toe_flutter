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

  /// Titre de l'application
  ///
  /// In fr, this message translates to:
  /// **'Tic Tac Toe'**
  String get appTitle;

  /// Séparateur entre les deux joueurs
  ///
  /// In fr, this message translates to:
  /// **'vs'**
  String get homeVersus;

  /// Bouton pour démarrer une nouvelle partie
  ///
  /// In fr, this message translates to:
  /// **'Lancer une partie'**
  String get homeStartGame;

  /// Accès à l'historique
  ///
  /// In fr, this message translates to:
  /// **'Historique des parties'**
  String get homeHistory;

  /// Titre de la page de sélection de profil
  ///
  /// In fr, this message translates to:
  /// **'Choisir un profil'**
  String get playerSetupTitle;

  /// Sous-titre
  ///
  /// In fr, this message translates to:
  /// **'Sélectionnez votre profil'**
  String get playerSetupChooseProfile;

  /// Bouton créer un profil
  ///
  /// In fr, this message translates to:
  /// **'Nouveau profil'**
  String get playerSetupNewProfile;

  /// Placeholder du champ nom
  ///
  /// In fr, this message translates to:
  /// **'Votre prénom'**
  String get playerSetupNameHint;

  /// Bouton continuer
  ///
  /// In fr, this message translates to:
  /// **'Continuer'**
  String get playerSetupContinue;

  /// Message liste vide
  ///
  /// In fr, this message translates to:
  /// **'Aucun profil enregistré'**
  String get playerSetupNoProfiles;

  /// Titre de la page difficulté
  ///
  /// In fr, this message translates to:
  /// **'Niveau de difficulté'**
  String get difficultyTitle;

  /// Sous-titre
  ///
  /// In fr, this message translates to:
  /// **'Choisissez votre adversaire'**
  String get difficultySubtitle;

  /// Niveau facile
  ///
  /// In fr, this message translates to:
  /// **'Facile'**
  String get difficultyEasy;

  /// Description niveau facile
  ///
  /// In fr, this message translates to:
  /// **'Le CPU joue au hasard — parfait pour débuter.'**
  String get difficultyEasyDesc;

  /// Niveau moyen
  ///
  /// In fr, this message translates to:
  /// **'Moyen'**
  String get difficultyMedium;

  /// Description niveau moyen
  ///
  /// In fr, this message translates to:
  /// **'Le CPU alterne stratégie et coups aléatoires.'**
  String get difficultyMediumDesc;

  /// Niveau difficile
  ///
  /// In fr, this message translates to:
  /// **'Difficile'**
  String get difficultyHard;

  /// Description niveau difficile
  ///
  /// In fr, this message translates to:
  /// **'Le CPU joue parfaitement — imbattable !'**
  String get difficultyHardDesc;

  /// Bouton lancer
  ///
  /// In fr, this message translates to:
  /// **'Lancer la partie'**
  String get difficultyStart;

  /// Statut tour joueur
  ///
  /// In fr, this message translates to:
  /// **'À votre tour'**
  String get gameYourTurn;

  /// Statut tour CPU
  ///
  /// In fr, this message translates to:
  /// **'Le CPU réfléchit…'**
  String get gameCpuThinking;

  /// Résultat victoire
  ///
  /// In fr, this message translates to:
  /// **'Vous avez gagné !'**
  String get gameYouWon;

  /// Résultat défaite
  ///
  /// In fr, this message translates to:
  /// **'Le CPU a gagné !'**
  String get gameCpuWon;

  /// Résultat nul
  ///
  /// In fr, this message translates to:
  /// **'Match nul !'**
  String get gameDraw;

  /// Bouton rejouer
  ///
  /// In fr, this message translates to:
  /// **'Rejouer'**
  String get gamePlayAgain;

  /// Bouton retour accueil
  ///
  /// In fr, this message translates to:
  /// **'Retour à l\'accueil'**
  String get gameBackHome;

  /// Titre de la page historique
  ///
  /// In fr, this message translates to:
  /// **'Historique des parties'**
  String get historyTitle;

  /// Message liste vide
  ///
  /// In fr, this message translates to:
  /// **'Aucune partie jouée pour l\'instant'**
  String get historyEmpty;

  /// Résultat victoire
  ///
  /// In fr, this message translates to:
  /// **'Victoire'**
  String get historyResultWin;

  /// Résultat défaite
  ///
  /// In fr, this message translates to:
  /// **'Défaite'**
  String get historyResultLoss;

  /// Résultat nul
  ///
  /// In fr, this message translates to:
  /// **'Match nul'**
  String get historyResultDraw;

  /// Unité nombre de coups
  ///
  /// In fr, this message translates to:
  /// **'coups'**
  String get historyMoves;

  /// Titre de la page replay
  ///
  /// In fr, this message translates to:
  /// **'Déroulé de la partie'**
  String get replayTitle;

  /// Texte étape initiale
  ///
  /// In fr, this message translates to:
  /// **'Plateau vide — appuyez sur → pour commencer'**
  String get replayInitial;

  /// Indicateur de progression
  ///
  /// In fr, this message translates to:
  /// **'Coup {step} sur {total}'**
  String replayStep(int step, int total);

  /// Titre de la timeline
  ///
  /// In fr, this message translates to:
  /// **'Chronologie des coups'**
  String get replayTimeline;
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
