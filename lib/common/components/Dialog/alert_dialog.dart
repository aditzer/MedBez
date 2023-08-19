import 'package:flutter/material.dart';

Future<void> myAlertDialog(BuildContext context, Function onTapOk, String title, String ok,String cancel) async {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        elevation: 30,
        title: Text(title, style: const TextStyle(fontSize: 20)),
        actions: <Widget>[
          TextButton(
            child: Text(cancel, style: const TextStyle(fontSize: 18)),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: Text(ok, style: const TextStyle(fontSize: 18)),
            onPressed: () {
              onTapOk();
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}

Future<void> myAlertDialog2(BuildContext context, Function onTapOk, String title, String ok,String cancel, String param1) async {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        elevation: 30,
        title: Text(title, style: const TextStyle(fontSize: 20)),
        actions: <Widget>[
          TextButton(
            child: Text(cancel, style: const TextStyle(fontSize: 18)),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: Text(ok, style: const TextStyle(fontSize: 18)),
            onPressed: () async {
              Navigator.pop(context);
              await onTapOk(param1);
            },
          ),
        ],
      );
    },
  );
}