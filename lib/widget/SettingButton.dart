import 'package:flutter/material.dart';

//依次是显示文字，图标，按下执行函数
class SettingButton extends StatelessWidget {
  SettingButton({this.onTap, this.icon, this.title});
  final Function onTap;
  final Widget icon, title;
  @override
  Widget build(BuildContext context) {
    return Container(
        key: ValueKey(icon),
        width: (MediaQuery.of(context).size.width - 80) / 3,
        child: InkWell(
//          highlightColor: Colors.transparent,
//          splashColor: Colors.transparent,
          onTap: onTap == null ? null : onTap,
          child: Container(
              child: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(10),
                child: icon,
              ),
              Container(
                child: title,
              )
            ],
          )),
        ));
  }
}
