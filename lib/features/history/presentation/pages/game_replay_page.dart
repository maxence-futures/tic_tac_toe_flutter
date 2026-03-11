import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe_flutter/core/extensions/build_context_extension.dart';
import 'package:tic_tac_toe_flutter/core/ui/theme/app_colors.dart';
import 'package:tic_tac_toe_flutter/core/ui/theme/app_durations.dart';
import 'package:tic_tac_toe_flutter/core/ui/theme/app_spacing.dart';
import 'package:tic_tac_toe_flutter/core/ui/widgets/difficulty_badge.dart';
import 'package:tic_tac_toe_flutter/core/ui/widgets/ttt_board_widget.dart';
import 'package:tic_tac_toe_flutter/features/game/domain/entities/game_move.dart';
import 'package:tic_tac_toe_flutter/features/history/domain/entities/game_record.dart';
import 'package:tic_tac_toe_flutter/features/history/presentation/providers/game_replay_notifier.dart';

@RoutePage()
class GameReplayPage extends ConsumerWidget {
  const GameReplayPage({super.key, required this.record});

  final GameRecord record;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final step = ref.watch(gameReplayProvider(record.id));
    final notifier = ref.read(gameReplayProvider(record.id).notifier);
    final board = notifier.boardAt(record.moves, step);
    final winningPositions = notifier.winningPositionsAt(record.moves, step);
    final colors = context.appColors;
    final totalMoves = record.moves.length;

