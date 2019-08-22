import 'package:flutter/material.dart';
import 'package:score_keeper/player.dart';
import 'package:score_keeper/views/list.dart';
import 'package:score_keeper/views/options_view.dart';

import 'game.dart';

void main() => runApp(
      MaterialApp(
        title: 'Simple Score Keeper',
        home: MainApp(),
      ),
    );

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final Game game = new Game(players: new List<Player>());

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
                builder: (context) => OptionsView(game: game),
              ),
            );
          },
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

  void onAddPlayer({String name}) {
    Player newPlayer = new Player(name: name);
    this.game.players.add(newPlayer);
    // call set state, telling flutter what piece of state changed
    setState(() => this.game.players);
    // setState(() => [...this.game.players]); // works
    /* also works
    setState(() {
      game.players: [...this.game.players];
    });
    */
  }

  void onDeletePlayer({String playerName}) {
    int index = 0;
    for (var i = 0; i < this.game.players.length; i++) {
      if (this.game.players[i].name == playerName) {
        index = i;
        break;
      }
    }
    this.game.players.removeAt(index);
    setState(() => this.game.players);
  }
}
