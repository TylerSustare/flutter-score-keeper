import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChangeScoreDialog extends StatelessWidget {
  ChangeScoreDialog({@required this.textFieldController});

  final TextEditingController textFieldController;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Change Score'),
      content: TextFormField(
        controller: textFieldController,
        decoration: InputDecoration(hintText: 'Score to Add/Subtract'),
        inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
        keyboardType: TextInputType.number,
        key: Key('text-edit-score'),
        autofocus: true,
      ),
      actions: <Widget>[
        new FlatButton(
          child: new Text('Cancel'),
          key: Key('cancel-edit-score'),
          onPressed: () {
            Navigator.pop(context, '0');
            textFieldController.clear();
          },
        ),
        new RaisedButton(
          child: new Text('SUBTRACT'),
          key: Key('subtract-edit-score'),
          color: Colors.red,
          textColor: Colors.white,
          onPressed: () {
            Navigator.pop(context, '-${textFieldController.value.text}');
            textFieldController.clear();
          },
        ),
        new RaisedButton(
          child: new Text('ADD'),
          key: Key('add-edit-score'),
          color: Colors.green,
          textColor: Colors.white,
          onPressed: () {
            Navigator.pop(context, textFieldController.value.text);
            textFieldController.clear();
          },
        ),
      ],
    );
  }
}
