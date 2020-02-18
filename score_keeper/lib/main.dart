import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:score_keeper/models/player.dart';
import 'package:score_keeper/screens/players_screen.dart';
import 'package:score_keeper/models/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/game.dart';

void main() => runApp(Wrapper());

init() async {
  var prefs = await SharedPreferences.getInstance();
  var isDark = prefs.getBool('isDark') ?? true;
  var isWakeLock = prefs.getBool('isWakeLock') ?? true;
  return {"isDark": isDark, "isWakeLock": isWakeLock};
}

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: init(),
      builder: (context, snapshot) {
        return ChangeNotifierProvider(
          create: (context) => GameTheme(
            isDark: snapshot.data["isDark"] as bool,
            isWakeLock: snapshot.data["isWakeLock"],
          ),
          child: snapshot.data == null
              ? MaterialApp(
                  theme: ThemeData(brightness: Brightness.dark),
                  home: Center(
                    child: Icon(Icons.autorenew), // pseudo loading
                  ),
                )
              : App(),
        );
      },
    );
  }
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Score Keeper',
      theme: ThemeData(brightness: Provider.of<GameTheme>(context).brightness),
      home: MainApp(),
    );
  }
}

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final Game game = new Game(
    players: new List<Player>(),
  );

  @override
  Widget build(BuildContext context) {
    return PlayersScreen(
      game: this.game,
      onAddPlayer: this.onAddPlayer,
      onDeletePlayer: this.onDeletePlayer,
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
