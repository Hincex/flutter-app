import 'package:flutter/material.dart';
import 'package:IVAT/global_config.dart';

class LoginButton extends StatelessWidget {
  LoginButton({@required this.title, this.onPressed, this.fatherContext});
  final Text title;
  final Function onPressed;
  final BuildContext fatherContext;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        height: 45.0,
        width: 270.0,
        child: RaisedButton(
          child: title,
          color: GlobalConfig.themeData.primaryColor,
          onPressed: onPressed,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(50.0))),
        ),
      ),
    );
  }
}
