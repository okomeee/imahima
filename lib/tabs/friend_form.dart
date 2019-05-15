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

class FollowRequest {
  final String followName;
  final String followedName;

  FollowRequest({
    this.followName,
    this.followedName
  });

  Map<String, dynamic> toJson() => {
    'follow_name': followName,
    'followed_name': followedName,
  };
}

class FriendForm extends StatefulWidget{
  @override
  _FriendForm createState() => new _FriendForm();
}

class _FriendForm extends State<FriendForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  TokenStorage _tokenStorage = new TokenStorage();
  Response _res = new Response();
  String _token = '';
  String _currentName = '';
  String _name = '';

  FocusNode _nameFocusNode;

  @override
  void initState() {
    super.initState();
    _nameFocusNode = FocusNode();
    _tokenStorage.readToken().then((String t) {
      setState(() {
        if (t.length > 5) {
          List d = t.split('/////');
          // Tokenを取得
          _token = d[0];
          _currentName = d[1];
          debugPrint(_token);
          debugPrint(_currentName);
        }
      });
    });
  }

  // Railsサーバーに対してPOSTする
  // 新しいPostDataを作成
  Future<Response> _requestToAPIcreatePostData(String name) async {
    var url = "$_baseURL/v1/users";
    var request = new Request(name: name);
    final response = await http.post(url,
      body: jsonEncode(request.toJson()),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "OKOMEKOME $_token"
      }
    );
    if (response.statusCode == 201) {
      var a = Response.fromJson(jsonDecode(response.body));
      debugPrint(a.name);
      debugPrint('SUCCESS!!');
      return a;
    } else {
      showBasicDialog(
        context,
        "GETに失敗しました。",
      );
      return new Response();
    }
  }

  Future _requestToAPIUserFollow() async {
    var url = "$_baseURL/v1/users/follow";
    var request = new FollowRequest(followName: _currentName, followedName: _res.name);
    final response = await http.post(url,
      body: jsonEncode(request.toJson()),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "OKOMEKOME $_token"
      }
    );
    if (response.statusCode == 201) {
      var a = Response.fromJson(jsonDecode(response.body));
      debugPrint(a.name);
      debugPrint('SUCCESS!!');
      return a;
    } else {
      showBasicDialog(
        context,
        "POSTに失敗しました。",
      );
      return new Response();
    }
  }

  void _add() {
    debugPrint(_currentName);
    debugPrint(_res.name);
    var request = new FollowRequest(followName: _currentName, followedName: _res.name);
    debugPrint(jsonEncode(request.toJson()));
    
    _requestToAPIUserFollow();
  }

  void _submit() {
    // バリデートして問題なければ実行
    if (_formKey.currentState.validate()) {
      // TextFormField の onSavedを実行
      _formKey.currentState.save();

      // 入力内容

      // キーボードを隠す（それぞれのonSavedに書いたほうがいいかも）
      _nameFocusNode.unfocus();

      // TODO 送信処理
      _requestToAPIcreatePostData(_name).then((Response res){
        setState(() {
          _res = res;
          debugPrint(_res.name);
        });
      });
    }
  }

  @override
  void dispose() {
    _nameFocusNode.dispose();
    super.dispose();
  }

  List<Widget> wList(size) {
    List<Widget> _buffer = [];
    _buffer.add(
      Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
            key: this._formKey,
            child: Column(
              // shrinkWrap: true,
              children: <Widget>[
                SizedBox(height: 10.0),
                TextFormField(
                  decoration: InputDecoration(labelText: '名前検索', border: OutlineInputBorder()),
                  validator: (val) {
                    if (val.isEmpty) {
                      return '名前を入力してください';
                    }
                  },
                  maxLengthEnforced: true,
                  focusNode: _nameFocusNode,
                  onSaved: ((String value){
                    setState(() {
                      _name = value;
                    });
                  }),
                  autofocus: true,
                  // 複数行対応
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                ),
                SizedBox(height: 32.0),
                RaisedButton(
                  child: Text('検索'),
                  onPressed: _submit,
                )
              ]
            ),
          )
        ),
      )
    );

    if (_res.name != null) {
      _buffer.add(
        Column(
          children: <Widget>[
            Row(
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
                    _res.name,
                    style: TextStyle(
                      fontSize: size.width * 8/100
                    ),
                  ),
                  height: size.width * 15/100,
                  alignment: FractionalOffset(0.5, 1),
                ),
              ],
            ),
            Container(
              width: size.width * 50/100,
              child: new RaisedButton(
                child: new Text(
                  '友達追加',
                  style: new TextStyle(
                    color: Colors.white
                  ),
                ),
                onPressed: (){
                  _add();
                },
                color: Colors.blue,
              ),
              margin: new EdgeInsets.only(
                top: 20.0
              ),
            ),
          ],
        )
      );
    }

    return _buffer;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("友達追加"),
      ),
      body: ListView(
        children: wList(size)
      )
    );
  }
}