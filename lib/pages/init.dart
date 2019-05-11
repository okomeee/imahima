import 'package:flutter/material.dart';

class InitScreen extends StatefulWidget {
  @override
  _InitScreenState createState() => new _InitScreenState();
}

class _InitScreenState extends State<InitScreen>  {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Screen'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text('Launch page1'),
              onPressed: () {
                // Navigate to the second screen using a named route
                Navigator.of(context).pushNamed("/home");
              },
            )
          ]
        )
      ),
    );
  }
}