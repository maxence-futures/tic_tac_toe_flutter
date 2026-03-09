import 'package:flutter/material.dart';

import '../../../features/game/domain/entities/difficulty.dart';
import '../../extensions/build_context_extension.dart';
import '../../theme/app_spacing.dart';

/// A coloured pill badge displaying a [Difficulty] level.
///
/// Colours follow the app's semantic palette:
///   easy → primary,  medium → secondary,  hard → error.
class DifficultyBadge extends StatelessWidget {
  const DifficultyBadge({super.key, required this.difficulty});

  final Difficulty difficulty;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    final color = switch (difficulty) {
      Difficulty.easy => colors.primary,
      Difficulty.medium => colors.secondary,
      Difficulty.hard => colors.error,
    };
    final label = switch (difficulty) {
      Difficulty.easy => context.locals.difficultyEasy,
      Difficulty.medium => context.locals.difficultyMedium,
      Difficulty.hard => context.locals.difficultyHard,
    };

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius:
            const BorderRadius.all(Radius.circular(AppSpacing.radiusFull)),
      ),
      child: Text(
        label,
        style: context.textTheme.labelSmall?.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
