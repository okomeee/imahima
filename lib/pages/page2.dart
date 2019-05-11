// ymt117
import 'package:flutter/material.dart';

class SecondScreen extends StatefulWidget{
  @override
  _SecondScreenState createState() => new _SecondScreenState();
  
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}
