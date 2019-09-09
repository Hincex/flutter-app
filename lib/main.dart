import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import './nav/nav.dart';
import 'global_config.dart' show GlobalConfig;
import 'package:provider/provider.dart';
import 'store/model/index.dart';
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
import './settings/userPage/message.dart';
import './settings/userPage/mission.dart';
import './club/club_page.dart';
import './club/club_detail.dart';
//Bmob后端云
import 'package:data_plugin/bmob/bmob.dart';
import './util/usrSetting_util.dart';

void main() async {
//  获取用户本地设置
  await UsrSettingUtil.getUsrSetting();
//  执行第一次通知
  runApp(ChangeNotifierProvider<ThemeChange>.value(
    value: ThemeChange(GlobalConfig.themeData),
    child: MyApp(),
  ));
//  安卓端设置沉浸
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
