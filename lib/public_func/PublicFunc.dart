import 'package:flutter/material.dart';
import '../settings/settings_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:IVAT/global_config.dart';

class PublicFunc {
  static bool loading;

  static SlideTransition createTransition(
      Animation<double> animation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: const Offset(0.0, 0.0),
      ).animate(animation),
      child: child,
    );
  }

  //返回上一级
  //分别是上下文，传递参数
  static void back(BuildContext context, [Object params]) {
    Navigator.of(context).pop(params);
    loading = false;
  }

  //页面跳转
  //分别是路由名，传递参数，上下文，得到数据后的异步处理函数
  //父页面打开子页面，子页面获取参数方式
  //var args = ModalRoute.of(context).settings.arguments;
  //子页面返回父页面，父页面获取参数方式
  //通过传入的func来获取
  static void navTo(String routes, BuildContext context,
      [Object args, Function func]) {
    Navigator.of(context)
        .pushNamed("$routes", arguments: args)
        .then((value) async {
      //未传入则不执行
      if (func == null) {
      } else {
        func(value);
      }
    });
  }

  static Future<int> userLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    int login = pref.getInt("confirm_login");
    if (login == null) {
      return -1;
    } else if (login == 1) {
      return 1;
    } else {
      return 0;
    }
  }

  Widget show(BuildContext context, Widget mainWidget, String loading) {
    if (PublicFunc.loading) {
      return new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SpinKitWave(
            color: GlobalConfig.dark
                ? Colors.white
                : GlobalConfig.themeData.primaryColor,
            width: 50,
            height: 50,
            type: SpinKitWaveType.center,
          ),
          Text(loading)
        ],
      );
    } else {
      return mainWidget;
    }
  }

  Widget showMask(BuildContext context, Widget mainWidget, String loading) {
    if (PublicFunc.loading) {
      return new Stack(
        alignment: Alignment(0, 35),
        children: <Widget>[
          mainWidget,
          Column(
            children: <Widget>[
              SpinKitWave(
                color: GlobalConfig.dark
                    ? Colors.white
                    : GlobalConfig.themeData.primaryColor,
                width: 50,
                height: 50,
                type: SpinKitWaveType.center,
              ),
              Text(loading)
            ],
          )
        ],
      );
    } else {
      return mainWidget;
    }
  }

  //通用卡片样式
  static Card commonCard(Widget widget) {
    return Card(
        margin: SettingConfig.cardMargin,
        elevation: SettingConfig.customElevation, //设置阴影
        shape: SettingConfig.cardShape,
        clipBehavior: Clip.hardEdge,
        child: widget); //包含的组件
  }
}
