import 'package:flutter/material.dart';
import 'dart:core';

import 'package:score_keeper/player.dart';

class GameList extends StatefulWidget {
  GameList({@required this.players});

  final List<Player> players;

  @override
  GameListState createState() =>
      GameListState(players: players);
}

class GameListState extends State<GameList> {
  GameListState({@required this.players});

  final List<Player> players;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      // padding: const EdgeInsets.all(8.0),
      itemCount: players.length,
      itemBuilder: (BuildContext context, int index) {
        return new Card(
          child: new ListTile(
            leading: Text(
              '${players[index].score.toInt()}',
              style: new TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 22),
            ),
            title: Text(
              '${players[index].name}',
              style: new TextStyle(
                color: Colors.red,
              ),
            ),
            trailing: Row(
              children: <Widget>[
                new FlatButton(
                  child: new Icon(
                    Icons.remove,
                    color: Colors.grey[700],
                  ),
                  onPressed: () {
                    for (var i = 0; i < 100; i++) {
                      players[index].decrementScore();
                    }
                    setState(() => players);
                  },
                  key: new Key(
                    '${players[index].name}-decrement-score',
                  ),
                ),
                new FlatButton(
                  child: new Icon(
                    Icons.add,
                    color: Colors.grey[700],
                  ),
                  onPressed: () {
                    players[index].incrementScore();
                    setState(() => players);
                  },
                  key: new Key(
                    '${players[index].name}-increment-score',
                  ),
                ),
              ],
              mainAxisSize: MainAxisSize.min,
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}
