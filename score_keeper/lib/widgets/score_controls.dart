import 'package:flutter/material.dart';
import 'package:score_keeper/models/game.dart';
import 'package:score_keeper/widgets/change_score_dialog.dart';

class ScoreControls extends StatelessWidget {
  ScoreControls({
    @required this.game,
    @required this.index,
    @required this.changeScores,
    @required this.textController,
  });
  final TextEditingController textController;
  final Function changeScores;
  final Game game;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        new FlatButton(
          child: new Icon(
            Icons.remove,
            color: Colors.grey[700],
          ),
          onPressed: () {
            game.players[index].decrementScore(this.game.decrementValue);
            changeScores();
          },
          key: new Key('${game.players[index].name}-decrement-score'),
        ),
        new FlatButton(
          child: new Icon(
            Icons.edit,
            color: Colors.grey[700],
          ),
          onPressed: () async {
            String add = await _displayDialog(context);
            if (add != null) {
              game.players[index].addScore(scoreToAdd: int.tryParse(add) ?? 0);
              changeScores();
            }
          },
          key: new Key('${game.players[index].name}-edit-score'),
        ),
        new FlatButton(
          child: new Icon(
            Icons.add,
            color: Colors.grey[700],
          ),
          onPressed: () {
            game.players[index].incrementScore(this.game.incrementValue);
            changeScores();
          },
          key: new Key('${game.players[index].name}-increment-score'),
        ),
      ],
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
    );
  }

  Future<String> _displayDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return ChangeScoreDialog(textFieldController: textController);
      },
    );
  }
}