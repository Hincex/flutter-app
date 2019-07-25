import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import './nav/nav.dart';
import 'global_config.dart' show GlobalConfig;
import 'package:provider/provider.dart';
import 'store/model/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
//路由列表
import 'settings/team/team.dart';
import 'settings/advice/advice.dart';
import 'settings/announce/annouceInfo.dart';
import 'settings/identity/identity.dart';
import 'settings/update/update.dart';
import 'settings/log/login.dart';
import 'settings/register/register.dart';
import 'settings/reset/reset_user_by_email.dart';
import 'settings/userPage/userPage.dart';
import 'settings/settings.dart';
import './data/userData.dart';
import './settings/userPage/message.dart';
import './settings/userPage/mission.dart';
import './club/club_page.dart';
import './club/club_detail.dart';
//Bmob后端云
import 'package:data_plugin/bmob/bmob.dart';

Future<int> getTheme() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  int themeIndex = pref.getInt("localTheme");
  if (pref.getString('user_name') != null)
    UsrData.usrName = pref.getString('user_name');
  if (pref.getString('user_job') != null)
    UsrData.usrJob = pref.getString('user_job');
  if (pref.getString('user_id') != null)
    UsrData.usrId = pref.getString('user_id');
  if (pref.getBool('isGrid') != null) UsrData.isGrid = pref.getBool('isGrid');
  // print(themeIndex);
  if (themeIndex != null) {
    GlobalConfig.themeData = GlobalConfig.themes[themeIndex];
    GlobalConfig.tempThemeData = GlobalConfig.themes[themeIndex];
    return themeIndex;
  } else {
    GlobalConfig.themeData = GlobalConfig.themes[1];
  }
  return 0;
}

void main() async {
  await getTheme();
  runApp(ChangeNotifierProvider<ThemeChange>.value(
    value: ThemeChange(GlobalConfig.themeData),
    child: MyApp(),
  ));
  if (Platform.isAndroid) {
    // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //初始化Bmob
    Bmob.initMasterKey("8cb37d6ed5a5b2d4734958772e340ff4",
        "70e70bc0d8707968571ff9e3bdbddecd", "b8fa07f76392288461e01f106b954112");
    return MaterialApp(
      title: '电气协会',
      theme: GlobalConfig.themeData,
      debugShowCheckedModeBanner: false,
      home: Nav(),
      //路由列表
      routes: {
        "/team": (BuildContext context) => Team(),
        "/advice": (BuildContext context) => AdviceWidget(),
        "/announce": (BuildContext context) => AnnounceInfo(),
        "/identity": (BuildContext context) => Identity(),
        "/update": (BuildContext context) => Update(),
        "/login": (BuildContext context) => Login(),
        "/register": (BuildContext context) => Register(),
        "/reset_email": (BuildContext context) => EmailReset(),
        "/user": (BuildContext context) => UserPage(),
        "/settings": (BuildContext context) => Settings(),
        "/message": (BuildContext context) => MessageInfo(),
        "/mission": (BuildContext context) => Mission(),
        "/club_page": (BuildContext context) => ClubPage(),
        "/club_detail": (BuildContext context) => ClubDetail(),
      },
    );
  }
}
