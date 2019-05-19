// ymt117
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import '../dialog/dialog.dart';
import 'package:imahima/storage/token_storage.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';


class Request {
  final String comment;
  final String time;
  final String token;

  Request({
    this.comment,
    this.time,
    this.token
  });

  Map<String, dynamic> toJson() => {
    'comment': comment,
    'time' : time,
    'token' :token
  };
}


class Response {
  final String comment;
  final String time;
  final String token;

  Response({
    this.comment,
    this.time,
    this.token
  });

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
      comment: json['comment'],
      time: json['time'],
      token: json['token'],
    );
  }
}

class HimaForm extends StatefulWidget {
  @override
  _HimaForm createState() => new _HimaForm();
}

class _HimaForm extends State<HimaForm> {
  //DateTime _date = DateTime.now();
  
  final _formKeyPost = new GlobalKey<FormState>();
  final commentController = TextEditingController();
  String formattedDate = DateFormat('kk:mm').format(DateTime.now());
  TokenStorage _tokenStorage = new TokenStorage();

  Response _postRes;
  String _postResText = "";
  //String _postResTime = 
  String _token = '';

  @override
  void initState() {
    super.initState();
    // 認証用Tokenをデバイスから変数(_token)に保存
    _tokenStorage.readToken().then((String token) {
      setState(() {
        if (token.length > 5) {
          List d = token.split('/////');
          // Tokenを取得
          _token = d[0];
        }
      });
    });
  }

  Widget timePicker() {
    return FlatButton(
        onPressed: () {
          DatePicker.showTimePicker(context, showTitleActions: true,
              onChanged: (date) {
            debugPrint('change $date in time zone ' +
                date.timeZoneOffset.inHours.toString());
          }, onConfirm: (date) {
            setState(() {
              formattedDate = DateFormat('y-MM-d kk:mm').format(date);
              print(formattedDate);
            });
            debugPrint('change $date');
          }, currentTime: DateTime.now());
        },
        child: Text(
          '時刻を設定する',
          style: TextStyle(color: Colors.blue),
          textScaleFactor: 1.5,
        )
    );
  }

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  void _post() {
    Future<Response> res = _requestToAPIcreatePostData(commentController.text,formattedDate);
    res.then((Response response){
      _postRes = response;
      setState(() {
        _postResText = "comment: ${_postRes.comment}\ntime: ${_postRes.time}\ntoken: ${_postRes.token}";
      });
    });
  }
  

  Future<Response> _requestToAPIcreatePostData(String con, String tim) async {
    var url = "https://imahima-api.k-appdev.com/v1/posts";
    var request = new Request(comment: con, time: tim, token: _token );
    final response = await http.post(url,
      body: jsonEncode(request.toJson()),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "OKOMEKOME $_token"
      }
    );
    if (response.statusCode == 201) {
      return Response.fromJson(jsonDecode(response.body));
    } else {
      showBasicDialog(
        context,
        "GETに失敗しました。",
      );
      return new Response();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: this._formKeyPost,
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 150.0),
          children: [
            Text(
              ' ~ $formattedDate まで',
              textAlign: TextAlign.center,
              textScaleFactor: 2.5,
            ),
            timePicker(),
            //textBox,
            //buttonSection,
            Container(
              padding: const EdgeInsets.all(32),
              child: TextField(
                controller: commentController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(hintText: '遊びたい内容を入力してください'),
                
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: RaisedButton(
                onPressed: () {
                  if (_formKeyPost.currentState.validate()) {
                  _post();
                  }
                },
                child: Text('「いまヒマ」情報を登録する'),
              ),
            ),
          ],
        ),
      )
    );
  }
}
