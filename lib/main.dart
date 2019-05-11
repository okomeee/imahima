import 'package:flutter/material.dart';
import 'pages/init.dart';
import 'pages/page1.dart';
import 'pages/page2.dart';
import 'pages/page3.dart';

void main() {
  runApp(MaterialApp(
    title: '今暇',
    initialRoute: '/',
    routes: {
      '/': (context) => InitScreen(),
      '/page1': (context) => FirstScreen(),
      '/page2': (context) => SecondScreen(),
      '/page3': (context) => ThirdScreen(),
    },
  ));
}



