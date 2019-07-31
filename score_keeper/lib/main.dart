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
  final List<String> _playerList = new List<String>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Score Keeper',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Score Keeper'),
          backgroundColor: Colors.pink,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: <Widget>[
                MyCustomForm(onAddPlayer: this.onAddPlayer, playerList: _playerList),
                PlayerList(name: _playerList, onDeletePlayer: this.onDeletePlayer),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onAddPlayer({String newPlayer}) {
    this._playerList.add(newPlayer);
    setState(() => [...this._playerList]);
    /* same as ☝️
    setState(() {
      _playerList: [...this._playerList];
    });
    */
  }

  void onDeletePlayer({String playerName}){
    this._playerList.remove(playerName);
    setState(() {
      _playerList: [...this._playerList];
    });
  }
}
