import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  ListItem({this.title, this.subtitle, this.leading, this.trailing, this.onTap});
  final Widget title, subtitle;
  final Icon leading, trailing;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: ListTile(
          title: title,
          subtitle: subtitle,
          leading: leading,
          trailing: trailing == null ? Icon(Icons.chevron_right) : trailing
        ),
        onTap: onTap);
  }
}
