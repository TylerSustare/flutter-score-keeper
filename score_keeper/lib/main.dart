import 'package:flutter/material.dart';
import 'package:score_keeper/form.dart';
import 'package:score_keeper/player_list.dart';
import 'package:score_keeper/player.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Player> _playerList = new List<Player>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Score Keeper',
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Score Keeper'),
            backgroundColor: Colors.pink,
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: <Widget>[
                  MyCustomForm(
                      onAddPlayer: this.onAddPlayer, playerList: _playerList),
                  PlayerList(
                      name: _playerList, onDeletePlayer: this.onDeletePlayer),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onAddPlayer({String name}) {
    Player newPlayer = new Player(name: name);
    this._playerList.add(newPlayer);
    setState(() => this._playerList);
    // setState(() => [...this._playerList]);
    /* same as ☝️
    setState(() {
      _playerList: [...this._playerList];
    });
    */
  }

  void onDeletePlayer({String playerName}) {
    int index = 0;
    for (var i = 0; i < this._playerList.length; i++) {
      if (this._playerList[i].name == playerName){
        index = i;
        break;
      }
    }
    this._playerList.removeAt(index);
    setState(() => this._playerList);
  }
}
