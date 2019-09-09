import 'package:flutter/material.dart';

class Info extends StatelessWidget {
  Info({this.height, this.width, this.info, this.title, this.onTap});
  final double height, width;
  final Widget info, title;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height == null ? null : height,
      width: width == null ? null : width,
      child: InkWell(
        child: Container(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(5),
              child: info,
            ),
            Container(
              child: title,
            )
          ],
        )),
        onTap: onTap,
      ),
    );
  }
}
