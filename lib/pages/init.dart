import 'package:flutter/material.dart';
import 'home.dart';

class InitScreen extends StatefulWidget {
  @override
  _InitScreenState createState() => new _InitScreenState();
}

class _InitScreenState extends State<InitScreen>  {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Init Screen'),
      ),
      body: Center(
        child: Center(
          child: RaisedButton(
            child: Text('Home'),
            onPressed: () {
              Route route = MaterialPageRoute(builder: (context) => HomeScreen());
              Navigator.pushReplacement(context, route);
            },
          ),
        ),
      ),
    );
  }
}