import 'package:flutter/material.dart';

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

// class DataList{
//   final String username;
//   final String todo;
//   const DataList({this.username, this.todo});
// }

// const datalist = const <DataList>[
//     const DataList(
//       username: 'Romain Hoogmoed',
//       todo:'romain.hoogmoed@example.com'
//     ),
//     const DataList(
//       username: 'Romain Hoogmoed',
//       todo:'romain.hoogmoed@example.com'
//     ),
//     const DataList(
//       username: 'Romain Hoogmoed',
//       todo:'romain.hoogmoed@example.com'
//     ),
// ];



class FirstScreen extends StatefulWidget{
  @override
  _FirstScreenState createState() => new _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  List<String> username = ["レッド", "ブルー", "イエロー"];
  List<String> todo = ["ご飯行きたい","なんでも","ちゃーん"];

  //final DataList datalist;
  //_FirstScreenState(this.datalist);
  
  @override
  Widget build(BuildContext context) {
    return  ListView(
      children: const <Widget>[
        Card(
          child: ListTile(
            leading: FlutterLogo(size: 72.0),
            title: Text('Three-line ListTile'),
            subtitle: Text(
              'A sufficiently long subtitle warrants three lines.'
            ),
            trailing: Icon(Icons.more_vert),
            isThreeLine: true,
          )
      ),
      ]
    );
  }
}