import 'package:IVAT/public_func/PublicFunc.dart';
import 'package:flutter/material.dart';
import '../../global_config.dart' show GlobalConfig;

class Index extends StatefulWidget {
  @override
  IndexState createState() => IndexState();
}

class IndexState extends State<Index> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      margin: EdgeInsets.all(20),
      child: ListView(
        children: <Widget>[
          PublicFunc.commonCard(Container(child: Text('第一页'))),
        ],
      ),
    ));
  }
}
