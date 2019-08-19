import 'package:flutter/material.dart';
import 'package:score_keeper/game_list.dart';
import 'package:score_keeper/player.dart';

class Game extends StatefulWidget {
  Game({@required this.playerList, @required this.onResetPlayerScores});

  final Function onResetPlayerScores;
  final List<Player> playerList;

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Score Keeper - Game"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.autorenew),
            onPressed: () async {
              await showDialog(
                context: context,
                builder: (_) => new AlertDialog(
                  title: new Text('Reset game scores?'),
                  content: new Text("This can't be undone"),
                  actions: <Widget>[
                    Row(
                      children: <Widget>[
                        new FlatButton(
                          onPressed: () {
                            widget.onResetPlayerScores();
                            Navigator.pop(context, 'success');
                          },
                          child: Text('Yes'),
                          key: new Key('score-reset-confirm'),
                        ),
                        new FlatButton(
                          onPressed: () {
                            Navigator.pop(context, 'abandoned');
                          },
                          child: Text('No'),
                          key: new Key('score-reset-cancel'),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
            key: Key('reset-game-scores'),
          )
        ],
      ),
      body: GameList(
        players: widget.playerList,
      ),
    );
  }
}
