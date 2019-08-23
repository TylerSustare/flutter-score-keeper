
import 'package:flutter/material.dart';
import 'package:score_keeper/models/game.dart';
import 'package:score_keeper/screens/game_screen.dart';

class KeepScoreButton extends StatelessWidget {
  KeepScoreButton({@required this.game});
  final Game game;
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GameScreen(game: this.game),
          ),
        );
      },
      child: Icon(
        Icons.play_arrow,
        color: Colors.white,
      ),
      color: Colors.blue,
      key: new Key('keep-score'),
    );
  }
}
