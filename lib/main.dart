import 'package:flutter/material.dart';
import 'pages/init.dart';
import 'pages/page1.dart';
import 'pages/page2.dart';
import 'pages/page3.dart';
import 'pages/home.dart';


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
      '/home':(_) => new HomeScreen(),
      '/page1': (_) => new FirstScreen(),
      '/page2': (_) => new SecondScreen(),
      '/page3': (_) => new ThirdScreen(),
    }
   );
 }
}



