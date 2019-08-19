import 'package:flutter/material.dart';
import 'package:score_keeper/player_list.dart';
import 'package:score_keeper/form.dart';
import 'package:score_keeper/player.dart';
import 'package:score_keeper/views/game_view.dart';

class PlayerListView extends StatelessWidget {
  PlayerListView(
      {@required this.playerList,
      @required this.onDeletePlayer,
      @required this.onAddPlayer,
      @required this.onResetPlayerScores,
      });

  final List<Player> playerList;
  final Function onDeletePlayer;
  final Function onAddPlayer;
  final Function onResetPlayerScores;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            PlayerForm(onAddPlayer: this.onAddPlayer, playerList: playerList),
            PlayerList(
                players: playerList, onDeletePlayer: this.onDeletePlayer),
            Row(
              children: <Widget>[
                playerList.length > 0
                    ? RaisedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GameView(
                                playerList: playerList,
                                onResetPlayerScores: onResetPlayerScores,
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
