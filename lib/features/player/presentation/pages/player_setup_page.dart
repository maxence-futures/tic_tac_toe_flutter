import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe_flutter/core/extensions/build_context_extension.dart';
import 'package:tic_tac_toe_flutter/core/router/app_router.dart';
import 'package:tic_tac_toe_flutter/core/ui/theme/app_spacing.dart';
import 'package:tic_tac_toe_flutter/core/ui/widgets/empty_state_widget.dart';
import 'package:tic_tac_toe_flutter/core/ui/widgets/player_avatar.dart';
import 'package:tic_tac_toe_flutter/features/player/domain/entities/player_profile.dart';
import 'package:tic_tac_toe_flutter/features/player/presentation/providers/player_providers.dart';

@RoutePage()
class PlayerSetupPage extends ConsumerWidget {
  const PlayerSetupPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(playerProvider);
    final colors = context.appColors;

    return Scaffold(
      appBar: AppBar(
        title: Text(context.locals.playerSetupTitle),
        titleTextStyle: context.textTheme.titleMedium?.copyWith(
          color: colors.text,
        ),
        backgroundColor: colors.background,
        elevation: AppSpacing.elevationNone,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: state.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text(e.toString())),
            data: (playerState) => _Body(
              activePlayerProfile: playerState.activeProfile,
              profiles: playerState.profiles,
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------

class _Body extends ConsumerStatefulWidget {
  const _Body({required this.activePlayerProfile, required this.profiles});

  final PlayerProfile? activePlayerProfile;
  final List<PlayerProfile> profiles;

  @override
  ConsumerState<_Body> createState() => _BodyState();
}

class _BodyState extends ConsumerState<_Body> {
  final _nameController = TextEditingController();
  bool _showAddField = false;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    final profiles = widget.profiles;
    final active = widget.activePlayerProfile;
    final canContinue = active != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
              context.locals.playerSetupChooseProfile,
              style: context.textTheme.titleMedium?.copyWith(
                color: colors.textSubtle,
              ),
            )
            .animate()
            .fadeIn(duration: 300.ms)
            .slideY(begin: 0.2, curve: Curves.easeOut),
        const SizedBox(height: AppSpacing.md),
        Expanded(
          child: profiles.isEmpty
              ? EmptyStateWidget(
                  icon: Icons.person_outline,
                  message: context.locals.playerSetupNoProfiles,
                  action: FilledButton.icon(
                    onPressed: () => setState(() => _showAddField = true),
                    icon: const Icon(Icons.add),
                    label: Text(context.locals.playerSetupNewProfile),
                  ),
                )
              : ListView.separated(
                  itemCount: profiles.length,
                  separatorBuilder: (_, _) =>
                      const SizedBox(height: AppSpacing.sm),
                  itemBuilder: (context, index) {
                    final profile = profiles[index];
                    final isSelected = active?.name == profile.name;
                    return _ProfileTile(
                          profile: profile,
                          isSelected: isSelected,
                          onTap: () => ref
                              .read(playerProvider.notifier)
                              .setActiveProfile(profile),
                          onDelete: () => ref
                              .read(playerProvider.notifier)
                              .removeProfile(profile.name),
                        )
                        .animate(delay: context.durations.staggerStep * index)
                        .fadeIn(duration: 300.ms)
                        .slideX(begin: 0.2, curve: Curves.easeOut);
                  },
                ),
        ),
        if (_showAddField) ...[
          const SizedBox(height: AppSpacing.md),
          _AddProfileField(
            controller: _nameController,
            onConfirm: () async {
              final name = _nameController.text.trim();
              if (name.isEmpty) return;
              await ref.read(playerProvider.notifier).addProfile(name);
              _nameController.clear();
              setState(() => _showAddField = false);
            },
            onCancel: () {
              _nameController.clear();
              setState(() => _showAddField = false);
            },
          ).animate().fadeIn(duration: 250.ms).slideY(begin: 0.3),
        ] else ...[
          const SizedBox(height: AppSpacing.sm),
          TextButton.icon(
            onPressed: () => setState(() => _showAddField = true),
            icon: const Icon(Icons.add),
            label: Text(context.locals.playerSetupNewProfile),
          ),
        ],
        const SizedBox(height: AppSpacing.lg),
        SizedBox(
              width: double.infinity,
              height: 56,
              child: FilledButton(
                onPressed: canContinue
                    ? () => context.router.push(
                        DifficultyRoute(playerName: active.name),
                      )
                    : null,
                child: Text(context.locals.playerSetupContinue),
              ),
            )
            .animate()
            .fadeIn(duration: 400.ms, delay: 300.ms)
            .slideY(begin: 0.2, curve: Curves.easeOut),
      ],
    );
  }
}

class _ProfileTile extends StatelessWidget {
  const _ProfileTile({
    required this.profile,
    required this.isSelected,
    required this.onTap,
    required this.onDelete,
  });

  final PlayerProfile profile;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return AnimatedContainer(
      duration: context.durations.fast,
      decoration: BoxDecoration(
        color: isSelected
            ? colors.primary.withValues(alpha: 0.1)
            : colors.surface,
        border: Border.all(
          color: isSelected ? colors.primary : colors.border,
          width: isSelected ? 2 : 1,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSpacing.radiusLg),
        ),
      ),
      child: ListTile(
        leading: PlayerAvatar(
          name: profile.name,
          backgroundColor: isSelected ? colors.primary : colors.surface,
          textColor: isSelected ? colors.onPrimary : colors.text,
        ),
        title: Text(
          profile.name,
          style: context.textTheme.titleMedium?.copyWith(
            color: colors.text,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
          ),
        ),
        trailing: isSelected
            ? Icon(Icons.check_circle, color: colors.primary)
            : IconButton(
                icon: Icon(Icons.delete_outline, color: colors.textSubtle),
                onPressed: onDelete,
              ),
        onTap: onTap,
      ),
    );
  }
}

class _AddProfileField extends StatelessWidget {
  const _AddProfileField({
    required this.controller,
    required this.onConfirm,
    required this.onCancel,
  });

  final TextEditingController controller;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            autofocus: true,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
              hintText: context.locals.playerSetupNameHint,
            ),
            onSubmitted: (_) => onConfirm(),
          ),
        ),
        IconButton(icon: const Icon(Icons.check), onPressed: onConfirm),
        IconButton(icon: const Icon(Icons.close), onPressed: onCancel),
      ],
    );
  }
}
