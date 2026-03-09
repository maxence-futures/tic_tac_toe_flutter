// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_move.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GameMove _$GameMoveFromJson(Map<String, dynamic> json) => _GameMove(
  position: (json['position'] as num).toInt(),
  symbol: json['symbol'] as String,
  isCpu: json['isCpu'] as bool,
  timestamp: DateTime.parse(json['timestamp'] as String),
);

Map<String, dynamic> _$GameMoveToJson(_GameMove instance) => <String, dynamic>{
  'position': instance.position,
  'symbol': instance.symbol,
  'isCpu': instance.isCpu,
  'timestamp': instance.timestamp.toIso8601String(),
};
