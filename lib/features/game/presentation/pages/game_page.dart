import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe_flutter/core/extensions/build_context_extension.dart';
import 'package:tic_tac_toe_flutter/core/router/app_router.dart';
import 'package:tic_tac_toe_flutter/core/ui/theme/app_spacing.dart';
import 'package:tic_tac_toe_flutter/core/ui/widgets/ttt_board_widget.dart';
import 'package:tic_tac_toe_flutter/features/game/domain/entities/difficulty.dart';
import 'package:tic_tac_toe_flutter/features/game/domain/entities/game_state.dart';
import 'package:tic_tac_toe_flutter/features/game/domain/entities/game_status.dart';
import 'package:tic_tac_toe_flutter/features/game/presentation/providers/game_notifier.dart';

@RoutePage()
class GamePage extends ConsumerWidget {
  const GamePage({
    super.key,
    required this.playerName,
    required this.difficulty,
  });

  final String playerName;
  final Difficulty difficulty;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(gameProvider(playerName, difficulty));
    final notifier = ref.read(gameProvider(playerName, difficulty).notifier);
    final colors = context.appColors;

    ref.listen(gameProvider(playerName, difficulty), (prev, next) {
      if (prev?.gameStatus is GameStatusPlaying &&
          next.gameStatus is! GameStatusPlaying) {
        _showResultSheet(context, ref, next.gameStatus, notifier.resetGame);
      }
    });

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: Text(context.locals.appTitle),
        titleTextStyle: context.textTheme.titleMedium?.copyWith(
          color: colors.text,
        ),
        backgroundColor: colors.background,
        elevation: AppSpacing.elevationNone,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            children: [
              _GameHeader(
                    playerName: playerName,
                    isCpuThinking: state.isCpuThinking,
                    currentSymbol: state.currentSymbol,
                    primaryColor: colors.primary,
                    secondaryColor: colors.secondary,
                    textSubtleColor: colors.textSubtle,
                  )
                  .animate()
                  .fadeIn(duration: 400.ms)
                  .slideY(begin: -0.2, curve: Curves.easeOut),
              const SizedBox(height: AppSpacing.xl),
              Expanded(
                child: Center(
                  child:
                      TttBoardWidget(
                            board: state.board,
                            winningPositions: state.winningPositions,
                            primaryColor: colors.primary,
                            secondaryColor: colors.secondary,
                            borderColor: colors.border,
                            winningColor: colors.primary,
                            onCellTap: notifier.makeMove,
                          )
                          .animate()
                          .fadeIn(duration: 500.ms, delay: 100.ms)
                          .scale(
                            begin: const Offset(0.9, 0.9),
                            curve: Curves.easeOut,
                          ),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              _StatusBar(state: state)
                  .animate(key: ValueKey(state.gameStatus))
                  .fadeIn(duration: 300.ms)
                  .slideY(begin: 0.3, curve: Curves.easeOut),
            ],
          ),
        ),
      ),
    );
  }

  void _showResultSheet(
    BuildContext context,
    WidgetRef ref,
    GameStatus gameStatus,
    VoidCallback onReplay,
  ) {
    showModalBottomSheet<void>(
      context: context,
      isDismissible: false,
      enableDrag: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSpacing.radiusXl),
        ),
      ),
      builder: (_) => _ResultSheet(
        gameStatus: gameStatus,
        playerName: playerName,
        onReplay: () {
          Navigator.of(context).pop();
          onReplay();
        },
        onHome: () => context.router.replaceAll([const HomeRoute()]),
      ),
    );
  }
}

// ---------------------------------------------------------------------------

class _GameHeader extends StatelessWidget {
  const _GameHeader({
    required this.playerName,
    required this.isCpuThinking,
    required this.currentSymbol,
    required this.primaryColor,
    required this.secondaryColor,
    required this.textSubtleColor,
  });

