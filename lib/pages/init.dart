import 'package:flutter/material.dart';

class InitScreen extends StatelessWidget {
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
                Navigator.pushNamed(context, '/page1');
              },
            ),
            RaisedButton(
              child: Text('Launch page2'),
              onPressed: () {
                // Navigate to the second screen using a named route
                Navigator.pushNamed(context, '/page2');
              },
            ),
            RaisedButton(
              child: Text('Launch page3'),
              onPressed: () {
                // Navigate to the second screen using a named route
                Navigator.pushNamed(context, '/page3');
              },
            ),
          ],
        )
      ),
    );
  }
}