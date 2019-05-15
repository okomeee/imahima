import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:imahima/sign_in.dart';
import 'package:imahima/sign_up.dart';

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
        '/': (_) => new SignIn(),
        '/singup': (_) => new SignUp(),
      },
      // theme: new ThemeData.dark(),
    );
  }
}



