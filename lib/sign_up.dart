import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:imahima/tab_main.dart';
import 'package:imahima/dialog/dialog.dart';
import 'package:imahima/storage/token_storage.dart';

// ---------
// サインアップ画面
// ---------

var _baseURL = "https://imahima-api.k-appdev.com";

class Request {
  final String name;
  final String password;
  final bool login; //他の端末でログインしているかの確認フラグ

  Request({
    this.name,
    this.password,
    this.login
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'password': password,
    'login': login
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

class SignUp extends StatefulWidget{
  @override
  _SignUp createState() => new _SignUp();
}

class _SignUp extends State<SignUp> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final nameController = TextEditingController();
  final passController = TextEditingController();

  TokenStorage _tokenStorage = new TokenStorage();
  String _token = '';

  @override
  void initState() {
    super.initState();
  }

  // Tokenをデバイスに保存
  Future<File> _setupToken(String token) async {
    setState(() {
      _token = token;
    });
    return _tokenStorage.writeToken(_token);
  }

  // Railsサーバーに対してPOSTする
  Future<Response> _requestToAPI(String name, String pass) async {
    var url = "$_baseURL/v1/users/signup";
    var request = new Request(name: name, password: pass, login: true);
    final response = await http.post(url,
        body: jsonEncode(request.toJson()),
        headers: {"Content-Type": "application/json"});
    if (response.statusCode == 201) {
      // If server returns an OK response, parse the JSON
      if (jsonDecode(response.body)!=null){
        return new Response.fromJson(jsonDecode(response.body));
      } else {
        showBasicDialog(
          context,
          "この名前は既に使用されています。",
        );
        return new Response();
      }
    } else {
      // If that response was not OK, throw an error.
      showBasicDialog(
        context,
        "サインアップに失敗しました。",
      );
      return new Response();
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    passController.dispose();
    super.dispose();
  }

  void _submit() {
    Future<Response> res = _requestToAPI(nameController.text, passController.text);
    res.then((Response response){
      if (response.name != null){
        _setupToken(response.token + '/////' + response.name);
        debugPrint('SIGN UP');
        Navigator.pushAndRemoveUntil(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => new TabMain()),
                        (_) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text("サインアップ"),),
      body: new Container(
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
                width: screenSize.width,
                child: new RaisedButton(
                  child: new Text(
                    'サインアップ',
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
              )
            ],
          ),
        )
      ),
    );
  }
}