import 'package:flutter/material.dart';
import 'package:score_keeper_2/models/game.dart';
import 'package:score_keeper_2/widgets/change_score_dialog.dart';

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
