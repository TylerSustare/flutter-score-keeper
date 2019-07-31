import 'package:flutter/material.dart';
import 'dart:core';

class PlayerList extends StatefulWidget {
  PlayerList({@required this.name, @required this.onDeletePlayer});
  final List<String> name;
  final Function onDeletePlayer;

  @override
  PlayerListState createState() =>
      PlayerListState(name: name, onDeletePlayer: onDeletePlayer);
}

class PlayerListState extends State<PlayerList> {
  PlayerListState({@required this.name, @required this.onDeletePlayer});
  final List<String> name;
  final Function onDeletePlayer;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(8.0),
      itemCount: name.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: ListTile(
            // trailing: Icon(Icons.edit),
            title: Text(
              '${name[index]}',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
            leading: FlatButton(
              child: Icon(
                Icons.delete,
                color: Colors.grey[700],
              ),
              onPressed: () => onDeletePlayer(playerName: name[index]),
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}