import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:imahima/tab_main.dart';
import 'package:imahima/dialog/dialog.dart';
import 'package:imahima/storage/token_storage.dart';

var _baseURL = "https://imahima-api.k-appdev.com";

class Request {
  final String name;
  final String password;

  Request({
    this.name,
    this.password
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'password': password,
  };
}

class Response {
  final String name;
  final String token;

  Response({
    this.name,
    this.token
  });

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
      name: json['name'],
      token: json['token'],
    );
  }
}

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => new _SignInState();
}

class _SignInState extends State<SignIn> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final nameController = TextEditingController();
  final passController = TextEditingController();

  TokenStorage _tokenStorage = new TokenStorage();
  String _token = '';

  Future<File> _setupToken(String t) async {
    setState(() {
      _token = t;
    });
    return _tokenStorage.writeToken(_token);
  }

  Future<Response> _requestToAPI(String name, String pass) async {
    var url = "$_baseURL/v1/users/signin";
    var request = new Request(name: name, password: pass);
    final response = await http.post(url,
        body: jsonEncode(request.toJson()),
        headers: {"Content-Type": "application/json"});
    if (response.statusCode == 201) {
      return Response.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 111) {
      showBasicDialog(context, "You are logged in with another terminal!");
      return new Response();
    } else {
      showBasicDialog(context, "Failed!");
      return new Response();
    }
  }

  void _submit() {
    // バリデートして問題なければ実行
    if (_formKey.currentState.validate()) {
      // TextFormField の onSavedを実行
      _formKey.currentState.save();

      // 入力内容
      // debugPrint('Name: ${_data.name}');

      // TODO 送信処理
      Future<Response> r = _requestToAPI(nameController.text, passController.text);
      r.then((Response response){
        if (response.name != null){
          _setupToken(response.token + '/////' + response.name);
          debugPrint('SIGN IN');
          debugPrint(response.token);
          Route route = MaterialPageRoute(builder: (context) => TabMain() );
          Navigator.pushReplacement(context, route);
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _tokenStorage.readToken().then((String t) {
      setState(() {
        _token = t;
      });
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    
    return new Scaffold(
      body: Stack(
        children:<Widget>[
          Center(
            child: Image.asset(
              'images/air.png',
              fit: BoxFit.cover,
              height: size.height,
            ),
          ),
          BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          Container(
            padding: new EdgeInsets.all(20.0),
            child: new Form(
              key: _formKey,
              child: new ListView(
                children: <Widget>[
                  new TextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.text,
                    decoration: new InputDecoration(
                      hintText: '名前を入力してください',
                      labelText: '名前'
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return '名前を入力してください';
                      }
                    },
                  ),
                  new TextFormField(
                    controller: passController,
                    obscureText: true,
                    decoration: new InputDecoration(
                      hintText: 'パスワードを入力してください',
                      labelText: 'パスワード'
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'パスワードを入力してください';
                      }
                    },
                  ),
                  new Container(
                    width: size.width,
                    child: new RaisedButton(
                      child: new Text(
                        'サインイン',
                        style: new TextStyle(
                          color: Colors.white
                        ),
                      ),
                      onPressed: (){
                        if (_formKey.currentState.validate()) {
                          _submit();
                        }
                      },
                      color: Colors.blue,
                    ),
                    margin: new EdgeInsets.only(
                      top: 20.0
                    ),
                  ),
                ],
              ),
            )
          ),
        ],
      ),
    );
  }
}