import 'package:flutter/material.dart';
import 'package:imahima/init.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '今暇',
      initialRoute: '/',//最初のページを指定
      routes: <String, WidgetBuilder>{
        '/': (_) => new InitScreen(),
      },
      theme: new ThemeData.dark(),
    );
  }
}



