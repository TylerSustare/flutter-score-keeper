import 'package:flutter/material.dart';
import 'package:score_keeper_2/widgets/display_player_list.dart';
import 'package:score_keeper_2/widgets/add_player_form.dart';

import '../models/game.dart';
import 'keep_score_button.dart';

class PlayerListView extends StatelessWidget {
  PlayerListView({
    @required this.game,
    @required this.onDeletePlayer,
    @required this.onAddPlayer,
  });

  final Game game;
  final Function onDeletePlayer;
  final Function onAddPlayer;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            AddPlayerForm(
                onAddPlayer: this.onAddPlayer, playerList: game.players),
            DisplayPlayerList(
                players: game.players, onDeletePlayer: this.onDeletePlayer),
            Row(
              children: <Widget>[
                game.players.length > 0
                    ? KeepScoreButton(game: game)
                    : Text('Please add a player to continue...'),
              ],
              mainAxisAlignment: MainAxisAlignment.end,
            ),
          ],
        ),
      ),
    );
  }
}
