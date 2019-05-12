// ymt117
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => new _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  //DateTime _date = DateTime.now();
  String formattedDate = DateFormat('kk:mm').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 150.0),
        children: [
          Text(
            ' ~ $formattedDate まで',
            textAlign: TextAlign.center,
            textScaleFactor: 2.5,
          ),
          timePicker(),
          textBox,
          buttonSection,
        ],
      ),
    );
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
              formattedDate = DateFormat('kk:mm').format(date);
            });
            debugPrint('change $date');
          }, currentTime: DateTime.now());
        },
        child: Text(
          '時刻を設定する',
          style: TextStyle(color: Colors.blue),
          textScaleFactor: 1.5,
        ));
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
    padding: const EdgeInsets.symmetric(horizontal: 50.0),
    child: RaisedButton(
      onPressed: () {
        // 入力した「いまヒマ」情報をアップロードする処理
      },
      child: Text('「いまヒマ」情報を登録する'),
    ),
  );
}
