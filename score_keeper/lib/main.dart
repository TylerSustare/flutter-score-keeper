import 'package:flutter/material.dart';
import 'package:score_keeper/player.dart';
import 'package:score_keeper/views/list.dart';

void main() => runApp(MainApp());

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final List<Player> _playerList = new List<Player>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Score Keeper',
      home: Scaffold(
        appBar: AppBar(
          /* leading: FlatButton(
            child: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {},
          ), */
          title: Text('Score Keeper - Players'),
          backgroundColor: Colors.pink,
        ),
        body: PlayerListView(
          playerList: _playerList,
          onDeletePlayer: this.onDeletePlayer,
          onAddPlayer: this.onAddPlayer,
          onResetPlayerScores: this.onResetPlayerScores,
        ),
      ),
    );
  }

  void onAddPlayer({String name}) {
    Player newPlayer = new Player(name: name);
    this._playerList.add(newPlayer);
    // call set state, telling flutter what piece of state changed
    setState(() => this._playerList);
    // setState(() => [...this._playerList]); // works
    /* also works
    setState(() {
      _playerList: [...this._playerList];
    });
    */
  }

  void onDeletePlayer({String playerName}) {
    int index = 0;
    for (var i = 0; i < this._playerList.length; i++) {
      if (this._playerList[i].name == playerName) {
        index = i;
        break;
      }
    }
    this._playerList.removeAt(index);
    setState(() => this._playerList);
  }

  void onResetPlayerScores(){
    for (var player in this._playerList) {
      player.resetScore();
    }
    setState(() => this._playerList);
  }
}