  final String playerName;
  final bool isCpuThinking;
  final String currentSymbol;
  final Color primaryColor;
  final Color secondaryColor;
  final Color textSubtleColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _ScoreChip(
          label: playerName,
          symbol: 'X',
          isCurrent: currentSymbol == 'X' && !isCpuThinking,
          color: primaryColor,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: Text(
            'vs',
            style: TextStyle(color: textSubtleColor, fontSize: 16),
          ),
        ),
        _ScoreChip(
          label: 'CPU',
          symbol: 'O',
          isCurrent: currentSymbol == 'O' || isCpuThinking,
          color: secondaryColor,
        ),
      ],
    );
  }
}

class _ScoreChip extends StatelessWidget {
  const _ScoreChip({
    required this.label,
    required this.symbol,
    required this.isCurrent,
    required this.color,
  });

  final String label;
  final String symbol;
  final bool isCurrent;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: context.durations.fast,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: isCurrent ? color.withValues(alpha: 0.15) : Colors.transparent,
        border: Border.all(
          color: isCurrent ? color : Colors.transparent,
          width: 2,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSpacing.radiusFull),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            symbol,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),
          const SizedBox(width: AppSpacing.xs),
          Text(label),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------

class _StatusBar extends StatelessWidget {
  const _StatusBar({required this.state});

  final GameState state;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final String text;
    if (state.isCpuThinking) {
      text = context.locals.gameCpuThinking;
    } else if (state.gameStatus is GameStatusPlaying) {
      text = context.locals.gameYourTurn;
    } else {
      text = '';
    }

    if (text.isEmpty) return const SizedBox.shrink();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (state.isCpuThinking) ...[
          SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: colors.secondary,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
        ],
        Text(
          text,
          style: context.textTheme.titleMedium?.copyWith(
            color: colors.textSubtle,
          ),
        ),
      ],
    );
  }
}

class _ResultSheet extends StatelessWidget {
  const _ResultSheet({
    required this.gameStatus,
    required this.playerName,
    required this.onReplay,
    required this.onHome,
  });

  final GameStatus gameStatus;
  final String playerName;
  final VoidCallback onReplay;
  final VoidCallback onHome;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    final (emoji, title, titleColor) = switch (gameStatus) {
      GameStatusWon(:final winner) when winner == 'X' => (
        '🎉',
        context.locals.gameYouWon,
        colors.primary,
      ),
      GameStatusWon() => ('🤖', context.locals.gameCpuWon, colors.secondary),
      GameStatusDraw() => ('🤝', context.locals.gameDraw, colors.textSubtle),
      _ => ('', '', colors.text),
    };

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 48,
            height: 4,
            margin: const EdgeInsets.only(bottom: AppSpacing.lg),
            decoration: BoxDecoration(
              color: colors.border,
              borderRadius: const BorderRadius.all(
                Radius.circular(AppSpacing.radiusFull),
              ),
            ),
          ),
          Text(emoji, style: const TextStyle(fontSize: 64))
              .animate()
              .scale(
                begin: const Offset(0, 0),
                curve: Curves.elasticOut,
                duration: 600.ms,
              )
              .fadeIn(duration: 300.ms),
          const SizedBox(height: AppSpacing.md),
          Text(
            title,
            style: context.textTheme.headlineSmall?.copyWith(
              color: titleColor,
              fontWeight: FontWeight.w800,
            ),
          ).animate().fadeIn(duration: 400.ms, delay: 200.ms),
          const SizedBox(height: AppSpacing.xl),
          SizedBox(
                width: double.infinity,
                height: 52,
                child: FilledButton.icon(
                  onPressed: onReplay,
                  icon: const Icon(Icons.replay_rounded),
                  label: Text(context.locals.gamePlayAgain),
                ),
              )
              .animate()
              .fadeIn(duration: 400.ms, delay: 350.ms)
              .slideY(begin: 0.3),
          const SizedBox(height: AppSpacing.sm),
          SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton.icon(
                  onPressed: onHome,
                  icon: Icon(Icons.home_rounded, color: colors.textSubtle),
                  label: Text(
                    context.locals.gameBackHome,
                    style: TextStyle(color: colors.text),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: colors.border),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(AppSpacing.radiusMd),
                      ),
                    ),
                  ),
                ),
              )
              .animate()
              .fadeIn(duration: 400.ms, delay: 450.ms)
              .slideY(begin: 0.3),
        ],
      ),
    );
  }
}
