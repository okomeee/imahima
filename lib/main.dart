import 'package:flutter/material.dart';
import 'pages/init.dart';
import 'pages/login.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '今暇',
      initialRoute: '/login',//最初のページを指定
      routes: <String, WidgetBuilder>{
        '/': (_) => new InitScreen(),
        '/login':(_)=> new Login(),
      },
      theme: new ThemeData.dark(),
    );
  }
}



