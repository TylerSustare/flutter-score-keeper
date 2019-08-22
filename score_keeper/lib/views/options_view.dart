import 'package:flutter/material.dart';
import 'package:score_keeper/game.dart';

class OptionsView extends StatefulWidget {
  OptionsView({@required this.game});
  final Game game;

  @override
  _OptionsViewState createState() => _OptionsViewState(game: this.game);
}

class _OptionsViewState extends State<OptionsView> {
  _OptionsViewState({@required this.game});
  final Game game;

  @override
  Widget build(BuildContext context) {
    this.game.incrementValue = 2;
    return Scaffold(
      appBar: AppBar(
        title: Text('Score Keeper - Options'),
      ),
      body: ListView(
        children: <Widget>[
          Card(
            child: ListTile(
              leading: Icon(Icons.edit),
              title: Row(
                children: <Widget>[
                  Icon(Icons.add),
                  Text(' '),
                  Text('value'),
                ],
              ),
              trailing: Text('${game.incrementValue}'),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.edit),
              title: Row(
                children: <Widget>[
                  Icon(Icons.remove),
                  Text(' '),
                  Text('value'),
                ],
              ),
              trailing: Text(
                '${game.decrementValue}',
                style: TextStyle(color: Colors.red, fontSize: 30.0),
              ),
              contentPadding: const EdgeInsets.fromLTRB(15.0, 0, 40.0, 0),
            ),
          )
        ],
      ),
    );
  }
}
