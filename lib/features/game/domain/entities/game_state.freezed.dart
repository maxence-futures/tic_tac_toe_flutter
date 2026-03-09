// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GameState {

 List<String?> get board; String get currentSymbol; GameStatus get status; List<GameMove> get moves; Difficulty get difficulty; String get playerName; bool get isCpuThinking; List<int> get winningPositions;
/// Create a copy of GameState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GameStateCopyWith<GameState> get copyWith => _$GameStateCopyWithImpl<GameState>(this as GameState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameState&&const DeepCollectionEquality().equals(other.board, board)&&(identical(other.currentSymbol, currentSymbol) || other.currentSymbol == currentSymbol)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.moves, moves)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&(identical(other.playerName, playerName) || other.playerName == playerName)&&(identical(other.isCpuThinking, isCpuThinking) || other.isCpuThinking == isCpuThinking)&&const DeepCollectionEquality().equals(other.winningPositions, winningPositions));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(board),currentSymbol,status,const DeepCollectionEquality().hash(moves),difficulty,playerName,isCpuThinking,const DeepCollectionEquality().hash(winningPositions));

@override
String toString() {
  return 'GameState(board: $board, currentSymbol: $currentSymbol, status: $status, moves: $moves, difficulty: $difficulty, playerName: $playerName, isCpuThinking: $isCpuThinking, winningPositions: $winningPositions)';
}


}

/// @nodoc
abstract mixin class $GameStateCopyWith<$Res>  {
  factory $GameStateCopyWith(GameState value, $Res Function(GameState) _then) = _$GameStateCopyWithImpl;
@useResult
$Res call({
 List<String?> board, String currentSymbol, GameStatus status, List<GameMove> moves, Difficulty difficulty, String playerName, bool isCpuThinking, List<int> winningPositions
});


$GameStatusCopyWith<$Res> get status;

}
/// @nodoc
class _$GameStateCopyWithImpl<$Res>
    implements $GameStateCopyWith<$Res> {
  _$GameStateCopyWithImpl(this._self, this._then);

  final GameState _self;
  final $Res Function(GameState) _then;

/// Create a copy of GameState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? board = null,Object? currentSymbol = null,Object? status = null,Object? moves = null,Object? difficulty = null,Object? playerName = null,Object? isCpuThinking = null,Object? winningPositions = null,}) {
  return _then(_self.copyWith(
board: null == board ? _self.board : board // ignore: cast_nullable_to_non_nullable
as List<String?>,currentSymbol: null == currentSymbol ? _self.currentSymbol : currentSymbol // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as GameStatus,moves: null == moves ? _self.moves : moves // ignore: cast_nullable_to_non_nullable
as List<GameMove>,difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as Difficulty,playerName: null == playerName ? _self.playerName : playerName // ignore: cast_nullable_to_non_nullable
as String,isCpuThinking: null == isCpuThinking ? _self.isCpuThinking : isCpuThinking // ignore: cast_nullable_to_non_nullable
as bool,winningPositions: null == winningPositions ? _self.winningPositions : winningPositions // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}
/// Create a copy of GameState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GameStatusCopyWith<$Res> get status {
  
  return $GameStatusCopyWith<$Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}
}


/// Adds pattern-matching-related methods to [GameState].
extension GameStatePatterns on GameState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GameState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GameState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GameState value)  $default,){
final _that = this;
switch (_that) {
case _GameState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GameState value)?  $default,){
final _that = this;
switch (_that) {
case _GameState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<String?> board,  String currentSymbol,  GameStatus status,  List<GameMove> moves,  Difficulty difficulty,  String playerName,  bool isCpuThinking,  List<int> winningPositions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GameState() when $default != null:
return $default(_that.board,_that.currentSymbol,_that.status,_that.moves,_that.difficulty,_that.playerName,_that.isCpuThinking,_that.winningPositions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<String?> board,  String currentSymbol,  GameStatus status,  List<GameMove> moves,  Difficulty difficulty,  String playerName,  bool isCpuThinking,  List<int> winningPositions)  $default,) {final _that = this;
switch (_that) {
case _GameState():
return $default(_that.board,_that.currentSymbol,_that.status,_that.moves,_that.difficulty,_that.playerName,_that.isCpuThinking,_that.winningPositions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<String?> board,  String currentSymbol,  GameStatus status,  List<GameMove> moves,  Difficulty difficulty,  String playerName,  bool isCpuThinking,  List<int> winningPositions)?  $default,) {final _that = this;
switch (_that) {
case _GameState() when $default != null:
return $default(_that.board,_that.currentSymbol,_that.status,_that.moves,_that.difficulty,_that.playerName,_that.isCpuThinking,_that.winningPositions);case _:
  return null;

}
}

}

/// @nodoc


class _GameState extends GameState {
  const _GameState({required final  List<String?> board, required this.currentSymbol, required this.status, required final  List<GameMove> moves, required this.difficulty, required this.playerName, this.isCpuThinking = false, final  List<int> winningPositions = const []}): _board = board,_moves = moves,_winningPositions = winningPositions,super._();
  

 final  List<String?> _board;
@override List<String?> get board {
  if (_board is EqualUnmodifiableListView) return _board;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_board);
}

@override final  String currentSymbol;
@override final  GameStatus status;
 final  List<GameMove> _moves;
@override List<GameMove> get moves {
  if (_moves is EqualUnmodifiableListView) return _moves;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_moves);
}

