// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GameRecord {

 int get id; String get playerName; Difficulty get difficulty;/// `'win'`, `'loss'`, or `'draw'`.
 String get result; List<GameMove> get moves; DateTime get playedAt;
/// Create a copy of GameRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GameRecordCopyWith<GameRecord> get copyWith => _$GameRecordCopyWithImpl<GameRecord>(this as GameRecord, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.playerName, playerName) || other.playerName == playerName)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&(identical(other.result, result) || other.result == result)&&const DeepCollectionEquality().equals(other.moves, moves)&&(identical(other.playedAt, playedAt) || other.playedAt == playedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,playerName,difficulty,result,const DeepCollectionEquality().hash(moves),playedAt);

@override
String toString() {
  return 'GameRecord(id: $id, playerName: $playerName, difficulty: $difficulty, result: $result, moves: $moves, playedAt: $playedAt)';
}


}

/// @nodoc
abstract mixin class $GameRecordCopyWith<$Res>  {
  factory $GameRecordCopyWith(GameRecord value, $Res Function(GameRecord) _then) = _$GameRecordCopyWithImpl;
@useResult
$Res call({
 int id, String playerName, Difficulty difficulty, String result, List<GameMove> moves, DateTime playedAt
});




}
/// @nodoc
class _$GameRecordCopyWithImpl<$Res>
    implements $GameRecordCopyWith<$Res> {
  _$GameRecordCopyWithImpl(this._self, this._then);

  final GameRecord _self;
  final $Res Function(GameRecord) _then;

/// Create a copy of GameRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? playerName = null,Object? difficulty = null,Object? result = null,Object? moves = null,Object? playedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,playerName: null == playerName ? _self.playerName : playerName // ignore: cast_nullable_to_non_nullable
as String,difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as Difficulty,result: null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as String,moves: null == moves ? _self.moves : moves // ignore: cast_nullable_to_non_nullable
as List<GameMove>,playedAt: null == playedAt ? _self.playedAt : playedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [GameRecord].
extension GameRecordPatterns on GameRecord {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GameRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GameRecord() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GameRecord value)  $default,){
final _that = this;
switch (_that) {
case _GameRecord():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GameRecord value)?  $default,){
final _that = this;
switch (_that) {
case _GameRecord() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String playerName,  Difficulty difficulty,  String result,  List<GameMove> moves,  DateTime playedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GameRecord() when $default != null:
return $default(_that.id,_that.playerName,_that.difficulty,_that.result,_that.moves,_that.playedAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String playerName,  Difficulty difficulty,  String result,  List<GameMove> moves,  DateTime playedAt)  $default,) {final _that = this;
switch (_that) {
case _GameRecord():
return $default(_that.id,_that.playerName,_that.difficulty,_that.result,_that.moves,_that.playedAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String playerName,  Difficulty difficulty,  String result,  List<GameMove> moves,  DateTime playedAt)?  $default,) {final _that = this;
switch (_that) {
case _GameRecord() when $default != null:
return $default(_that.id,_that.playerName,_that.difficulty,_that.result,_that.moves,_that.playedAt);case _:
  return null;

}
}

}

/// @nodoc


class _GameRecord implements GameRecord {
  const _GameRecord({required this.id, required this.playerName, required this.difficulty, required this.result, required final  List<GameMove> moves, required this.playedAt}): _moves = moves;
  

@override final  int id;
@override final  String playerName;
@override final  Difficulty difficulty;
/// `'win'`, `'loss'`, or `'draw'`.
@override final  String result;
 final  List<GameMove> _moves;
@override List<GameMove> get moves {
  if (_moves is EqualUnmodifiableListView) return _moves;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_moves);
}

@override final  DateTime playedAt;

/// Create a copy of GameRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GameRecordCopyWith<_GameRecord> get copyWith => __$GameRecordCopyWithImpl<_GameRecord>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GameRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.playerName, playerName) || other.playerName == playerName)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&(identical(other.result, result) || other.result == result)&&const DeepCollectionEquality().equals(other._moves, _moves)&&(identical(other.playedAt, playedAt) || other.playedAt == playedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,playerName,difficulty,result,const DeepCollectionEquality().hash(_moves),playedAt);

@override
String toString() {
  return 'GameRecord(id: $id, playerName: $playerName, difficulty: $difficulty, result: $result, moves: $moves, playedAt: $playedAt)';
}


}

/// @nodoc
abstract mixin class _$GameRecordCopyWith<$Res> implements $GameRecordCopyWith<$Res> {
  factory _$GameRecordCopyWith(_GameRecord value, $Res Function(_GameRecord) _then) = __$GameRecordCopyWithImpl;
@override @useResult
$Res call({
 int id, String playerName, Difficulty difficulty, String result, List<GameMove> moves, DateTime playedAt
});




}
/// @nodoc
class __$GameRecordCopyWithImpl<$Res>
    implements _$GameRecordCopyWith<$Res> {
  __$GameRecordCopyWithImpl(this._self, this._then);

  final _GameRecord _self;
  final $Res Function(_GameRecord) _then;

/// Create a copy of GameRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? playerName = null,Object? difficulty = null,Object? result = null,Object? moves = null,Object? playedAt = null,}) {
  return _then(_GameRecord(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,playerName: null == playerName ? _self.playerName : playerName // ignore: cast_nullable_to_non_nullable
as String,difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as Difficulty,result: null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as String,moves: null == moves ? _self._moves : moves // ignore: cast_nullable_to_non_nullable
as List<GameMove>,playedAt: null == playedAt ? _self.playedAt : playedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
