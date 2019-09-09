import 'package:flutter/material.dart';
import '../settings/settings_config.dart';

class CardColumn extends StatelessWidget {
  CardColumn({@required this.children, this.height, this.margin});
  final List<Widget> children;
  final double height;
  final EdgeInsets margin;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: height == null ? null : height,
        margin: margin == null ? EdgeInsets.fromLTRB(20, 0, 20, 0) : margin,
        child: Card(
            margin: SettingConfig.cardMargin,
            elevation: SettingConfig.customElevation, //设置阴影
            shape: SettingConfig.cardShape,
            clipBehavior: Clip.hardEdge,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: children)));
  }
}
