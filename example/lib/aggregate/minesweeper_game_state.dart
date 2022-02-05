import 'package:eventuous_simplified/eventuous_simplified.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'minesweeper_game.dart';

part 'minesweeper_game_state.freezed.dart';

@freezed
class MinesweeperGameState
    with _$MinesweeperGameState, StateWithId<MinesweeperGameId> {
  MinesweeperGameState._();
  factory MinesweeperGameState({required MinesweeperGameId? id}) =
      _MinesweeperGameState;

  factory MinesweeperGameState.initial() => MinesweeperGameState(id: null);
}
