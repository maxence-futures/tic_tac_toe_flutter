// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Tic Tac Toe';

  @override
  String get homeVersus => 'vs';

  @override
  String get homeStartGame => 'Start a game';

  @override
  String get homeHistory => 'Game history';

  @override
  String get playerSetupTitle => 'Choose a profile';

  @override
  String get playerSetupChooseProfile => 'Select your profile';

  @override
  String get playerSetupNewProfile => 'New profile';

  @override
  String get playerSetupNameHint => 'Your name';

  @override
  String get playerSetupContinue => 'Continue';

  @override
  String get playerSetupNoProfiles => 'No profiles saved';

  @override
  String get difficultyTitle => 'Difficulty level';

  @override
  String get difficultySubtitle => 'Choose your opponent';

  @override
  String get difficultyEasy => 'Easy';

  @override
  String get difficultyEasyDesc =>
      'The CPU plays randomly — great for beginners.';

  @override
  String get difficultyMedium => 'Medium';

  @override
  String get difficultyMediumDesc =>
      'The CPU mixes strategy with random moves.';

  @override
  String get difficultyHard => 'Hard';

  @override
  String get difficultyHardDesc => 'The CPU plays perfectly — unbeatable!';

  @override
  String get difficultyStart => 'Start game';

  @override
  String get gameYourTurn => 'Your turn';

  @override
  String get gameCpuThinking => 'CPU is thinking…';

  @override
  String get gameYouWon => 'You won!';

  @override
  String get gameCpuWon => 'CPU won!';

  @override
  String get gameDraw => 'It\'s a draw!';

  @override
  String get gamePlayAgain => 'Play again';

  @override
  String get gameBackHome => 'Back to home';

  @override
  String get historyTitle => 'Game history';

  @override
  String get historyEmpty => 'No games played yet';

  @override
  String get historyResultWin => 'Victory';

  @override
  String get historyResultLoss => 'Defeat';

  @override
  String get historyResultDraw => 'Draw';

  @override
  String get historyMoves => 'moves';

  @override
  String get historyClearTooltip => 'Clear history';

  @override
  String get historyClearDialogTitle => 'Clear history?';

  @override
  String get historyClearDialogBody => 'All games will be permanently deleted.';

  @override
  String get historyClearConfirm => 'Clear';

  @override
  String get replayTitle => 'Game replay';

  @override
  String get replayInitial => 'Empty board — press → to start';

  @override
  String replayStep(int step, int total) {
    return 'Move $step of $total';
  }

  @override
  String get replayTimeline => 'Move timeline';
}
