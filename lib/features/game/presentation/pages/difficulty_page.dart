import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/extensions/build_context_extension.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/difficulty.dart';

@RoutePage()
class DifficultyPage extends StatefulWidget {
  const DifficultyPage({super.key, required this.playerName});

  final String playerName;

  @override
  State<DifficultyPage> createState() => _DifficultyPageState();
}

class _DifficultyPageState extends State<DifficultyPage> {
  Difficulty? _selected;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Scaffold(
      appBar: AppBar(
        title: Text(context.locals.difficultyTitle),
        backgroundColor: colors.background,
        elevation: AppSpacing.elevationNone,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            children: [
              Text(
                context.locals.difficultySubtitle,
                style: context.textTheme.titleMedium
                    ?.copyWith(color: colors.textSubtle),
              )
                  .animate()
                  .fadeIn(duration: 300.ms)
                  .slideY(begin: 0.2, curve: Curves.easeOut),
              const SizedBox(height: AppSpacing.xl),
              _DifficultyCard(
                difficulty: Difficulty.easy,
                icon: Icons.sentiment_satisfied_rounded,
                selected: _selected == Difficulty.easy,
                onTap: () => setState(() => _selected = Difficulty.easy),
                delay: 100.ms,
              ),
              const SizedBox(height: AppSpacing.md),
              _DifficultyCard(
                difficulty: Difficulty.medium,
                icon: Icons.psychology_rounded,
                selected: _selected == Difficulty.medium,
                onTap: () => setState(() => _selected = Difficulty.medium),
                delay: 200.ms,
              ),
              const SizedBox(height: AppSpacing.md),
              _DifficultyCard(
                difficulty: Difficulty.hard,
                icon: Icons.whatshot_rounded,
                selected: _selected == Difficulty.hard,
                onTap: () => setState(() => _selected = Difficulty.hard),
                delay: 300.ms,
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: FilledButton(
                  onPressed: _selected != null
                      ? () => context.router.push(
                            GameRoute(
                              playerName: widget.playerName,
                              difficulty: _selected!,
                            ),
                          )
                      : null,
                  child: Text(context.locals.difficultyStart),
                ),
              )
                  .animate()
                  .fadeIn(duration: 400.ms, delay: 400.ms)
                  .slideY(begin: 0.2, curve: Curves.easeOut),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------

class _DifficultyCard extends StatelessWidget {
  const _DifficultyCard({
    required this.difficulty,
    required this.icon,
    required this.selected,
    required this.onTap,
    required this.delay,
  });

  final Difficulty difficulty;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;
  final Duration delay;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final (label, description, color) = switch (difficulty) {
      Difficulty.easy => (
          context.locals.difficultyEasy,
          context.locals.difficultyEasyDesc,
          colors.primary,
        ),
      Difficulty.medium => (
          context.locals.difficultyMedium,
          context.locals.difficultyMediumDesc,
          colors.secondary,
        ),
      Difficulty.hard => (
          context.locals.difficultyHard,
          context.locals.difficultyHardDesc,
          colors.error,
        ),
    };

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: selected ? color.withValues(alpha: 0.1) : colors.surface,
        border: Border.all(
          color: selected ? color : colors.border,
          width: selected ? 2 : 1,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSpacing.radiusLg),
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSpacing.radiusLg),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: AppSpacing.iconLg),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: context.textTheme.titleMedium?.copyWith(
                        color: colors.text,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      description,
                      style: context.textTheme.bodySmall
                          ?.copyWith(color: colors.textSubtle),
                    ),
                  ],
                ),
              ),
              if (selected)
                Icon(Icons.check_circle, color: color)
                    .animate()
                    .scale(curve: Curves.elasticOut, duration: 400.ms),
            ],
          ),
        ),
      ),
    ).animate(delay: delay).fadeIn(duration: 300.ms).slideX(begin: 0.2, curve: Curves.easeOut);
  }
}
