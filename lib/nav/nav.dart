import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
//页面
import '../home/home.dart';
import '../my/my.dart';
import '../club/club.dart';
import '../settings/settings.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:provider/provider.dart';
import '../store/model/index.dart';

List<Color> iconColor = <Color>[
  Colors.black,
  Colors.grey,
  Colors.grey,
  Colors.grey
];
int tempIndex = 0;

class Nav extends StatefulWidget {
  @override
  NavState createState() => NavState();
}

class NavState extends State<Nav> with TickerProviderStateMixin {
  /*默认选中首页*/
  int _currentIndex = 0;
  /*进行跳转的四个页面*/
  List<StatefulWidget> _pageList;
  StatefulWidget _currentPage;

  void initState() {
    super.initState();

    // _pageList = <StatefulWidget>[Home(), My(), Club(), Settings()];
    _pageList = <StatefulWidget>[Home(), Club(), Settings()];
    _currentPage = _pageList[_currentIndex];
  }

  void handleSelect(index) {
    for (var i = 0; i < iconColor.length; i++) {
      iconColor[i] = Colors.grey;
    }
    iconColor[index] = Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        children: <Widget>[Home(), Club(), Settings()],
        index: _currentIndex,
      ),
      bottomNavigationBar: CurvedNavigationBar(
          color: Provider.of<ThemeChange>(context).navcolor,
          height: 65.0,
          backgroundColor: Provider.of<ThemeChange>(context).color,
          buttonBackgroundColor: Colors.white,
          items: <Widget>[
            Icon(Icons.home, size: 30, color: iconColor[0]),
            // Icon(Icons.people, size: 30, color: iconColor[1]),
            Icon(Icons.book, size: 30, color: iconColor[1]),
            Icon(Icons.settings, size: 30, color: iconColor[2]),
          ],
          onTap: (index) {
            //Handle button tap
            setState(() {
              _currentIndex = index;
              _currentPage = _pageList[_currentIndex];
              tempIndex = index;
              handleSelect(index);
            });
          }),
    );
  }
}

//BottomNavyBar(
//backgroundColor: GlobalConfig.dark?GlobalConfig.darkMode.bottomAppBarColor:GlobalConfig.lightMode.bottomAppBarColor,
////设置当前页面索引
//onItemSelected: (index) => setState(() {
//currentIndex = index;
//}),
//items: [
//BottomNavyBarItem(
//icon: Icon(Icons.apps),
//title: Text('首页'),
//activeColor: GlobalConfig.themeData.primaryColor,
//inactiveColor: Colors.black,
//),
//BottomNavyBarItem(
//icon: Icon(Icons.people),
//title: Text('我的'),
//activeColor: GlobalConfig.themeData.primaryColor,
//inactiveColor: Colors.black,
//),
//BottomNavyBarItem(
//icon: Icon(Icons.message),
//title: Text('社区'),
//activeColor: GlobalConfig.themeData.primaryColor,
//inactiveColor: Colors.black,
//),
//BottomNavyBarItem(
//icon: Icon(Icons.settings),
//title: Text('设置'),
//activeColor: GlobalConfig.themeData.primaryColor,
//inactiveColor: Colors.black,
//),
//],
//)
//   bottomNavigationBar: BottomNavyBar(
//     backgroundColor: GlobalConfig.dark?GlobalConfig.darkMode.bottomAppBarColor:GlobalConfig.lightMode.bottomAppBarColor,
//     iconSize: 24.0,
//     //设置当前的索引
//     onItemSelected: (index) => setState(() {
//           currentIndex = index;
//         }),
//     items: [
//       BottomNavyBarItem(
//           icon: Icon(Icons.apps),
//           title: Text('首页'),
//           activeColor: Colors.red,
//           inactiveColor: Colors.grey),
//       BottomNavyBarItem(
//           icon: Icon(Icons.people),
//           title: Text('我的'),
//           activeColor: Colors.purpleAccent,
//           inactiveColor: Colors.grey),
//       BottomNavyBarItem(
//           icon: Icon(Icons.message),
//           title: Text('社区'),
//           activeColor: Colors.pink,
//           inactiveColor: Colors.grey),
//       BottomNavyBarItem(
//           icon: Icon(Icons.settings),
//           title: Text('设置'),
//           activeColor: Colors.blue,
//           inactiveColor: Colors.grey)
//   ],
// )
