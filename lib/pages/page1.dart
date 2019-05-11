import 'package:flutter/material.dart';

class FirstScreen extends StatefulWidget{
  @override
  _FirstScreenState createState() => new _FirstScreenState();
  
}

class _FirstScreenState extends State<FirstScreen> {
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