import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:provider/provider.dart';
import '../../global_config.dart';
import '../../settings/settings_config.dart' show SettingConfig;
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/userData.dart';

class ThemeChange with ChangeNotifier {
  //初始主题
  ThemeData _indexTheme;
  //初始主题的primaryColor
  Color color = GlobalConfig.themeData.primaryColor;
  Color navcolor = GlobalConfig.themeData.bottomAppBarColor;
  ThemeData themeUsr = GlobalConfig.themeData;
  bool selected = true;
  //执行第一个通知
  ThemeChange(this._indexTheme);

  void themechange(theme) {
    //获得更改的主题
    GlobalConfig.themeData = theme;
    SettingConfig.cardIconColor =
        GlobalConfig.dark ? Colors.blue : GlobalConfig.themeData.primaryColor;
    themeUsr = theme;
    color = GlobalConfig.themeData.primaryColor;
    navcolor = GlobalConfig.themeData.bottomAppBarColor;
    //通知consumer
    notifyListeners();
  }

  //通知获得的初始主题
  get indexTheme => _indexTheme;
}

class UserData with ChangeNotifier {
  //存储用户名
  String usrName = UsrData.usrName;
  UserData(this.usrName);
  dynamic getUserData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    usrName = pref.getString('user_name');
    //通知consumer
    notifyListeners();
    return usrName;
  }
  //通知获得的初始主题
  // get usrName => _usrName;
}
