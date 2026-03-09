import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/extensions/build_context_extension.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_spacing.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Column(
            children: [
              SizedBox(height: AppSpacing.xxl),
              _Header(),
              SizedBox(height: AppSpacing.xxl),
              _MiniBoard(),
              Spacer(),
              _MenuSection(),
              SizedBox(height: AppSpacing.xxl),
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

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final text = Theme.of(context).textTheme;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                  'X',
                  style: text.displaySmall?.copyWith(
                    color: colors.primary,
                    fontWeight: FontWeight.w800,
                  ),
                )
                .animate()
                .fadeIn(duration: 400.ms, delay: 100.ms)
                .slideX(begin: -0.3, curve: Curves.easeOut),
            Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                  ),
                  child: Text(
                    context.locals.homeVersus,
                    style: text.titleLarge?.copyWith(color: colors.textSubtle),
                  ),
                )
                .animate()
                .fadeIn(duration: 400.ms, delay: 200.ms)
                .scale(begin: const Offset(0.7, 0.7)),
            Text(
                  'O',
                  style: text.displaySmall?.copyWith(
                    color: colors.secondary,
                    fontWeight: FontWeight.w800,
                  ),
                )
                .animate()
                .fadeIn(duration: 400.ms, delay: 300.ms)
                .slideX(begin: 0.3, curve: Curves.easeOut),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
              context.locals.appTitle,
              style: text.headlineMedium?.copyWith(color: colors.text),
            )
            .animate()
            .fadeIn(duration: 500.ms, delay: 400.ms)
            .slideY(begin: 0.2, curve: Curves.easeOut),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Mini Board (decorative)
// ---------------------------------------------------------------------------

class _MiniBoard extends StatelessWidget {
  const _MiniBoard();

  static const _size = 200.0;
  static const _cellSize = _size / 3;

  static const _preview = ['X', '', 'O', '', 'X', '', 'O', '', 'X'];

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return SizedBox(
          width: _size,
          height: _size,
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemCount: 9,
            itemBuilder: (_, index) {
              final symbol = _preview[index];
              final symbolColor = symbol == 'X'
                  ? colors.primary
                  : colors.secondary;

              return Container(
                decoration: BoxDecoration(
                  border: Border.all(color: colors.border, width: 1.5),
                ),
                child: Center(
                  child: symbol.isNotEmpty
                      ? Text(
                              symbol,
                              style: TextStyle(
                                fontSize: _cellSize * 0.55,
                                fontWeight: FontWeight.w800,
                                color: symbolColor,
                              ),
                            )
                            .animate()
                            .scale(
                              begin: const Offset(0, 0),
                              delay: Duration(milliseconds: 500 + index * 80),
                              curve: Curves.elasticOut,
                              duration: 600.ms,
                            )
                            .fadeIn(
                              delay: Duration(milliseconds: 500 + index * 80),
                              duration: 300.ms,
                            )
                      : null,
                ),
              );
            },
          ),
        )
        .animate()
        .fadeIn(duration: 400.ms, delay: 500.ms)
        .scale(begin: const Offset(0.85, 0.85), curve: Curves.easeOut);
  }
}

// ---------------------------------------------------------------------------
// Menu Section
// ---------------------------------------------------------------------------

class _MenuSection extends StatelessWidget {
  const _MenuSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _MenuButton(
          label: context.locals.homeStartGame,
          icon: Icons.play_arrow_rounded,
          isPrimary: true,
          delay: const Duration(milliseconds: 700),
          onTap: () => context.router.push(const PlayerSetupRoute()),
        ),
        const SizedBox(height: AppSpacing.md),
        _MenuButton(
          label: context.locals.homeHistory,
          icon: Icons.history_rounded,
          isPrimary: false,
          delay: const Duration(milliseconds: 850),
          onTap: () => context.router.push(const HistoryRoute()),
        ),
      ],
    );
  }
}

class _MenuButton extends StatelessWidget {
  const _MenuButton({
    required this.label,
    required this.icon,
    required this.isPrimary,
    required this.delay,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool isPrimary;
  final Duration delay;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return SizedBox(
          width: double.infinity,
          height: 56,
          child: isPrimary
              ? FilledButton.icon(
                  onPressed: onTap,
                  icon: Icon(icon),
                  label: Text(label),
                )
              : OutlinedButton.icon(
                  onPressed: onTap,
                  icon: Icon(icon, color: colors.textSubtle),
                  label: Text(label, style: TextStyle(color: colors.text)),
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
        .fadeIn(duration: 400.ms, delay: delay)
        .slideY(begin: 0.3, curve: Curves.easeOut);
  }
}
