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
          Text(
            '15:00 ~ 18:00 まで',
            textAlign: TextAlign.center,
            textScaleFactor: 2.5,
          ),
          FlatButton(
              onPressed: () {
                DatePicker.showTimePicker(context, showTitleActions: true,
                    onChanged: (date) {
                  print('change $date in time zone ' +
                      date.timeZoneOffset.inHours.toString());
                }, onConfirm: (date) {
                  print('change $date');
                }, currentTime: DateTime.now());
              },
              child: Text(
                '時刻を設定する',
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
