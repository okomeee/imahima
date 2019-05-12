import 'package:flutter/cupertino.dart';

class FirstScreen extends StatefulWidget{
  @override
  _FirstScreenState createState() => new _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: new CupertinoNavigationBar(
        middle: Text("PAGE1"),
      ),
      child: Container(
        child: Center(
          child: Text("PAGE1"),
        ),
      ),
    );
  }
}