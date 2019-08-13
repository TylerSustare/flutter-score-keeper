import 'package:flutter/material.dart';
import 'dart:core';

import 'package:score_keeper/player.dart';

class PlayerList extends StatefulWidget {
  PlayerList({@required this.players, @required this.onDeletePlayer});

  final List<Player> players;
  final Function onDeletePlayer;

  @override
  PlayerListState createState() =>
      PlayerListState(players: players, onDeletePlayer: onDeletePlayer);
}

class PlayerListState extends State<PlayerList> {
  PlayerListState({@required this.players, @required this.onDeletePlayer});

  final List<Player> players;
  final Function onDeletePlayer;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      // padding: const EdgeInsets.all(8.0),
      itemCount: players.length,
      itemBuilder: (BuildContext context, int index) {
        return new Card(
          child: new ListTile(
            // trailing: Icon(Icons.edit),
            title: Text(
              '${players[index].name}',
              style: new TextStyle(
                color: Colors.red,
              ),
            ),
            leading: new FlatButton(
              child: new Icon(
                Icons.delete,
                color: Colors.grey[700],
              ),
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (_) => new AlertDialog(
                    title:
                        new Text('Delete "${players[index].name}" from game?'),
                    content: new Text("This is my content"),
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
                  ),
                );
              },
              key: new Key('${players[index].name}-delete'),
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}
