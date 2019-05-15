import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:imahima/storage/token_storage.dart';
import 'package:imahima/dialog/dialog.dart';


var _baseURL = "https://imahima-api.k-appdev.com";

class Response {
  final int id;
  final String name;
  final String image;

  Response({
    this.id,
    this.name,
    this.image,
  });

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
      id: json["id"],
      name: json["name"],
      image: json["image"],
    );
  }
}

class Request {
  final String name;

  Request({
    this.name,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
  };
}

class Account extends StatefulWidget{
  @override
  _AccountState createState() => new _AccountState();
}

class _AccountState extends State<Account> {
  TokenStorage _tokenStorage = new TokenStorage();
  List<Response> _resList = [];
  String _token = '';
  String _currentName = '';

  @override
  void initState() {
    super.initState();
    _tokenStorage.readToken().then((String t) {
      setState(() {
        if (t.length > 5) {
          List d = t.split('/////');
          // Tokenを取得
          _token = d[0];
          _currentName = d[1];
          debugPrint(_token);
          debugPrint(_currentName);
          _requestToAPIcreatePostData(_currentName).then((List<Response> reslist){
            setState(() {
              _resList = reslist;
            });
          });
        }
      });
    });
    
  }

  Future<List<Response>> _requestToAPIcreatePostData(String name) async {
    var url = "$_baseURL/v1/users/follower";
    var request = new Request(name: _currentName);
    final response = await http.post(url,
      body: jsonEncode(request.toJson()),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "OKOMEKOME $_token"
      }
    );
    List<Response> list = [];
    String responseBody = utf8.decode(response.bodyBytes);
    final jsondatalist = json.decode(responseBody);
    if (response.statusCode ==   201) {
      for(int i = 0; i < jsondatalist.length; i++){
        list.add(Response.fromJson(jsondatalist[i]));
      }
      return list;
    } else {
      showBasicDialog(
        context,
        "GETに失敗しました。",
      );
      return new List<Response>();
    }
  }

  List<Widget> wList() {
    List<Widget> _budder = [];
    debugPrint(_resList[0].name);
    for(var i = 0; i< _resList.length; i++){
      _budder.add(
        Center(
          child: Text(
            _resList[i].name,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
          ),
        ) 
      );
    }
    return _budder;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 20, bottom: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Image.asset(
                  'images/image.png',
                  fit: BoxFit.cover,
                  width: size.width * 15/100,
                ),
                Container(
                  child: Text(
                    "Okome",
                    style: TextStyle(
                      fontSize: size.width * 8/100
                    ),
                  ),
                  height: size.width * 15/100,
                  alignment: FractionalOffset(0.5, 1),
                ),
              ],
            ),
          ),
          ExpansionTile(
            title: Padding(
              padding: EdgeInsets.only(left: size.width * 7/100),
              child: Text(
                "友達",
                style: TextStyle(
                  fontSize: size.width * 5/100,
                ),
              ),
            ),
            children: _resList.length > 0 ? wList() : [],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/friend');
        },
      ),
    );
  }
}