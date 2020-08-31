import "package:flutter/material.dart";

class ManualNutritionDialogue extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Alert Dialog Titile"),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text('This is a demo alert dialog.'),
            Text('Would you like to approve of this message?'),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Approve'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
