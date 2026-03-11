// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Tic Tac Toe';

  @override
  String get homeVersus => 'vs';

  @override
  String get homeStartGame => 'Lancer une partie';

  @override
  String get homeHistory => 'Historique des parties';

  @override
  String get playerSetupTitle => 'Choisir un profil';

  @override
  String get playerSetupChooseProfile => 'Sélectionnez votre profil';

  @override
  String get playerSetupNewProfile => 'Nouveau profil';

  @override
  String get playerSetupNameHint => 'Votre prénom';

  @override
  String get playerSetupContinue => 'Continuer';

  @override
  String get playerSetupNoProfiles => 'Aucun profil enregistré';

  @override
  String get difficultyTitle => 'Niveau de difficulté';

  @override
  String get difficultySubtitle => 'Choisissez votre adversaire';

  @override
  String get difficultyEasy => 'Facile';

  @override
  String get difficultyEasyDesc =>
      'Le CPU joue au hasard — parfait pour débuter.';

  @override
  String get difficultyMedium => 'Moyen';

  @override
  String get difficultyMediumDesc =>
      'Le CPU alterne stratégie et coups aléatoires.';

  @override
  String get difficultyHard => 'Difficile';

  @override
  String get difficultyHardDesc => 'Le CPU joue parfaitement — imbattable !';

  @override
  String get difficultyStart => 'Lancer la partie';

  @override
  String get gameYourTurn => 'À votre tour';

  @override
  String get gameCpuThinking => 'Le CPU réfléchit…';

  @override
  String get gameYouWon => 'Vous avez gagné !';

  @override
  String get gameCpuWon => 'Le CPU a gagné !';

  @override
  String get gameDraw => 'Match nul !';

  @override
  String get gamePlayAgain => 'Rejouer';

  @override
  String get gameBackHome => 'Retour à l\'accueil';

  @override
  String get historyTitle => 'Historique des parties';

  @override
  String get historyEmpty => 'Aucune partie jouée pour l\'instant';

  @override
  String get historyResultWin => 'Victoire';

  @override
  String get historyResultLoss => 'Défaite';

  @override
  String get historyResultDraw => 'Match nul';

  @override
  String get historyMoves => 'coups';

  @override
  String get historyClearTooltip => 'Vider l\'historique';

  @override
  String get historyClearDialogTitle => 'Vider l\'historique ?';

  @override
  String get historyClearDialogBody =>
      'Toutes les parties seront supprimées définitivement.';

  @override
  String get historyClearConfirm => 'Vider';

  @override
  String get replayTitle => 'Déroulé de la partie';

  @override
  String get replayInitial => 'Plateau vide — appuyez sur → pour commencer';

  @override
  String replayStep(int step, int total) {
    return 'Coup $step sur $total';
  }

  @override
  String get replayTimeline => 'Chronologie des coups';
}
