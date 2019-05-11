import 'package:flutter/material.dart';
import 'package:imahima/pages/page1.dart';
import 'package:imahima/pages/page2.dart';
import 'package:imahima/pages/page3.dart';

class HomeScreen extends StatefulWidget {
 @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  FirstScreen p1;
  SecondScreen p2;
  ThirdScreen p3;
  List<Widget> pages;
  List<String> barname;
  Widget currentPage;
  String currentAppbar;

  @override
  void initState(){
    //各ページをここで指定
    p1 = FirstScreen();
    p2 = SecondScreen();
    p3 = ThirdScreen();
    pages = [p1, p2, p3];
    barname = ['First Screen','Second Screen','Third Screen'];

    currentPage = pages[0];
    currentAppbar = barname[0];
    super.initState();
  }
  

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(currentAppbar),
      ),
      body: currentPage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, 
        fixedColor: Colors.blue,
        //tap時に下タブとbodywidgetの書き換え
        onTap:(int index) {
            setState(() {
              currentAppbar = barname[index];
              _currentIndex= index;
              currentPage = pages[index];
            });
          },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.add),
            title: new Text('Add'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Profile')
          ),
        ],
      ),
    );
  }
}