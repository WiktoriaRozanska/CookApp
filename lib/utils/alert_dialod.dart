import 'package:flutter/material.dart';

enum DialogsAction { yes, cancel }

class AlertDialogs {
  static Future<DialogsAction?> yesCancelDialog(
      BuildContext context, String title, String body) async {
    final action = await showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            title: Text(title),
            content: Text(body),
            actions: [
              FlatButton(
                  onPressed: () =>
                      Navigator.of(context).pop(DialogsAction.cancel),
                  child: const Text(
                    'No',
                  )),
              FlatButton(
                onPressed: () => Navigator.of(context).pop(DialogsAction.yes),
                child: const Text(
                  'Yes',
                  style: TextStyle(color: Colors.red),
                ),
              )
            ],
          );
        });
    return (action != null) ? action : DialogsAction.cancel;
  }
}
