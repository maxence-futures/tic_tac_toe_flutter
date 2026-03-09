// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GameStatus {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameStatus);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GameStatus()';
}


}

/// @nodoc
class $GameStatusCopyWith<$Res>  {
$GameStatusCopyWith(GameStatus _, $Res Function(GameStatus) __);
}


/// Adds pattern-matching-related methods to [GameStatus].
extension GameStatusPatterns on GameStatus {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( GameStatusPlaying value)?  playing,TResult Function( GameStatusWon value)?  won,TResult Function( GameStatusDraw value)?  draw,required TResult orElse(),}){
final _that = this;
switch (_that) {
case GameStatusPlaying() when playing != null:
return playing(_that);case GameStatusWon() when won != null:
return won(_that);case GameStatusDraw() when draw != null:
return draw(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( GameStatusPlaying value)  playing,required TResult Function( GameStatusWon value)  won,required TResult Function( GameStatusDraw value)  draw,}){
final _that = this;
switch (_that) {
case GameStatusPlaying():
return playing(_that);case GameStatusWon():
return won(_that);case GameStatusDraw():
return draw(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( GameStatusPlaying value)?  playing,TResult? Function( GameStatusWon value)?  won,TResult? Function( GameStatusDraw value)?  draw,}){
final _that = this;
switch (_that) {
case GameStatusPlaying() when playing != null:
return playing(_that);case GameStatusWon() when won != null:
return won(_that);case GameStatusDraw() when draw != null:
return draw(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  playing,TResult Function( String winner)?  won,TResult Function()?  draw,required TResult orElse(),}) {final _that = this;
switch (_that) {
case GameStatusPlaying() when playing != null:
return playing();case GameStatusWon() when won != null:
return won(_that.winner);case GameStatusDraw() when draw != null:
return draw();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  playing,required TResult Function( String winner)  won,required TResult Function()  draw,}) {final _that = this;
switch (_that) {
case GameStatusPlaying():
return playing();case GameStatusWon():
return won(_that.winner);case GameStatusDraw():
return draw();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  playing,TResult? Function( String winner)?  won,TResult? Function()?  draw,}) {final _that = this;
switch (_that) {
case GameStatusPlaying() when playing != null:
return playing();case GameStatusWon() when won != null:
return won(_that.winner);case GameStatusDraw() when draw != null:
return draw();case _:
  return null;

}
}

}

/// @nodoc


class GameStatusPlaying implements GameStatus {
  const GameStatusPlaying();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameStatusPlaying);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GameStatus.playing()';
}


}




/// @nodoc


class GameStatusWon implements GameStatus {
  const GameStatusWon({required this.winner});
  

 final  String winner;

/// Create a copy of GameStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GameStatusWonCopyWith<GameStatusWon> get copyWith => _$GameStatusWonCopyWithImpl<GameStatusWon>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameStatusWon&&(identical(other.winner, winner) || other.winner == winner));
}


@override
int get hashCode => Object.hash(runtimeType,winner);

@override
String toString() {
  return 'GameStatus.won(winner: $winner)';
}


}

/// @nodoc
abstract mixin class $GameStatusWonCopyWith<$Res> implements $GameStatusCopyWith<$Res> {
  factory $GameStatusWonCopyWith(GameStatusWon value, $Res Function(GameStatusWon) _then) = _$GameStatusWonCopyWithImpl;
@useResult
$Res call({
 String winner
});




}
/// @nodoc
class _$GameStatusWonCopyWithImpl<$Res>
    implements $GameStatusWonCopyWith<$Res> {
  _$GameStatusWonCopyWithImpl(this._self, this._then);

  final GameStatusWon _self;
  final $Res Function(GameStatusWon) _then;

/// Create a copy of GameStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? winner = null,}) {
  return _then(GameStatusWon(
winner: null == winner ? _self.winner : winner // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class GameStatusDraw implements GameStatus {
  const GameStatusDraw();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameStatusDraw);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GameStatus.draw()';
}


}




// dart format on
