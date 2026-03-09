import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/extensions/build_context_extension.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/ui/widgets/ttt_board_widget.dart';
import '../../domain/entities/difficulty.dart';
import '../../domain/entities/game_state.dart';
import '../../domain/entities/game_status.dart';
import '../providers/game_notifier.dart';
import '../widgets/cell_widget.dart';

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
      if (prev?.status is GameStatusPlaying &&
          next.status is! GameStatusPlaying) {
        _showResultSheet(context, ref, next.status, notifier.resetGame);
      }
    });

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: Text(context.locals.appTitle),
        backgroundColor: colors.background,
        elevation: AppSpacing.elevationNone,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            children: [
              GameHeaderWidget(
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
                  .animate(key: ValueKey(state.status))
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
    GameStatus status,
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
        status: status,
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

class _StatusBar extends StatelessWidget {
  const _StatusBar({required this.state});

  final GameState state;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final text = state.isCpuThinking
        ? context.locals.gameCpuThinking
        : state.status is GameStatusPlaying
        ? context.locals.gameYourTurn
        : '';

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
    required this.status,
    required this.playerName,
    required this.onReplay,
    required this.onHome,
  });

  final GameStatus status;
  final String playerName;
  final VoidCallback onReplay;
  final VoidCallback onHome;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    final (emoji, title, titleColor) = switch (status) {
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
