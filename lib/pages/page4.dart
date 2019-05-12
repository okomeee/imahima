import 'package:flutter/material.dart';

class AccountScreen extends StatefulWidget{
  @override
  _AccountScreenState createState() => new _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
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
                Image.network(
                  'https://okomeee.github.io/static/img/okome.fe3358c.png',
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
            children: List.generate(
              100,
              (int index) => 
                ListTile(
                  title: Center(
                    child: Text(
                      "友達${index.toString()}号",
                      style: TextStyle(
                        fontWeight: FontWeight.w500
                      ),
                    ),
                  ) 
                )
            ),
          ),
        ],
      )
    );
  }
}