import 'package:flutter/material.dart';
import 'package:score_keeper/player_list.dart';
import 'package:score_keeper/form.dart';
import 'package:score_keeper/views/game_view.dart';

import '../game.dart';

class PlayerListView extends StatelessWidget {
  PlayerListView(
      {@required this.game,
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
            PlayerForm(onAddPlayer: this.onAddPlayer, playerList: game.players),
            PlayerList(
                players: game.players, onDeletePlayer: this.onDeletePlayer),
            Row(
              children: <Widget>[
                game.players.length > 0
                    ? RaisedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GameView(
                                game: game
                              ),
                            ),
                          );
                        },
                        child: Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                        ),
                        color: Colors.blue,
                        key: new Key('keep-score'),
                      )
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
