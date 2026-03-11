import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tic_tac_toe_flutter/core/extensions/build_context_extension.dart';
import 'package:tic_tac_toe_flutter/core/router/app_router.dart';
import 'package:tic_tac_toe_flutter/core/ui/theme/app_spacing.dart';
import 'package:tic_tac_toe_flutter/core/ui/widgets/difficulty_badge.dart';
import 'package:tic_tac_toe_flutter/core/ui/widgets/empty_state_widget.dart';
import 'package:tic_tac_toe_flutter/core/ui/widgets/player_avatar.dart';
import 'package:tic_tac_toe_flutter/features/history/domain/entities/game_record.dart';
import 'package:tic_tac_toe_flutter/features/history/presentation/providers/history_providers.dart';

@RoutePage()
class HistoryPage extends ConsumerWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(historyProvider);
    final colors = context.appColors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: Text(context.locals.historyTitle),
        titleTextStyle: context.textTheme.titleMedium?.copyWith(
          color: colors.text,
        ),
        backgroundColor: colors.background,
        elevation: AppSpacing.elevationNone,
        actions: [
          if (state.asData?.value.isNotEmpty ?? false)
            IconButton(
              tooltip: context.locals.historyClearTooltip,
              icon: Icon(Icons.delete_sweep_outlined, color: colors.error),
              onPressed: () => _confirmClearHistory(context, ref),
            ),
        ],
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(e.toString())),
        data: (records) => records.isEmpty
            ? EmptyStateWidget(
                icon: Icons.sports_esports_outlined,
                message: context.locals.historyEmpty,
              )
            : _GameList(records: records),
      ),
    );
  }

  Future<void> _confirmClearHistory(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) {
        final colors = ctx.appColors;
        return AlertDialog(
          backgroundColor: colors.surface,
          title: Text(
            ctx.locals.historyClearDialogTitle,
            style: ctx.textTheme.titleMedium?.copyWith(color: colors.text),
          ),
          content: Text(
            ctx.locals.historyClearDialogBody,
            style: ctx.textTheme.bodyMedium?.copyWith(color: colors.textSubtle),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: Text(MaterialLocalizations.of(ctx).cancelButtonLabel),
            ),
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              child: Text(
                ctx.locals.historyClearConfirm,
                style: TextStyle(color: colors.error),
              ),
            ),
          ],
        );
      },
    );

    if (confirmed ?? false) {
      await ref.read(historyProvider.notifier).clearHistory();
    }
  }
}

// ---------------------------------------------------------------------------
// Game list
// ---------------------------------------------------------------------------

class _GameList extends ConsumerWidget {
  const _GameList({required this.records});

  final List<GameRecord> records;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      padding: const EdgeInsets.all(AppSpacing.lg),
      itemCount: records.length,
      itemBuilder: (_, index) {
        final record = records[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.md),
          child:
              _GameCard(
                    record: record,
                    onTap: () =>
                        context.router.push(GameReplayRoute(record: record)),
                    onDismiss: () => ref
                        .read(historyProvider.notifier)
                        .deleteGame(record.id),
                  )
                  .animate(delay: context.durations.staggerStep * index)
                  .fadeIn(duration: 300.ms)
                  .slideY(begin: 0.15, curve: Curves.easeOut),
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// Game card
// ---------------------------------------------------------------------------

class _GameCard extends StatelessWidget {
  const _GameCard({
    required this.record,
    required this.onTap,
    required this.onDismiss,
  });

  final GameRecord record;
  final VoidCallback onTap;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final (resultColor, resultIcon, resultLabel) = switch (record.result) {
      'win' => (
        colors.primary,
        Icons.emoji_events_rounded,
        context.locals.historyResultWin,
      ),
      'loss' => (
        colors.error,
        Icons.sentiment_dissatisfied_rounded,
        context.locals.historyResultLoss,
      ),
      _ => (
        colors.textSubtle,
        Icons.handshake_outlined,
        context.locals.historyResultDraw,
      ),
    };

    return Dismissible(
      key: ValueKey(record.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDismiss(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: AppSpacing.lg),
        decoration: BoxDecoration(
          color: colors.error.withValues(alpha: 0.15),
          borderRadius: const BorderRadius.all(
            Radius.circular(AppSpacing.radiusLg),
          ),
        ),
        child: Icon(Icons.delete_outline, color: colors.error),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: colors.surface,
            border: Border(left: BorderSide(color: resultColor, width: 4)),
            borderRadius: const BorderRadius.all(
              Radius.circular(AppSpacing.radiusLg),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Row(
              children: [
                // Avatar
                PlayerAvatar(
                  name: record.playerName,
                  backgroundColor: resultColor.withValues(alpha: 0.15),
                  textColor: resultColor,
                ),
                const SizedBox(width: AppSpacing.md),
                // Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              record.playerName,
                              style: context.textTheme.titleSmall?.copyWith(
                                color: colors.text,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          DifficultyBadge(difficulty: record.difficulty),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Row(
                        children: [
                          Icon(resultIcon, size: 14, color: resultColor),
                          const SizedBox(width: AppSpacing.xs),
                          Text(
                            resultLabel,
                            style: context.textTheme.bodySmall?.copyWith(
                              color: resultColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Spacer(),
                          Icon(
                            Icons.swap_horiz_rounded,
                            size: 12,
                            color: colors.textSubtle,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            '${record.moves.length} ${context.locals.historyMoves}',
                            style: context.textTheme.bodySmall?.copyWith(
                              color: colors.textSubtle,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        _formatDate(record.playedAt),
                        style: context.textTheme.labelSmall?.copyWith(
                          color: colors.textSubtle,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Icon(Icons.chevron_right_rounded, color: colors.textSubtle),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime dt) {
    final now = DateTime.now();
    final diff = now.difference(dt);
    if (diff.inDays == 0) return 'Aujourd\'hui ${DateFormat.Hm().format(dt)}';
    if (diff.inDays == 1) return 'Hier ${DateFormat.Hm().format(dt)}';
    return DateFormat('d MMM, HH:mm', 'fr').format(dt);
  }
}