    final (resultColor, resultLabel) = switch (record.result) {
      'win' => (colors.primary, context.locals.historyResultWin),
      'loss' => (colors.error, context.locals.historyResultLoss),
      _ => (colors.textSubtle, context.locals.historyResultDraw),
    };

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: Text(context.locals.replayTitle),
        titleTextStyle: context.textTheme.titleMedium?.copyWith(
          color: colors.text,
        ),
        backgroundColor: colors.background,
        elevation: AppSpacing.elevationNone,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Column(
            children: [
              const SizedBox(height: AppSpacing.md),

              // ---------------------------------------------------------------
              // Header — Player vs CPU + result badge (fixed)
              // ---------------------------------------------------------------
              _ReplayHeader(
                    record: record,
                    resultColor: resultColor,
                    resultLabel: resultLabel,
                  )
                  .animate()
                  .fadeIn(duration: 350.ms)
                  .slideY(begin: -0.15, curve: Curves.easeOut),
              const SizedBox(height: AppSpacing.md),

              // ---------------------------------------------------------------
              // Board — fixed 240 × 240 (fixed)
              // ---------------------------------------------------------------
              Center(
                child:
                    SizedBox(
                          width: 240,
                          height: 240,
                          child: TttBoardWidget(
                            board: board,
                            primaryColor: colors.primary,
                            secondaryColor: colors.secondary,
                            borderColor: colors.border,
                            winningPositions: winningPositions,
                            lastMovePosition: step > 0
                                ? record.moves[step - 1].position
                                : null,
                            animationSeed: step,
                          ),
                        )
                        .animate()
                        .fadeIn(duration: 400.ms, delay: 100.ms)
                        .scale(
                          begin: const Offset(0.92, 0.92),
                          curve: Curves.easeOut,
                        ),
              ),
              const SizedBox(height: AppSpacing.md),

              // ---------------------------------------------------------------
              // Step counter + navigation (fixed)
              // ---------------------------------------------------------------
              _StepCounter(step: step, total: totalMoves),
              const SizedBox(height: AppSpacing.sm),
              _NavControls(
                    onBack: step > 0 ? () => notifier.stepBack() : null,
                    onForward: step < totalMoves
                        ? () => notifier.stepForward(totalMoves)
                        : null,
                    onReset: step > 0 ? () => notifier.jumpTo(0) : null,
                  )
                  .animate()
                  .fadeIn(duration: 400.ms, delay: 200.ms)
                  .slideY(begin: 0.2, curve: Curves.easeOut),
              const SizedBox(height: AppSpacing.md),

              // ---------------------------------------------------------------
              // Move timeline — scrollable, takes remaining space
              // ---------------------------------------------------------------
              Expanded(
                child:
                    _MoveTimeline(
                          moves: record.moves,
                          currentStep: step,
                          primaryColor: colors.primary,
                          secondaryColor: colors.secondary,
                          onTap: (i) => notifier.jumpTo(i + 1),
                        )
                        .animate()
                        .fadeIn(duration: 400.ms, delay: 300.ms)
                        .slideY(begin: 0.2, curve: Curves.easeOut),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Header
// ---------------------------------------------------------------------------

class _ReplayHeader extends StatelessWidget {
  const _ReplayHeader({
    required this.record,
    required this.resultColor,
    required this.resultLabel,
  });

  final GameRecord record;
  final Color resultColor;
  final String resultLabel;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    record.playerName,
                    style: context.textTheme.titleMedium?.copyWith(
                      color: colors.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                    ),
                    child: Text(
                      'vs',
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: colors.textSubtle,
                      ),
                    ),
                  ),
                  Text(
                    'CPU',
                    style: context.textTheme.titleMedium?.copyWith(
                      color: colors.secondary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xs),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.xs,
                ),
                decoration: BoxDecoration(
                  color: resultColor.withValues(alpha: 0.12),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(AppSpacing.radiusFull),
                  ),
                ),
                child: Text(
                  resultLabel,
                  style: context.textTheme.labelSmall?.copyWith(
                    color: resultColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
        // Difficulty + move count
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            DifficultyBadge(difficulty: record.difficulty),
            const SizedBox(height: AppSpacing.xs),
            Text(
              '${record.moves.length} coups',
              style: context.textTheme.labelSmall?.copyWith(
                color: colors.textSubtle,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Step counter
// ---------------------------------------------------------------------------

class _StepCounter extends StatelessWidget {
  const _StepCounter({required this.step, required this.total});

  final int step;
  final int total;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return AnimatedSwitcher(
      duration: context.durations.fast,
      child: Text(
        step == 0
            ? context.locals.replayInitial
            : context.locals.replayStep(step, total),
        key: ValueKey(step),
        style: context.textTheme.titleSmall?.copyWith(color: colors.textSubtle),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Navigation controls
// ---------------------------------------------------------------------------

class _NavControls extends StatelessWidget {
  const _NavControls({
    required this.onBack,
    required this.onForward,
    required this.onReset,
  });

  final VoidCallback? onBack;
  final VoidCallback? onForward;
  final VoidCallback? onReset;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton.outlined(
          onPressed: onReset,
          icon: const Icon(Icons.first_page_rounded),
          tooltip: 'Début',
          color: colors.textSubtle,
        ),
        const SizedBox(width: AppSpacing.sm),
        SizedBox(
          width: 56,
          height: 56,
          child: FilledButton(
            onPressed: onBack,
            style: FilledButton.styleFrom(
              padding: EdgeInsets.zero,
              backgroundColor: onBack != null
                  ? colors.primary
                  : colors.disabled,
            ),
            child: const Icon(Icons.arrow_back_ios_rounded, size: 20),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        SizedBox(
          width: 56,
          height: 56,
          child: FilledButton(
            onPressed: onForward,
            style: FilledButton.styleFrom(
              padding: EdgeInsets.zero,
              backgroundColor: onForward != null
                  ? colors.primary
                  : colors.disabled,
            ),
            child: const Icon(Icons.arrow_forward_ios_rounded, size: 20),
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Move timeline
// ---------------------------------------------------------------------------

class _MoveTimeline extends StatefulWidget {
  const _MoveTimeline({
    required this.moves,
    required this.currentStep,
    required this.primaryColor,
    required this.secondaryColor,
    required this.onTap,
  });

  final List<GameMove> moves;
  final int currentStep;
  final Color primaryColor;
  final Color secondaryColor;
  final void Function(int index) onTap;

  @override
  State<_MoveTimeline> createState() => _MoveTimelineState();
}

class _MoveTimelineState extends State<_MoveTimeline> {
  final _controller = ScrollController();

  // Height of one list item (padding × 2 + content) + separator gap.
  static const double _kItemHeight = 44.0;
  static const double _kSeparatorHeight = AppSpacing.xs;
  static const double _kSlotHeight = _kItemHeight + _kSeparatorHeight;

  @override
  void didUpdateWidget(_MoveTimeline oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentStep != widget.currentStep && widget.currentStep > 0) {
      _scrollToStep(widget.currentStep - 1);
    }
  }

  void _scrollToStep(int index) {
    if (!_controller.hasClients) return;
    final target = (index * _kSlotHeight).clamp(
      0.0,
      _controller.position.maxScrollExtent,
    );
    _controller.animateTo(
      target,
      duration: const AppDurations().slow,
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    if (widget.moves.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.locals.replayTimeline,
          style: context.textTheme.labelMedium?.copyWith(
            color: colors.textSubtle,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Expanded(
          child: ListView.separated(
            controller: _controller,
            itemCount: widget.moves.length,
            separatorBuilder: (_, _) =>
                const SizedBox(height: _kSeparatorHeight),
            itemBuilder: (_, index) => _TimelineItem(
              move: widget.moves[index],
              index: index,
              currentStep: widget.currentStep,
              primaryColor: widget.primaryColor,
              secondaryColor: widget.secondaryColor,
              onTap: widget.onTap,
              itemHeight: _kItemHeight,
            ),
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Timeline item
// ---------------------------------------------------------------------------

class _TimelineItem extends StatelessWidget {
  const _TimelineItem({
    required this.move,
    required this.index,
    required this.currentStep,
    required this.primaryColor,
    required this.secondaryColor,
    required this.onTap,
    required this.itemHeight,
  });

  final GameMove move;
  final int index;
  final int currentStep;
  final Color primaryColor;
  final Color secondaryColor;
  final void Function(int index) onTap;
  final double itemHeight;

  Color _symbolColor() => move.symbol == 'X' ? primaryColor : secondaryColor;

  Color _bgColor(AppColorsTheme colors, Color symbolColor) {
    if (index == currentStep - 1) return symbolColor.withValues(alpha: 0.12);
    if (index < currentStep) return colors.surface;
    return Colors.transparent;
  }

  Color _borderColor(AppColorsTheme colors, Color symbolColor) {
    if (index == currentStep - 1) return symbolColor;
    if (index < currentStep) return colors.border;
    return Colors.transparent;
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final color = _symbolColor();
    final isCurrent = index == currentStep - 1;

    return SizedBox(
      height: itemHeight,
      child: GestureDetector(
        onTap: () => onTap(index),
        child: AnimatedContainer(
          duration: context.durations.fast,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          decoration: BoxDecoration(
            color: _bgColor(colors, color),
            border: Border.all(color: _borderColor(colors, color)),
            borderRadius: const BorderRadius.all(
              Radius.circular(AppSpacing.radiusMd),
            ),
          ),
          child: Row(
            children: [
              Text(
                '${index + 1}.',
                style: context.textTheme.labelMedium?.copyWith(
                  color: colors.textSubtle,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                move.symbol,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: color,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                move.isCpu ? 'CPU' : 'Joueur',
                style: context.textTheme.bodySmall?.copyWith(
                  color: colors.text,
                ),
              ),
              const Spacer(),
              Text(
                'Case ${move.position + 1}',
                style: context.textTheme.labelSmall?.copyWith(
                  color: colors.textSubtle,
                ),
              ),
              if (isCurrent) ...[
                const SizedBox(width: AppSpacing.xs),
                Icon(Icons.arrow_left_rounded, color: color, size: 18),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