@override final  Difficulty difficulty;
@override final  String playerName;
@override@JsonKey() final  bool isCpuThinking;
 final  List<int> _winningPositions;
@override@JsonKey() List<int> get winningPositions {
  if (_winningPositions is EqualUnmodifiableListView) return _winningPositions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_winningPositions);
}


/// Create a copy of GameState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GameStateCopyWith<_GameState> get copyWith => __$GameStateCopyWithImpl<_GameState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GameState&&const DeepCollectionEquality().equals(other._board, _board)&&(identical(other.currentSymbol, currentSymbol) || other.currentSymbol == currentSymbol)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._moves, _moves)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&(identical(other.playerName, playerName) || other.playerName == playerName)&&(identical(other.isCpuThinking, isCpuThinking) || other.isCpuThinking == isCpuThinking)&&const DeepCollectionEquality().equals(other._winningPositions, _winningPositions));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_board),currentSymbol,status,const DeepCollectionEquality().hash(_moves),difficulty,playerName,isCpuThinking,const DeepCollectionEquality().hash(_winningPositions));

@override
String toString() {
  return 'GameState(board: $board, currentSymbol: $currentSymbol, status: $status, moves: $moves, difficulty: $difficulty, playerName: $playerName, isCpuThinking: $isCpuThinking, winningPositions: $winningPositions)';
}


}

/// @nodoc
abstract mixin class _$GameStateCopyWith<$Res> implements $GameStateCopyWith<$Res> {
  factory _$GameStateCopyWith(_GameState value, $Res Function(_GameState) _then) = __$GameStateCopyWithImpl;
@override @useResult
$Res call({
 List<String?> board, String currentSymbol, GameStatus status, List<GameMove> moves, Difficulty difficulty, String playerName, bool isCpuThinking, List<int> winningPositions
});


@override $GameStatusCopyWith<$Res> get status;

}
/// @nodoc
class __$GameStateCopyWithImpl<$Res>
    implements _$GameStateCopyWith<$Res> {
  __$GameStateCopyWithImpl(this._self, this._then);

  final _GameState _self;
  final $Res Function(_GameState) _then;

/// Create a copy of GameState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? board = null,Object? currentSymbol = null,Object? status = null,Object? moves = null,Object? difficulty = null,Object? playerName = null,Object? isCpuThinking = null,Object? winningPositions = null,}) {
  return _then(_GameState(
board: null == board ? _self._board : board // ignore: cast_nullable_to_non_nullable
as List<String?>,currentSymbol: null == currentSymbol ? _self.currentSymbol : currentSymbol // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as GameStatus,moves: null == moves ? _self._moves : moves // ignore: cast_nullable_to_non_nullable
as List<GameMove>,difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as Difficulty,playerName: null == playerName ? _self.playerName : playerName // ignore: cast_nullable_to_non_nullable
as String,isCpuThinking: null == isCpuThinking ? _self.isCpuThinking : isCpuThinking // ignore: cast_nullable_to_non_nullable
as bool,winningPositions: null == winningPositions ? _self._winningPositions : winningPositions // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}

/// Create a copy of GameState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GameStatusCopyWith<$Res> get status {
  
  return $GameStatusCopyWith<$Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}
}

// dart format on
