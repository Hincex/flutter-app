import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../global_config.dart' show GlobalConfig; //全局设置
import './pages/index_page.dart';
import './pages/second_page.dart';
import './pages/third_page.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController _tabController; //需要定义一个Controller
  List tabs = ["新闻", "历史", "图片"];
  Color buttonBackGround;
  @override
  void initState() {
    super.initState();
    // 创建Controller
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: GlobalConfig.themeData,
        home: Scaffold(
          appBar: AppBar(
              backgroundColor: GlobalConfig.themeData.primaryColor,
//          bottom: TabsOwn(),
              title: Text("首页"),
              // brightness: Brightness.dark,
              centerTitle: true,
              elevation: 0.0,
              leading: IconButton(
                icon: Icon(Icons.menu),
                tooltip: '菜单',
                onPressed: () {},
              ),
              actions: <Widget>[
                IconButton(
                    icon: Icon(Icons.search), tooltip: '搜索', onPressed: () {}),
              ],
              bottom: TabBar(
                indicatorColor: GlobalConfig.themeData.primaryColor,
                //生成Tab菜单
                controller: _tabController,
                // tabs: tabs.map((e) => Tab(Icon: e)).toList()),
                isScrollable: false,
                indicatorSize: TabBarIndicatorSize.label,
                labelPadding: EdgeInsets.only(bottom: 5),
                tabs: <Widget>[
                  Icon(Icons.toys),
                  Icon(Icons.details),
                  Icon(Icons.adjust)
                ],
              )),
          body: TabBarView(
            controller: _tabController,
            // children: tabs.map((e) {
            //   //创建3个Tab页
            //   return Container(
            //     alignment: Alignment.center,
            //     child: Text(e, textScaleFactor: 5),
            //   );
            // }).toList()),
            children: <Widget>[Index(), Second(), Third()],
          ),
          floatingActionButton: FloatingActionButton(
            //悬浮按钮
            backgroundColor: GlobalConfig.dark
                ? Colors.black
                : (GlobalConfig.themeData == GlobalConfig.lightModeWhite
                    ? Colors.grey
                    : GlobalConfig.themeData.primaryColor),
            foregroundColor: Colors.white,
            child: Icon(Icons.add),
            onPressed: () => {},
          ),
        ));
  }
}
