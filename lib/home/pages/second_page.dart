import 'package:flutter/material.dart';
import '../../global_config.dart' show GlobalConfig;

class Second extends StatefulWidget {
  @override
  SecondState createState() => SecondState();
}

class SecondState extends State<Second> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('第二页'),
    );
  }
}
