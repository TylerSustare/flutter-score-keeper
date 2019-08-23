import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  TextEditingController _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // this.game.incrementValue = 2;
    return Scaffold(
      appBar: AppBar(
        title: Text('Score Keeper - Options'),
        backgroundColor: Colors.green,
        // actions: <Widget>[Icon(Icons.autorenew)], // reset to default settings
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            Card(
              child: ListTile(
                leading: new RaisedButton(
                  child: new Icon(
                    Icons.edit,
                    color: Colors.grey[700],
                  ),
                  onPressed: () async {
                    String add = await _displayDialog(context);
                    if (add != null && add != '') {
                      this.game.incrementValue = int.tryParse(add);
                      setState(() => game.incrementValue);
                    }
                  },
                  key: new Key(
                    'change-increment-score',
                  ),
                ),
                title: Row(
                  children: <Widget>[
                    Icon(Icons.add),
                    Text('  '),
                    Text('value'),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
                trailing: Text(
                  '${game.incrementValue}',
                  style: TextStyle(color: Colors.red, fontSize: 30.0),
                ),
              ),
            ),
            Card(
              child: ListTile(
                leading: new RaisedButton(
                  child: new Icon(
                    Icons.edit,
                    color: Colors.grey[700],
                  ),
                  onPressed: () async {
                    String add = await _displayDialog(context);
                    if (add != null && add != '') {
                      this.game.decrementValue = int.tryParse(add);
                      setState(() => game.decrementValue);
                    }
                  },
                  key: new Key(
                    'change-decrement-score',
                  ),
                ),
                title: Row(
                  children: <Widget>[
                    Icon(Icons.remove),
                    Text('  '),
                    Text('value'),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
                trailing: Text(
                  '${game.decrementValue}',
                  style: TextStyle(color: Colors.red, fontSize: 30.0),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _displayDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Change Value'),
          content: TextFormField(
            controller: _textFieldController,
            decoration: InputDecoration(hintText: 'Number'),
            inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.number,
            key: Key('text-inc-dec-value'),
            autofocus: true,
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text('Cancel'),
              key: Key('cancel-edit-inc-dec-value'),
              onPressed: () {
                Navigator.pop(context, '');
                _textFieldController.clear();
              },
            ),
            new RaisedButton(
              child: new Text('Update'),
              key: Key('edit-inc-dec-value'),
              color: Colors.blue,
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
