// ymt117
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => new _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          FlatButton(
              onPressed: () {
                DatePicker.showDatePicker(context,
                    showTitleActions: true,
                    minTime: DateTime(2018, 3, 5),
                    maxTime: DateTime(2019, 6, 7), onChanged: (date) {
                  print('change $date');
                }, onConfirm: (date) {
                  print('change $date');
                }, currentTime: DateTime.now(), locale: LocaleType.jp);
              },
              child: Text(
                'show date time picker (Japanese)',
                style: TextStyle(color: Colors.blue),
              )),
          textBox,
          buttonSection,
        ],
      ),
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
