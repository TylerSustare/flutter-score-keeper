import 'package:flutter/material.dart';
import 'package:score_keeper_2/widgets/game_score_player_list.dart';
import 'package:score_keeper_2/models/game.dart';
import 'package:score_keeper_2/widgets/reset_score_dialog.dart';

class GameScreen extends StatefulWidget {
  GameScreen({@required this.game});
  final Game game;

  @override
  _GameScreenState createState() => _GameScreenState(game: game);
}

class _GameScreenState extends State<GameScreen> {
  _GameScreenState({@required this.game});
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
                builder: (_) =>
                    ResetScoreDialog(resetPlayerScore: this.resetPlayerScore),
              );
            },
            key: Key('reset-game-scores'),
          )
        ],
      ),
      body: GameScorePlayerList(game: this.game),
    );
  }

  void resetPlayerScore() {
    for (var player in this.game.players) {
      player.resetScore();
    }
    setState(() => this.game.players);
  }
}
