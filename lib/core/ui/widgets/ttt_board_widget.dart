import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// A 3×3 Tic-Tac-Toe board used in both game play and replay.
///
/// **Interactive mode** (game play):
///   - Provide [onCellTap]; tapping an empty cell calls it with the cell index.
///   - Pass [winningPositions] + [winningColor] to highlight the winning line.
///
/// **Read-only mode** (replay):
///   - Omit [onCellTap].
///   - Set [lastMovePosition] to highlight the most-recently played cell.
///   - Increment [animationSeed] on each step to re-trigger symbol animations.
class TttBoardWidget extends StatelessWidget {
  const TttBoardWidget({
    super.key,
    required this.board,
    required this.primaryColor,
    required this.secondaryColor,
    required this.borderColor,
    this.winningPositions = const [],
    this.winningColor,
    this.lastMovePosition,
    this.onCellTap,
    this.animationSeed = 0,
  });

  final List<String?> board;
  final Color primaryColor;
  final Color secondaryColor;
  final Color borderColor;

  /// Positions forming the winning line — highlighted with [winningColor].
  final List<int> winningPositions;
  final Color? winningColor;

  /// Most-recently played cell index — highlighted with a coloured border/tint.
  final int? lastMovePosition;

  /// Tap handler. [null] makes the board read-only.
  final void Function(int)? onCellTap;

  /// Increment this value to force symbol animations to re-trigger
  /// (e.g. pass the replay step index so every step re-animates the board).
  /// Default 0 means symbols animate only on first appearance.
  final int animationSeed;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemCount: 9,
        itemBuilder: (_, index) => _TttCell(
          index: index,
          symbol: board[index],
          primaryColor: primaryColor,
          secondaryColor: secondaryColor,
          borderColor: borderColor,
          isWinning: winningPositions.contains(index),
          winningColor: winningColor,
          isLastMove: index == lastMovePosition,
          animationSeed: animationSeed,
          onTap: onCellTap != null ? () => onCellTap!(index) : null,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Internal cell — not exported.
// ---------------------------------------------------------------------------

class _TttCell extends StatelessWidget {
  const _TttCell({
    required this.index,
    required this.symbol,
    required this.primaryColor,
    required this.secondaryColor,
    required this.borderColor,
    required this.isWinning,
    required this.winningColor,
    required this.isLastMove,
    required this.animationSeed,
    required this.onTap,
  });

  final int index;
  final String? symbol;
  final Color primaryColor;
  final Color secondaryColor;
  final Color borderColor;
  final bool isWinning;
  final Color? winningColor;
  final bool isLastMove;
  final int animationSeed;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final symbolColor = symbol == 'X' ? primaryColor : secondaryColor;

    final cellBorderColor = isLastMove ? symbolColor : borderColor;
    final cellBorderWidth = isLastMove ? 2.5 : 1.5;
    final cellBgColor = isWinning
        ? (winningColor ?? primaryColor).withValues(alpha: 0.15)
        : isLastMove
        ? symbolColor.withValues(alpha: 0.1)
        : Colors.transparent;

    return GestureDetector(
      onTap: symbol == null ? onTap : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        decoration: BoxDecoration(
          color: cellBgColor,
          border: Border.all(color: cellBorderColor, width: cellBorderWidth),
        ),
        child: Center(
          child: symbol != null
              ? Text(
                      symbol!,
                      style: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.w900,
                        color: symbolColor,
                      ),
                    )
                    .animate(key: ValueKey('$index-$animationSeed'))
                    .scale(
                      begin: const Offset(0, 0),
                      curve: Curves.elasticOut,
                      duration: 500.ms,
                    )
                    .fadeIn(duration: 200.ms)
              : null,
        ),
      ),
    );
  }
}
