import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tic_tac_toe_flutter/features/player/domain/entities/player_profile.dart';

part 'player_state.freezed.dart';

@freezed
abstract class PlayerState with _$PlayerState {
  const factory PlayerState({
    required List<PlayerProfile> profiles,
    required PlayerProfile? activeProfile,
  }) = _PlayerState;
}
