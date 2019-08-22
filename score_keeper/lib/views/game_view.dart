import 'package:flutter/material.dart';
import 'package:score_keeper/game_list.dart';
import 'package:score_keeper/game.dart';

class GameView extends StatefulWidget {
  GameView({@required this.game});
  final Game game;

  @override
  _GameState createState() => _GameState(game: game);
}

class _GameState extends State<GameView> {
  _GameState({@required this.game});
  final Game game;

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
                            this.resetPlayerScore();
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
        game: this.game,
      ),
    );
  }

  void resetPlayerScore() {
    for (var player in this.game.players) {
      player.resetScore();
    }
    setState(() => this.game.players);
  }
}
