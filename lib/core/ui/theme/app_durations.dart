class AppDurations {
  const AppDurations();

  // ── Transitions UI ──────────────────────────────────────────────────────────
  /// Micro-interactions: hover, ripple, small state changes.
  final Duration fast = const Duration(milliseconds: 200);

  /// Standard widget transitions: containers, cards, cells.
  final Duration normal = const Duration(milliseconds: 250);

  /// Scroll animations, page-level movements.
  final Duration slow = const Duration(milliseconds: 350);

  // ── Staggered list delays ───────────────────────────────────────────────────
  /// Base delay step between consecutive list items for stagger effects.
  final Duration staggerStep = const Duration(milliseconds: 80);

  /// Initial delay before a staggered list starts animating.
  final Duration staggerOffset = const Duration(milliseconds: 500);

  // ── Gameplay ────────────────────────────────────────────────────────────────
  /// Simulated CPU "thinking" delay before playing its move.
  final Duration cpuThinking = const Duration(milliseconds: 750);
}
