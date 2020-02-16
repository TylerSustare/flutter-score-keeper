import 'package:flutter/material.dart';
import 'dart:core';

import 'package:score_keeper/models/player.dart';
import 'delete_player_dialog.dart';

class DisplayPlayerList extends StatelessWidget {
  DisplayPlayerList({@required this.players, @required this.onDeletePlayer});

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
            ),
            leading: new FlatButton(
              child: new Icon(
                Icons.delete,
              ),
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (_) => DeletePlayerDialog(
                    index: index,
                    players: players,
                    onDeletePlayer: onDeletePlayer,
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
