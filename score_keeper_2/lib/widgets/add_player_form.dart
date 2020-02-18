import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:score_keeper_2/models/player.dart';
import 'package:score_keeper_2/models/theme.dart';

// Create a Form widget.
class AddPlayerForm extends StatefulWidget {
  AddPlayerForm({@required this.onAddPlayer, @required this.playerList});

  final Function onAddPlayer;
  final List<Player> playerList;

  @override
  AddPlayerFormState createState() =>
      AddPlayerFormState(onAddPlayer: onAddPlayer, playerList: playerList);
}

// Create a corresponding State class.
// This class holds data related to the form. Disposes of "controller" as well from the `dispose()` method
class AddPlayerFormState extends State<AddPlayerForm> {
  AddPlayerFormState({@override this.onAddPlayer, @override this.playerList});

  final Function onAddPlayer;
  final List<Player> playerList;

  // Create a global key that uniquely identifies the Form widget and allows validation of the form.
  // Note: This is a GlobalKey<FormState>, not a GlobalKey<AddPlayerFormState>.
  final _formKey = GlobalKey<FormState>();
  final textController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    textController.dispose();
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
                controller: textController,
                decoration: InputDecoration(
                  labelText: 'Add player',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Player name can\'t be empty';
                  }
                  if (this.playerList.length > 0) {
                    final playerMap = Map.fromIterable(this.playerList,
                        key: (player) => player.name,
                        value: (player) => player);
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
                          try {
                            // If the form is valid, display a Snackbar.
                            Scaffold.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Added "${textController.text}" to game...',
                                ),
                                duration: Duration(seconds: 1),
                                backgroundColor: Colors.pinkAccent,
                              ),
                            );
                          } catch (e) {
                            // log error
                          }
                          onAddPlayer(name: textController.text);
                          textController.clear();
                        }
                      },
                      child: Icon(
                        Icons.person_add,
                        color: Colors.white,
                      ),
                      color: Provider.of<GameTheme>(context).color,
                      key: new Key('add-player-to-game'),
                    ),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.end,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
