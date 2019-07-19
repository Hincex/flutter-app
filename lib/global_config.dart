import 'package:flutter/material.dart';

class GlobalConfig {
  //默认日间模式且默认主题
  static bool dark = false;
  static ThemeData themeData = lightMode;
  static ThemeData tempThemeData = lightMode;

  static List<ThemeData> themes = [
    darkMode,
    lightMode,
    lightModePurple,
    lightModeRed,
    lightModePink,
    lightModeBlue,
    lightModeWhite
  ];

  //夜间模式主题
  static ThemeData darkMode = ThemeData.dark().copyWith(
    accentColor: Colors.blue, //前景色，文本，按钮等
    accentColorBrightness: Brightness
        .light, //accentColor的亮度,用于确定放置在突出颜色顶部的文本和图标的颜色（例如FloatingButton上的图标）
    backgroundColor: Colors.white, //与primaryColor对比的颜色(例如 用作进度条的剩余部分)
    bottomAppBarColor: Colors.black, //BottomAppBar的默认颜色
    brightness:
        Brightness.light, //应用程序整体主题的亮度。 由按钮等Widget使用，以确定在不使用主色或强调色时要选择的颜色
    buttonColor: Colors.black, //Material中RaisedButtons使用的默认填充色
    primaryColor: Colors.black, //App主要部分的背景色（ToolBar,Tabbar等）
    toggleableActiveColor:
        Colors.blue, //用于突出显示切换Widget（如Switch，Radio和Checkbox）的活动状态的颜色
  );

  //日间模式默认主题
  static ThemeData lightMode = ThemeData(
//    accentColor: Colors.black,  //前景色，文本，按钮等
    accentColorBrightness: Brightness
        .dark, //accentColor的亮度,用于确定放置在突出颜色顶部的文本和图标的颜色（例如FloatingButton上的图标）
    backgroundColor: Colors.white, //与primaryColor对比的颜色(例如 用作进度条的剩余部分)
    bottomAppBarColor: Colors.white, //BottomAppBar的默认颜色
    brightness:
        Brightness.light, //应用程序整体主题的亮度。 由按钮等Widget使用，以确定在不使用主色或强调色时要选择的颜色
    buttonColor: Colors.teal, //Material中RaisedButtons使用的默认填充色
    primaryColor: Colors.teal, //App主要部分的背景色（ToolBar,Tabbar等）
    toggleableActiveColor:
        Colors.teal, //用于突出显示切换Widget（如Switch，Radio和Checkbox）的活动状态的颜色
  );
  //日间模式基佬紫
  static ThemeData lightModePurple = ThemeData(
//    accentColor: Colors.black,  //前景色，文本，按钮等
    accentColorBrightness: Brightness
        .dark, //accentColor的亮度,用于确定放置在突出颜色顶部的文本和图标的颜色（例如FloatingButton上的图标）
    backgroundColor: Colors.white, //与primaryColor对比的颜色(例如 用作进度条的剩余部分)
    bottomAppBarColor: Colors.white, //BottomAppBar的默认颜色
    brightness:
        Brightness.light, //应用程序整体主题的亮度。 由按钮等Widget使用，以确定在不使用主色或强调色时要选择的颜色
    buttonColor: Colors.purple, //Material中RaisedButtons使用的默认填充色
    primaryColor: Colors.purple, //App主要部分的背景色（ToolBar,Tabbar等）
    toggleableActiveColor:
        Colors.purple, //用于突出显示切换Widget（如Switch，Radio和Checkbox）的活动状态的颜色
  );
  //日间模式姨妈红
  static ThemeData lightModeRed = ThemeData(
//    accentColor: Colors.black,  //前景色，文本，按钮等
    accentColorBrightness: Brightness
        .dark, //accentColor的亮度,用于确定放置在突出颜色顶部的文本和图标的颜色（例如FloatingButton上的图标）
    backgroundColor: Colors.white, //与primaryColor对比的颜色(例如 用作进度条的剩余部分)
    bottomAppBarColor: Colors.white, //BottomAppBar的默认颜色
    brightness:
        Brightness.light, //应用程序整体主题的亮度。 由按钮等Widget使用，以确定在不使用主色或强调色时要选择的颜色
    buttonColor: Colors.red, //Material中RaisedButtons使用的默认填充色
    primaryColor: Colors.red, //App主要部分的背景色（ToolBar,Tabbar等）
    toggleableActiveColor:
        Colors.red, //用于突出显示切换Widget（如Switch，Radio和Checkbox）的活动状态的颜色
  );
  //日间模式姨妈红
  static ThemeData lightModePink = ThemeData(
//    accentColor: Colors.black,  //前景色，文本，按钮等
    accentColorBrightness: Brightness
        .dark, //accentColor的亮度,用于确定放置在突出颜色顶部的文本和图标的颜色（例如FloatingButton上的图标）
    backgroundColor: Colors.white, //与primaryColor对比的颜色(例如 用作进度条的剩余部分)
    bottomAppBarColor: Colors.white, //BottomAppBar的默认颜色
    brightness:
        Brightness.light, //应用程序整体主题的亮度。 由按钮等Widget使用，以确定在不使用主色或强调色时要选择的颜色
    buttonColor: Colors.pinkAccent, //Material中RaisedButtons使用的默认填充色
    primaryColor: Colors.pinkAccent, //App主要部分的背景色（ToolBar,Tabbar等）
    toggleableActiveColor:
        Colors.pinkAccent, //用于突出显示切换Widget（如Switch，Radio和Checkbox）的活动状态的颜色
  );
  //日间模式谷歌蓝
  static ThemeData lightModeBlue = ThemeData(
//    accentColor: Colors.black,  //前景色，文本，按钮等
    accentColorBrightness: Brightness
        .dark, //accentColor的亮度,用于确定放置在突出颜色顶部的文本和图标的颜色（例如FloatingButton上的图标）
    backgroundColor: Colors.white, //与primaryColor对比的颜色(例如 用作进度条的剩余部分)
    bottomAppBarColor: Colors.white, //BottomAppBar的默认颜色
    brightness:
        Brightness.light, //应用程序整体主题的亮度。 由按钮等Widget使用，以确定在不使用主色或强调色时要选择的颜色
    buttonColor: Colors.blue, //Material中RaisedButtons使用的默认填充色
    primaryColor: Colors.blue, //App主要部分的背景色（ToolBar,Tabbar等）
    toggleableActiveColor:
        Colors.blue, //用于突出显示切换Widget（如Switch，Radio和Checkbox）的活动状态的颜色
  );
  //日间模式羽光白
  static ThemeData lightModeWhite = ThemeData(
//    accentColor: Colors.black,  //前景色，文本，按钮等
    accentColorBrightness: Brightness
        .dark, //accentColor的亮度,用于确定放置在突出颜色顶部的文本和图标的颜色（例如FloatingButton上的图标）
    backgroundColor: Colors.white, //与primaryColor对比的颜色(例如 用作进度条的剩余部分)
    bottomAppBarColor: Colors.white, //BottomAppBar的默认颜色
    brightness:
        Brightness.light, //应用程序整体主题的亮度。 由按钮等Widget使用，以确定在不使用主色或强调色时要选择的颜色
    buttonColor: Colors.white, //Material中RaisedButtons使用的默认填充色
    primaryColor: Colors.white, //App主要部分的背景色（ToolBar,Tabbar等）
    toggleableActiveColor:
        Colors.white, //用于突出显示切换Widget（如Switch，Radio和Checkbox）的活动状态的颜色
  );
}
