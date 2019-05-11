// ymt117
import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Screen"),
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          textBox,
          buttonSection,
        ],
      )),
    );
  }

  Widget textBox = Container(
    padding: const EdgeInsets.all(32),
    child: TextField(
      keyboardType: TextInputType.multiline,
      maxLines: null,
      decoration: InputDecoration(hintText: '遊びたい内容を入力してください'),
    ),
  );

  Widget buttonSection = Container(
    child: RaisedButton(
      onPressed: () {
        // 入力した「いまヒマ」情報をアップロードする処理
      },
      child: Text('いまヒマ'),
    ),
  );
}
