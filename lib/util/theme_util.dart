import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:IVAT/global_config.dart';
import 'package:toast/toast.dart';
import 'package:provider/provider.dart';
import '../store/model/index.dart';
import 'dart:async';
import 'package:IVAT/public_func/PublicFunc.dart';

class ThemeUtil {
  //功能函数
//本地持久化主题设置
  static void saveTheme(index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('localTheme', index);
    // print(index);
  }

//判断是否夜间模式
  static void setTheme(index, BuildContext context) {
    if (GlobalConfig.dark) {
      Toast.show('请先关闭夜间模式！', context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
    } else {
      GlobalConfig.tempThemeData = GlobalConfig.themes[index];
      GlobalConfig.themeData = GlobalConfig.themes[index];
      Provider.of<ThemeChange>(context).themechange(GlobalConfig.themes[index]);
      saveTheme(index);
      Timer(Duration(milliseconds: 50), () {
        // 只在倒计时结束时回调
        PublicFunc.back(context);
      });
    }
  }

//选择主题
  static void selectTheme(BuildContext context) {
    //主题选择对话框
    showDialog<Null>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return SimpleDialog(
            backgroundColor: GlobalConfig.dark
                ? ThemeData.dark().backgroundColor
                : Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            title: Text(
              '选择你的主题',
              style: TextStyle(
                  color: GlobalConfig.dark ? Colors.white : Colors.black),
              textAlign: TextAlign.center,
            ),
            children: <Widget>[
              ListTile(
                title: Text('水鸭青',
                    style: TextStyle(
                        color:
                            GlobalConfig.dark ? Colors.white : Colors.black)),
                trailing: CircleAvatar(backgroundColor: Colors.teal),
                onTap: () {
                  setTheme(1, context);
                },
              ),
              ListTile(
                title: Text('基佬紫',
                    style: TextStyle(
                        color:
                            GlobalConfig.dark ? Colors.white : Colors.black)),
                trailing: CircleAvatar(backgroundColor: Colors.purple),
                onTap: () {
                  setTheme(2, context);
                },
              ),
              ListTile(
                title: Text('姨妈红',
                    style: TextStyle(
                        color:
                            GlobalConfig.dark ? Colors.white : Colors.black)),
                trailing: CircleAvatar(backgroundColor: Colors.red),
                onTap: () {
                  setTheme(3, context);
                },
              ),
              ListTile(
                title: Text('少女粉',
                    style: TextStyle(
                        color:
                            GlobalConfig.dark ? Colors.white : Colors.black)),
                trailing: CircleAvatar(backgroundColor: Colors.pinkAccent),
                onTap: () {
                  setTheme(4, context);
                },
              ),
              ListTile(
                title: Text('谷歌蓝',
                    style: TextStyle(
                        color:
                            GlobalConfig.dark ? Colors.white : Colors.black)),
                trailing: CircleAvatar(backgroundColor: Colors.blue),
                onTap: () {
                  setTheme(5, context);
                },
              ),
              // ListTile(
              //   title: Text('羽光白',
              //       style: TextStyle(
              //           color: GlobalConfig.dark ? Colors.white : Colors.black)),
              //   trailing: CircleAvatar(backgroundColor: Colors.white),
              //   onTap: () {
              //     setTheme(6, context);
              //   },
              // ),
            ]);
      },
    );
  }

//夜间/日间模式切换
  static void themeMode(BuildContext context) {
    GlobalConfig.dark = !GlobalConfig.dark;
    /**主题切换逻辑 */
    GlobalConfig.themeData =
        GlobalConfig.dark ? GlobalConfig.themes[0] : GlobalConfig.tempThemeData;
    Provider.of<ThemeChange>(context).themechange(GlobalConfig.themeData);
  }
}
