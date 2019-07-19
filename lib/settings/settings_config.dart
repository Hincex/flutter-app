import 'package:flutter/material.dart';

class SettingConfig {
  //卡片边距
  static EdgeInsetsGeometry cardMargin =
      EdgeInsets.fromLTRB(0, 0, 0, 10);
  //卡片阴影
  static double customElevation = 3.0;
  //卡片形状
  static const ShapeBorder cardShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(15.0)));
  //卡片图标
  static Color cardIconColor;
}
