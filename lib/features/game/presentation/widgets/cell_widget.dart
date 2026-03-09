import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';

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
      duration: const Duration(milliseconds: 200),
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

class GameHeaderWidget extends StatelessWidget {
  const GameHeaderWidget({
    super.key,
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
