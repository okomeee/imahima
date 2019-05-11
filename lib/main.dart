import 'package:flutter/material.dart';
import 'package:imahima/init.dart';
import 'package:flutter/rendering.dart';

void main() {
  // debugPaintSizeEnabled = true;
  // debugPaintBaselinesEnabled = true;
  // debugPaintPointersEnabled = true;
  // debugPaintLayerBordersEnabled = true;
  // debugRepaintRainbowEnabled = true;
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Imahima',
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (_) => new InitScreen(),
      },
      theme: new ThemeData.dark(),
    );
  }
}



