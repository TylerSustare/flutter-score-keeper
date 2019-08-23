import 'package:flutter/material.dart';

class ResetScoreDialog extends StatelessWidget {
  ResetScoreDialog({@required this.resetPlayerScore});
  final Function resetPlayerScore;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
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
    );
  }
}
