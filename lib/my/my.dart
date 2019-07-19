import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../global_config.dart' show GlobalConfig;

class My extends StatefulWidget {
  @override
  MyState createState() => MyState();
}

class MyState extends State<My> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: GlobalConfig.themeData,
      home: new Scaffold(
        appBar: AppBar(
          title: Text('我的'),
        ),
        body: new Center(child: new Text("我的")),
      ),
    );
  }
}
