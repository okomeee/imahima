import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:imahima/storage/token_storage.dart';

// class DataList{
//   final user_id;
//   final todo;
//   DataList({this.user_id,this.todo});
//   factory DataList.fromJson(Map<String, dynamic> json) {
//     return DataList(
//       user_id: json['user_id'],
//       todo: json['todo'],
//     );
//   }
// }

class DataList{
  final id;
  final comment;
  final time;
  final user;
  const DataList({this.id, this.comment, this.time, this.user});

  factory DataList.fromJson(Map<String, dynamic> json) {
    return DataList(
      id: json['id'],
      comment: json['comment'],
      time: json['time'],
      user: UserList.fromJson(json['user']),
    );
  }
}
class UserList{
  final id;
  final name;
  final image;
  const UserList({this.id, this.name, this.image});

  factory UserList.fromJson(Map<String, dynamic> json) {
    return UserList(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }
}


class Home extends StatefulWidget{
  @override
  _Home createState() => new _Home();
}

class _Home extends State<Home> {
  List<DataList> alldata;
  DataList datalist;
  TokenStorage _tokenStorage = new TokenStorage();
  String _token = '';

  @override
  void initState(){
    super.initState();

    _tokenStorage.readToken().then((String t) {
      setState(() {
        if (t.length > 0) {
          // Tokenを取得
          _token = t;
          debugPrint(_token);
          // APIサーバーからデータ取得 + 変数(_dataList)
          dataGet().then((List<DataList> onValue){
            setState(() {
              alldata = onValue;
            });
          });
        }
      });
    });
  }

  Future<List<DataList>> dataGet() async {
    var dt = new List<DataList>();
    final response = await http.get(
      'https://imahima-api.k-appdev.com/v1/posts',
      headers: {
        "Content-Type": "application/json",
        "Authorization": "OKOMEKOME $_token"
      }
    );
    String responseBody = utf8.decode(response.bodyBytes);
    final jsondatalist = json.decode(responseBody);
    final datalist = jsondatalist;
    if (response.statusCode == 200) {
      for(int i = 0; i < datalist.length; i++){
        dt.add(DataList.fromJson(datalist[i]));
      }
      //print(dt);
      //await new Future.delayed(new Duration(seconds: 5));
      return dt;
    } else {
      throw Exception('Failed to load post');
    }
  }

  List<Widget> wList() {
    List<Widget> _buffer = [];
    if(alldata.length > 0) {
      for(var i = 0; i < alldata.length; i++) {
        _buffer.add(
          ListTile(
            leading: FlutterLogo(size: 72.0),
            title: Text(alldata[i].user.name),
            subtitle: Text(alldata[i].comment),
            onTap: () { /* react to the tile being tapped */ },
          )
        );
      }
    }
    return _buffer;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: alldata.length > 0 ? ListView( children: wList() ) : Center( child: const CircularProgressIndicator() )
    );
  }
}