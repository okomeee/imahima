import 'package:flutter/cupertino.dart';
import 'package:imahima/ios_pages/page1.dart';
import 'package:imahima/ios_pages/page2.dart';
import 'package:imahima/ios_pages/page3.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context ){
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: <BottomNavigationBarItem> [
         BottomNavigationBarItem(
            icon: new Icon(CupertinoIcons.home),
            title: new Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(CupertinoIcons.add),
            title: new Text('Add'),
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person),
            title: Text('Profile')
          ),
        ],
      ),
      tabBuilder: (context, index) {
        return CupertinoTabView(
          builder: (context) {
            switch (index) {
              case 0:
                return FirstScreen();
                break;
              case 1:
                return SecondScreen();
                break;
              case 2:
                return ThirdScreen();
                break;
            }
          },
        );
      },
    );
  }
}