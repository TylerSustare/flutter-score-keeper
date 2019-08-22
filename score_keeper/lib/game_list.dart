import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:core';
import 'game.dart';

class GameList extends StatefulWidget {
  GameList({@required this.game});

  final Game game;

  @override
  GameListState createState() => GameListState(game: game);
}

class GameListState extends State<GameList> {
  GameListState({@required this.game});

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
      // padding: const EdgeInsets.all(8.0),
      itemCount: game.players.length,
      itemBuilder: (BuildContext context, int index) {
        return new Card(
          child: Column(
            children: <Widget>[
              new ListTile(
                trailing: Text(
                  '${game.players[index].score}',
                  style: new TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                ),
                title: Text(
                  '${game.players[index].name}',
                  style: new TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  new FlatButton(
                    child: new Icon(
                      Icons.remove,
                      color: Colors.grey[700],
                    ),
                    onPressed: () {
                      game.players[index].decrementScore(this.game.decrementValue);
                      setState(() => game.players);
                    },
                    key: new Key(
                      '${game.players[index].name}-decrement-score',
                    ),
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
                    key: new Key(
                      '${game.players[index].name}-edit-score',
                    ),
                  ),
                  new FlatButton(
                    child: new Icon(
                      Icons.add,
                      color: Colors.grey[700],
                    ),
                    onPressed: () {
                      game.players[index].incrementScore(this.game.incrementValue);
                      setState(() => game.players);
                    },
                    key: new Key(
                      '${game.players[index].name}-increment-score',
                    ),
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
        return AlertDialog(
          title: Text('Change Score'),
          content: TextFormField(
            controller: _textFieldController,
            decoration: InputDecoration(hintText: 'Score to Add/Subtract'),
            keyboardType: TextInputType.number,
            key: Key('text-edit-score'),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text('Cancel'),
              key: Key('cancel-edit-score'),
              onPressed: () {
                Navigator.pop(context, '0');
                _textFieldController.clear();
              },
            ),
            new RaisedButton(
              child: new Text('SUBTRACT'),
              key: Key('subtract-edit-score'),
              color: Colors.red,
              textColor: Colors.white,
              onPressed: () {
                Navigator.pop(context, '-${_textFieldController.value.text}');
                _textFieldController.clear();
              },
            ),
            new RaisedButton(
              child: new Text('ADD'),
              key: Key('add-edit-score'),
              color: Colors.green,
              textColor: Colors.white,
              onPressed: () {
                Navigator.pop(context, _textFieldController.value.text);
                _textFieldController.clear();
              },
            ),
          ],
        );
      },
    );
  }
}

// here as a sad reminder of https://url.sustare.dev/gJ1FK
void _settingModalBottomSheet(context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext buildContext) {
      return Center(
        child: Container(
          child: new Wrap(
            children: <Widget>[
              new Text(
                'edit',
                key: Key('test'),
              ),
              new ListTile(
                leading: new Icon(Icons.edit),
                title: new Text('Video'),
                onTap: () {
                  print('in here');
                  Navigator.pop(context, 'video');
                },
                key: Key('tap-me'),
              ),
            ],
          ),
        ),
      );
    },
  );
}
