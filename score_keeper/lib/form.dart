import 'package:flutter/material.dart';
import 'package:score_keeper/player.dart';

// Create a Form widget.
class PlayerForm extends StatefulWidget {
  PlayerForm({@required this.onAddPlayer, @required this.playerList});

  final Function onAddPlayer;
  final List<Player> playerList;

  @override
  PlayerFormState createState() =>
      PlayerFormState(onAddPlayer: onAddPlayer, playerList: playerList);
}

// Create a corresponding State class.
// This class holds data related to the form.
class PlayerFormState extends State<PlayerForm> {
  PlayerFormState({@override this.onAddPlayer, @override this.playerList});

  final Function onAddPlayer;
  final List<Player> playerList;

  // Create a global key that uniquely identifies the Form widget and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>, not a GlobalKey<PlayerFormState>.
  final _formKey = GlobalKey<FormState>();
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: myController,
                decoration: InputDecoration(
                  labelText: 'Add player',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Player name can\'t be empty';
                  }
                  if (this.playerList.length > 0) {
                    final playerMap = Map.fromIterable(this.playerList,
                        key: (player) => player.name, value: (player) => player);
                    if (playerMap[value] != null) {
                      return 'Can\'t have duplicate player name';
                    }
                  }
                  return null;
                },
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: RaisedButton(
                      onPressed: () {
                        // Validate returns true if the form is valid, false if not
                        if (_formKey.currentState.validate()) {
                          // If the form is valid, display a Snackbar.
                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Added "${myController.text}" to game...',
                              ),
                              duration: Duration(seconds: 2),
                              backgroundColor: Colors.pinkAccent,
                            ),
                          );
                          onAddPlayer(name: myController.text);
                          myController.clear();
                        }
                      },
                      child: Text('Add Player to Game'),
                    ),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
