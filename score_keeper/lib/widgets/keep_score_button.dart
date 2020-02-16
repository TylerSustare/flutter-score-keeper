import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:score_keeper/models/game.dart';
import 'package:score_keeper/models/theme.dart';
import 'package:score_keeper/screens/game_screen.dart';

class KeepScoreButton extends StatelessWidget {
  KeepScoreButton({@required this.game});
  final Game game;
  @override
  Widget build(BuildContext context) {
    return Padding(
      child: RaisedButton(
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
        color: Provider.of<GameTheme>(context).color,
        key: new Key('keep-score'),
      ),
      padding: EdgeInsets.all(8.0),
    );
  }
}
