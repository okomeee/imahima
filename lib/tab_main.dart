import 'package:flutter/material.dart';

import 'package:imahima/tabs/home.dart';
import 'package:imahima/tabs/hima_form.dart';
import 'package:imahima/tabs/account.dart';
import 'package:imahima/tabs/friend_form.dart';

class TabMain extends StatefulWidget {
 @override
  _TabMainState createState() => new _TabMainState();
}

class _TabMainState extends State<TabMain> {
  List<Widget> _tabs = [
    Home(),
    HimaForm(),
    Account(),
  ];
  List<String> _appBarTitles = [
    "ホーム",
    "暇追加",
    "アカウント",
  ];
  int _currentIndex = 0;
  Widget _currentTab;
  String _currentAppBarTitle;

  @override
  void initState() {
    super.initState();
    _currentTab = _tabs[_currentIndex];
    _currentAppBarTitle = _appBarTitles[_currentIndex];
  }
  

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_currentAppBarTitle),
      ),
      body: _currentTab,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        selectedItemColor : Colors.teal,
        onTap:(int index) {
          setState(() {
            _currentIndex= index;
            _currentTab = _tabs[_currentIndex];
            _currentAppBarTitle = _appBarTitles[_currentIndex];
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text('ホーム'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(
              Icons.add_circle,
              size: 40.0,
            ),
            title: new Text('暇追加'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('アカウント')
          ),
        ],
      ),
    );
  }
}