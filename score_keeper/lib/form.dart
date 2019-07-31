import 'package:flutter/material.dart';

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  MyCustomForm({@required this.onAddPlayer, @required this.playerList});
  final Function onAddPlayer;
  final List<String> playerList;
  @override
  MyCustomFormState createState() =>
      MyCustomFormState(onAddPlayer: onAddPlayer, playerList: playerList);
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  MyCustomFormState({@override this.onAddPlayer, @override this.playerList});
  final Function onAddPlayer;
  final List<String> playerList;
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>, not a GlobalKey<MyCustomFormState>.
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
              if (this.playerList.contains(value)) {
                return 'Can\'t have duplicate player name';
              }
              return null;
            },
          ),
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
                  onAddPlayer(newPlayer: myController.text);
                  myController.clear();
                }
              },
              child: Text('Add'),
            ),
          ),
        ],
      ),
    );
  }
}
