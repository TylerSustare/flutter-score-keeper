import 'package:flutter/material.dart';
import 'dart:core';

import 'package:score_keeper/player.dart';

class PlayerList extends StatefulWidget {
  PlayerList({@required this.name, @required this.onDeletePlayer});

  final List<Player> name;
  final Function onDeletePlayer;

  @override
  PlayerListState createState() =>
      PlayerListState(name: name, onDeletePlayer: onDeletePlayer);
}

class PlayerListState extends State<PlayerList> {
  PlayerListState({@required this.name, @required this.onDeletePlayer});

  final List<Player> name;
  final Function onDeletePlayer;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      // padding: const EdgeInsets.all(8.0),
      itemCount: name.length,
      itemBuilder: (BuildContext context, int index) {
        return new Card(
          child: new ListTile(
            // trailing: Icon(Icons.edit),
            title: Text(
              '${name[index].name}',
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
                    title: new Text('Delete "${name[index].name}" from game?'),
                    content: new Text("This is my content"),
                    actions: <Widget>[
                      Row(
                        children: <Widget>[
                          new FlatButton(
                            onPressed: () {
                              onDeletePlayer(playerName: name[index].name);
                              Navigator.pop(context, 'success');
                            },
                            child: Text('Yes'),
                            key: new Key('${name[index].name}-delete-confirm'),
                          ),
                          new FlatButton(
                            onPressed: () {
                              Navigator.pop(context, 'abandoned');
                            },
                            child: Text('No'),
                            key: new Key('${name[index].name}-delete-cancel'),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
              key: new Key('${name[index].name}-delete'),
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}
