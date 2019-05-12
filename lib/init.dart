import 'package:flutter/material.dart';
import 'package:imahima/ios_pages/home.dart' as prefix0;
import 'package:imahima/pages/home.dart' as prefix1;
import 'package:imahima/pages/login.dart';

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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            RaisedButton(
              child: Text('LOGIN'),
              onPressed: () {
                Route route = MaterialPageRoute(builder: (context) => prefix1.HomeScreen());
                Navigator.pushReplacement(context, route);
              },
            ),
            RaisedButton(
              child: Text('LOGINPAGE'),
              onPressed: () {
                Route route = MaterialPageRoute(builder: (context) => Login() );
                Navigator.pushReplacement(context, route);
              },
            ),
            RaisedButton(
              child: Text('iOS Style'),
              onPressed: () {
                Route route = MaterialPageRoute(builder: (context) => prefix0.HomeScreen());
                Navigator.pushReplacement(context, route);
              },
            ),
          ]
        ),
      ),
    );
  }
}