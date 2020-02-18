import 'package:flutter/material.dart';
import 'package:score_keeper_2/models/player.dart';

class DeletePlayerDialog extends StatelessWidget {
  DeletePlayerDialog({
    @required this.players,
    @required this.index,
    @required this.onDeletePlayer,
  });

  final List<Player> players;
  final int index;
  final Function onDeletePlayer;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: new Text('Delete "${players[index].name}" from game?'),
      content: new Text("This can't be undone"),
      actions: <Widget>[
        Row(
          children: <Widget>[
            new FlatButton(
              onPressed: () {
                onDeletePlayer(playerName: players[index].name);
                Navigator.pop(context, 'success');
              },
              child: Text('Yes'),
              key: new Key('${players[index].name}-delete-confirm'),
            ),
            new FlatButton(
              onPressed: () {
                Navigator.pop(context, 'abandoned');
              },
              child: Text('No'),
              key: new Key('${players[index].name}-delete-cancel'),
            ),
          ],
        ),
      ],
    );
  }
}
