import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:score_keeper/widgets/player_name_and_score_tile.dart';
import 'dart:core';
import '../models/game.dart';
import 'change_score_dialog.dart';

class GameScorePlayerList extends StatefulWidget {
  GameScorePlayerList({@required this.game});

  final Game game;

  @override
  GameScorePlayerListState createState() =>
      GameScorePlayerListState(game: game);
}

class GameScorePlayerListState extends State<GameScorePlayerList> {
  GameScorePlayerListState({@required this.game});

  TextEditingController _textFieldController = TextEditingController();
  final Game game;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _textFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: game.players.length,
      itemBuilder: (BuildContext context, int index) {
        return new Card(
          child: Column(
            children: <Widget>[
              PlayerNameAndScoreTile(game: game, index: index),
              Row(
                children: <Widget>[
                  new FlatButton(
                    child: new Icon(
                      Icons.remove,
                      color: Colors.grey[700],
                    ),
                    onPressed: () {
                      game.players[index]
                          .decrementScore(this.game.decrementValue);
                      setState(() => game.players);
                    },
                    key: new Key('${game.players[index].name}-decrement-score'),
                  ),
                  new FlatButton(
                    child: new Icon(
                      Icons.edit,
                      color: Colors.grey[700],
                    ),
                    onPressed: () async {
                      // _settingModalBottomSheet(context); // maybe one day SO will answer https://url.sustare.dev/gJ1FK
                      String add = await _displayDialog(context);
                      if (add != null) {
                        game.players[index]
                            .addScore(scoreToAdd: int.tryParse(add) ?? 0);
                        setState(() => game.players);
                      }
                    },
                    key: new Key('${game.players[index].name}-edit-score'),
                  ),
                  new FlatButton(
                    child: new Icon(
                      Icons.add,
                      color: Colors.grey[700],
                    ),
                    onPressed: () {
                      game.players[index]
                          .incrementScore(this.game.incrementValue);
                      setState(() => game.players);
                    },
                    key: new Key('${game.players[index].name}-increment-score'),
                  ),
                ],
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
              ),
            ],
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }

  _displayDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return ChangeScoreDialog(textFieldController: _textFieldController);
      },
    );
  }
}
