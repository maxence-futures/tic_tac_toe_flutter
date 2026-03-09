// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_move.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GameMove {

 int get position; String get symbol; bool get isCpu; DateTime get timestamp;
/// Create a copy of GameMove
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GameMoveCopyWith<GameMove> get copyWith => _$GameMoveCopyWithImpl<GameMove>(this as GameMove, _$identity);

  /// Serializes this GameMove to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameMove&&(identical(other.position, position) || other.position == position)&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.isCpu, isCpu) || other.isCpu == isCpu)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,position,symbol,isCpu,timestamp);

@override
String toString() {
  return 'GameMove(position: $position, symbol: $symbol, isCpu: $isCpu, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class $GameMoveCopyWith<$Res>  {
  factory $GameMoveCopyWith(GameMove value, $Res Function(GameMove) _then) = _$GameMoveCopyWithImpl;
@useResult
$Res call({
 int position, String symbol, bool isCpu, DateTime timestamp
});




}
/// @nodoc
class _$GameMoveCopyWithImpl<$Res>
    implements $GameMoveCopyWith<$Res> {
  _$GameMoveCopyWithImpl(this._self, this._then);

  final GameMove _self;
  final $Res Function(GameMove) _then;

/// Create a copy of GameMove
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? position = null,Object? symbol = null,Object? isCpu = null,Object? timestamp = null,}) {
  return _then(_self.copyWith(
position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int,symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,isCpu: null == isCpu ? _self.isCpu : isCpu // ignore: cast_nullable_to_non_nullable
as bool,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [GameMove].
extension GameMovePatterns on GameMove {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GameMove value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GameMove() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GameMove value)  $default,){
final _that = this;
switch (_that) {
case _GameMove():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GameMove value)?  $default,){
final _that = this;
switch (_that) {
case _GameMove() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int position,  String symbol,  bool isCpu,  DateTime timestamp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GameMove() when $default != null:
return $default(_that.position,_that.symbol,_that.isCpu,_that.timestamp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int position,  String symbol,  bool isCpu,  DateTime timestamp)  $default,) {final _that = this;
switch (_that) {
case _GameMove():
return $default(_that.position,_that.symbol,_that.isCpu,_that.timestamp);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int position,  String symbol,  bool isCpu,  DateTime timestamp)?  $default,) {final _that = this;
switch (_that) {
case _GameMove() when $default != null:
return $default(_that.position,_that.symbol,_that.isCpu,_that.timestamp);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GameMove implements GameMove {
  const _GameMove({required this.position, required this.symbol, required this.isCpu, required this.timestamp});
  factory _GameMove.fromJson(Map<String, dynamic> json) => _$GameMoveFromJson(json);

@override final  int position;
@override final  String symbol;
@override final  bool isCpu;
@override final  DateTime timestamp;

/// Create a copy of GameMove
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GameMoveCopyWith<_GameMove> get copyWith => __$GameMoveCopyWithImpl<_GameMove>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GameMoveToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GameMove&&(identical(other.position, position) || other.position == position)&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.isCpu, isCpu) || other.isCpu == isCpu)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,position,symbol,isCpu,timestamp);

@override
String toString() {
  return 'GameMove(position: $position, symbol: $symbol, isCpu: $isCpu, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class _$GameMoveCopyWith<$Res> implements $GameMoveCopyWith<$Res> {
  factory _$GameMoveCopyWith(_GameMove value, $Res Function(_GameMove) _then) = __$GameMoveCopyWithImpl;
@override @useResult
$Res call({
 int position, String symbol, bool isCpu, DateTime timestamp
});




}
/// @nodoc
class __$GameMoveCopyWithImpl<$Res>
    implements _$GameMoveCopyWith<$Res> {
  __$GameMoveCopyWithImpl(this._self, this._then);

  final _GameMove _self;
  final $Res Function(_GameMove) _then;

/// Create a copy of GameMove
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? position = null,Object? symbol = null,Object? isCpu = null,Object? timestamp = null,}) {
  return _then(_GameMove(
position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int,symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,isCpu: null == isCpu ? _self.isCpu : isCpu // ignore: cast_nullable_to_non_nullable
as bool,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
