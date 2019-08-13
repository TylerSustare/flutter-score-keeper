import 'package:flutter/material.dart';
import 'package:score_keeper/game_list.dart';
import 'package:score_keeper/player.dart';

class Game extends StatelessWidget {
  Game({
    @required this.playerList,
  });
  final List<Player> playerList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Score Keeper - Game"),
      ),
      body: GameList(
        players: playerList,
      ),
    );
  }
}
