import 'package:flutter/material.dart';
import 'package:score_keeper_2/models/game.dart';
import 'package:score_keeper_2/widgets/player_setup_container.dart';
import 'options_screen.dart';

class PlayersScreen extends StatelessWidget {
  PlayersScreen(
      {@required this.game,
      @required this.onDeletePlayer,
      @required this.onAddPlayer});

  final Game game;
  final Function onDeletePlayer;
  final Function onAddPlayer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: FlatButton(
          child: Icon(
            Icons.settings,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OptionsScreen(game: game),
              ),
            );
          },
          key: Key('nav-to-options-page'),
        ),
        title: Text('Score Keeper - Players'),
        backgroundColor: Colors.pink,
      ),
      body: PlayerListView(
        game: game,
        onDeletePlayer: this.onDeletePlayer,
        onAddPlayer: this.onAddPlayer,
      ),
    );
  }
}
