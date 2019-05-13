import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";
import "dart:io";

enum _DialogActionType {
  cancel,
  ok,
}
 
void showBasicDialog(BuildContext context, String text) {
  showDialog(
    context: context,
    builder: (context) {
      return Platform.isIOS?_ios(context, text):_android(context, text);
    }
  ).then<void>((value) {
    // ボタンタップ時の処理
    switch (value) {
      case _DialogActionType.cancel:
        print("cancel");
        break;
      case _DialogActionType.ok:
        print("ok");
        break;
      default:
        // print("default");
    }
  });
}

Widget _ios(context, text) {
  return CupertinoAlertDialog(
    title: new Text(
      text,
      style: TextStyle(color: Colors.redAccent),
    ),
    actions: <Widget>[
      new FlatButton(
        child: const Text(
          "ReTry!",
          style: TextStyle(color: Colors.black),
        ),
        onPressed: () {
          print("Failed!");
          Navigator.pop(context);
        }
      ),
    ],
  );
}

Widget _android(context, text) {
  return CupertinoAlertDialog(
    title: new Text(
      text,
      style: TextStyle(color: Colors.redAccent),
    ),
    actions: <Widget>[
      new FlatButton(
        child: const Text(
          "ReTry!",
          style: TextStyle(color: Colors.black),
        ),
        onPressed: () {
          print("Faied!");
          Navigator.pop(context);
        }
      ),
    ],
  );
}