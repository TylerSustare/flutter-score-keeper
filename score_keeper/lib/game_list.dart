import 'package:flutter/material.dart';
import 'dart:core';

import 'package:score_keeper/player.dart';

import 'game.dart';

class GameList extends StatefulWidget {
  GameList({@required this.game});

  final Game game;

  @override
  GameListState createState() => GameListState(game: game);
}

class GameListState extends State<GameList> {
  GameListState({@required this.game});

  final Game game;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      // padding: const EdgeInsets.all(8.0),
      itemCount: game.players.length,
      itemBuilder: (BuildContext context, int index) {
        return new Card(
          child: new ListTile(
            leading: Text(
              '${game.players[index].score.toInt()}',
              style: new TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 22),
            ),
            title: Text(
              '${game.players[index].name}',
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
                    game.players[index].decrementScore();
                    setState(() => game.players);
                  },
                  key: new Key(
                    '${game.players[index].name}-decrement-score',
                  ),
                ),
                new FlatButton(
                  child: new Icon(
                    Icons.add,
                    color: Colors.grey[700],
                  ),
                  onPressed: () {
                    game.players[index].incrementScore();
                    setState(() => game.players);
                  },
                  key: new Key(
                    '${game.players[index].name}-increment-score',
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
