import 'package:flutter/material.dart';
import 'dart:ui' as ui;

// ---------
// ログイン画面
// ---------
class Login extends StatefulWidget {
  @override
  _LoginState createState() => new _LoginState();
}

class _LoginState extends State<Login> {
  final myController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  
  String username,password;
  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Stack(
        children:<Widget>[
          Image.asset('images/air.png', fit: BoxFit.cover),
          BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          Center(
            child: new Form(
              child: new SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const SizedBox(height: 24.0),
                    new TextField(
                      style:TextStyle(
                        color: Colors.white.withOpacity(0.85),
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: const InputDecoration(
                        border: const UnderlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.white 
                          )
                        ),
                        labelText: 'Username',
                        fillColor: Colors.white, 
                      ),
                      onChanged: (text){
                        setState(() {
                        });
                      },
                    ),
                    const SizedBox(height: 24.0),
                    new TextField(
                      style:TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLength: 8,
                      decoration: new InputDecoration(
                        border: const UnderlineInputBorder(),
                        labelText: 'Password',
                      ),
                      onChanged:(text){
                        setState(() {
                          this.password = text;
                        });
                      }
                    ),
                    const SizedBox(height: 24.0),
                    new Center(
                      child: new RaisedButton(
                        child: const Text('Login'),
                        onPressed: () {
                          //Navigator.of(context).pushNamed("/home");
                        }
                        
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]
      ),
    );
  }
}