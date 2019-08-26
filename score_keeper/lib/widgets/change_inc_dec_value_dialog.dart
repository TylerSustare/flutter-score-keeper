import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChangeIncDecValueDialog extends StatelessWidget {
  ChangeIncDecValueDialog({@required this.textController});
  final TextEditingController textController;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Change Value'),
      content: TextFormField(
        controller: textController,
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
            textController.clear();
          },
        ),
        new RaisedButton(
          child: new Text('Update'),
          key: Key('edit-inc-dec-value'),
          color: Colors.blue,
          textColor: Colors.white,
          onPressed: () {
            Navigator.pop(context, textController.value.text);
            textController.clear();
          },
        ),
      ],
    );
  }
}
