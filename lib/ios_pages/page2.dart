// ymt117
import 'package:flutter/cupertino.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => new _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: new CupertinoNavigationBar(
        middle: Text("PAGE2"),
      ),
      child: ListView(
        children: [
          datepicker(),
          textBox,
          buttonSection,
        ],
      ),
    );
  }

  Widget datepicker() {
    return CupertinoButton(
      onPressed: () {
        DatePicker.showDatePicker(
          context,
          showTitleActions: true,
          minTime: DateTime(2018, 3, 5),
          maxTime: DateTime(2019, 6, 7),
          onChanged: (date) {
            print('change $date');
          },
          onConfirm: (date) {
            print('change $date');
          },
          currentTime: DateTime.now(), locale: LocaleType.en);
        },
        child: Text(
          'show date time picker (English)',
          style: TextStyle(
            color: Color.fromARGB(255, 50, 200, 255),
        ),
      )
    );
  }

  Widget textBox = Container(
    padding: const EdgeInsets.all(32),
    child: CupertinoTextField(
      keyboardType: TextInputType.multiline,
      maxLines: null,
      placeholder: '遊びたい内容を入力してください',
    ),
  );

  Widget buttonSection = Container(
    child: CupertinoButton(
      onPressed: () {
        // 入力した「いまヒマ」情報をアップロードする処理
      },
      child: Text('いまヒマ'),
    ),
  );
}
