import 'package:flutter/material.dart';
import 'package:score_keeper_2/widgets/player_name_and_score_tile.dart';
import 'package:score_keeper_2/widgets/score_controls.dart';
import 'dart:core';
import '../models/game.dart';

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
              ScoreControls(
                changeScores: _changeScores,
                game: game,
                index: index,
                textController: _textFieldController,
              ),
            ],
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }

  void _changeScores() => setState(() => game.players);
}
