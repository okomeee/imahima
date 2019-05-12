import 'package:flutter/cupertino.dart';

class ThirdScreen extends StatefulWidget{
  @override
  _ThirdScreenState createState() => new _ThirdScreenState();
  
}

class _ThirdScreenState extends State<ThirdScreen> {
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