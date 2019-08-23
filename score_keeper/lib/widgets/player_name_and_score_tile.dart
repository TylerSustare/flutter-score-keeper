
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:score_keeper/models/game.dart';

class PlayerNameAndScoreTile extends StatelessWidget {
  PlayerNameAndScoreTile({@required this.game, @required this.index});
  final Game game;
  final int index;

  final formatter = new NumberFormat("#,###");
  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: Text(
        formatter.format(game.players[index].score),
        style: new TextStyle(
            color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 22),
      ),
      title: Text(
        '${game.players[index].name}',
        style: new TextStyle(
          color: Colors.red,
        ),
      ),
    );
  }
}
