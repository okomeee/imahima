import 'package:flutter/material.dart';

class _ProfileData {
  String name = '';
  String description = '';
}

class ThirdScreen extends StatefulWidget{
  @override
  _ThirdScreenState createState() => new _ThirdScreenState();
  
}

class _ThirdScreenState extends State<ThirdScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  _ProfileData _data = _ProfileData();

  FocusNode _nameFocusNode;

  void _submit() {
    // バリデートして問題なければ実行
    if (_formKey.currentState.validate()) {
      // TextFormField の onSavedを実行
      _formKey.currentState.save();

      // 入力内容
      debugPrint('Name: ${_data.name}');

      // キーボードを隠す（それぞれのonSavedに書いたほうがいいかも）
      _nameFocusNode.unfocus();

      // TODO 送信処理
    }
  }

  @override
  void initState() {
    super.initState();
    _nameFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _nameFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: this._formKey,
          child: ListView(
            // shrinkWrap: true,
            children: <Widget>[
              SizedBox(height: 32.0),
              TextFormField(
                decoration: InputDecoration(labelText: '名前検索', border: OutlineInputBorder()),
                validator: (val) {
                  if (val.isEmpty) {
                    return '名前を入力してください';
                  }
                },
                maxLengthEnforced: true,
                focusNode: _nameFocusNode,
                onSaved: (String value) => this._data.name = value,
                autofocus: true,
                // 複数行対応
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),
              SizedBox(height: 32.0),
              RaisedButton(
                child: Text('検索'),
                onPressed: _submit,
              )
            ]
          ),
        )
      ),
    );
  }
}