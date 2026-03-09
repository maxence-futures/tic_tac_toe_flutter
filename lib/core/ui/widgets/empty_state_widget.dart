import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../extensions/build_context_extension.dart';
import '../../theme/app_spacing.dart';

/// A centred icon + message widget for empty screens.
///
/// Pass an optional [action] (e.g. a `FilledButton`) to display below the
/// message.
class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({
    super.key,
    required this.icon,
    required this.message,
    this.action,
    this.iconSize = 64,
  });

  final IconData icon;
  final String message;
  final Widget? action;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: iconSize, color: colors.textSubtle),
          const SizedBox(height: AppSpacing.md),
          Text(
            message,
            style: context.textTheme.bodyLarge
                ?.copyWith(color: colors.textSubtle),
            textAlign: TextAlign.center,
          ),
          if (action != null) ...[
            const SizedBox(height: AppSpacing.md),
            action!,
          ],
        ],
      )
          .animate()
          .fadeIn(duration: 400.ms)
          .scale(begin: const Offset(0.9, 0.9)),
    );
  }
}
