import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

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

  Future<List<DataList>> alldata;
  DataList datalist;

  @override
  void initState(){
    dataGet().then((onValue){
      setState(() {
        alldata = dataGet();
      });
    });

    super.initState();

  }
  Future<List<DataList>> dataGet() async {
    var dt = new List<DataList>();
    final response = await http.get('https://imahima-api.k-appdev.com/v1/posts');
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
  

  int x;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:FutureBuilder<List<DataList>>(
        future: alldata,
        builder: (context,snapshot){
          if(snapshot.hasData){
            return new Container(
            child:ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                  return new Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.black38),
                      ),
                    ),
                    child: ListTile(
                      leading: FlutterLogo(size: 72.0),
                      title: Text(snapshot.data[index].user.name),
                      subtitle: Text(snapshot.data[index].comment),
                      onTap: () { /* react to the tile being tapped */ },
                  ));
              },
            )
          );

          }else if(snapshot.hasError){
            print('error');
          }
          return CircularProgressIndicator();
        }
      )

    );
  }
}