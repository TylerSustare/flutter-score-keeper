import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:score_keeper_2/models/game.dart';
import 'package:score_keeper_2/widgets/change_inc_dec_value_dialog.dart';
import 'package:score_keeper_2/models/theme.dart';

class OptionsScreen extends StatefulWidget {
  OptionsScreen({@required this.game});
  final Game game;

  @override
  _OptionsScreenState createState() => _OptionsScreenState(game: this.game);
}

class _OptionsScreenState extends State<OptionsScreen> {
  _OptionsScreenState({@required this.game});
  final Game game;
  TextEditingController _textFieldController = TextEditingController();

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                leading: Text(
                  'Night Mode',
                  style: TextStyle(fontSize: 24.0),
                ),
                trailing: Switch(
                  onChanged: (value) =>
                      Provider.of<GameTheme>(context, listen: false)
                          .toggleDark(),
                  value: Provider.of<GameTheme>(context).isDark,
                ),
              ),
            ),
            Card(
              child: ListTile(
                leading: Text(
                  'Keep Phone Awake',
                  style: TextStyle(fontSize: 24.0),
                ),
                trailing: Switch(
                  onChanged: (value) =>
                      Provider.of<GameTheme>(context, listen: false)
                          .toggleWakeLock(),
                  value: Provider.of<GameTheme>(context).isWakeLock,
                  // value: false,
                ),
              ),
            ),
            Card(
              child: ListTile(
                leading: new RaisedButton(
                  color: Provider.of<GameTheme>(context).color,
                  child: new Icon(
                    Icons.edit,
                    color: Colors.white,
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
                  color: Provider.of<GameTheme>(context).color,
                  child: new Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    String add = await _displayDialog(context);
                    if (add != null && add != '') {
                      this.game.decrementValue = int.tryParse(add);
                      setState(() => game.decrementValue);
                    }
                  },
                  key: new Key('change-decrement-score'),
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
        return ChangeIncDecValueDialog(textController: _textFieldController);
      },
    );
  }
}
