import 'package:IVAT/data/userData.dart';
import 'package:IVAT/public_func/PublicFunc.dart';
import 'package:IVAT/settings/settings_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import '../global_config.dart' show GlobalConfig;

bool isGrid = true;

class Club extends StatefulWidget {
  @override
  ClubState createState() => ClubState();
}

class ClubState extends State<Club> {
  Card info(Color color, Widget img, String title) {
    return PublicFunc.commonCard(FlatButton(
      shape: SettingConfig.cardShape,
      color: color,
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            img,
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Text(
                title,
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
      // Stack(
      //   overflow: Overflow.clip,
      //   fit: StackFit.expand,
      //   children: <Widget>[
      //     Image.network(
      //       'http://d.lanrentuku.com/down/png/1904/fantasy_and_role_play_game/potion_2913113.png',
      //       width: 120,
      //       alignment: Alignment.bottomRight,
      //     ),
      //     Container(
      //       alignment: Alignment.bottomCenter,
      //       child: Text(
      //         title,
      //         style: TextStyle(color: Colors.white),
      //       ),
      //     )
      //   ],
      // ),
      onPressed: () {
        Toast.show('进入了$title', context);
      },
    ));
  }

  Widget mainScreen(BuildContext context) {
    if (UsrData.isGrid) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          //列表
          Container(
            child: GridView.count(
              shrinkWrap: true,
              primary: false,
              scrollDirection: Axis.vertical,
              crossAxisCount: 2, // 横向item个数
              crossAxisSpacing: 10.0, // 横向间距
              children: <Widget>[
                info(
                    Color(0xff4169e1),
                    Image.network(
                      'http://d.lanrentuku.com/down/png/1904/fantasy_and_role_play_game/potion_2913113.png',
                      width: 100,
                    ),
                    '实验室专区'),
                info(
                    Colors.teal,
                    Image.network(
                      'http://d.lanrentuku.com/down/png/1904/fantasy_and_role_play_game/fairy_2913099.png',
                      width: 100,
                    ),
                    '电气协会专区'),
                info(
                    Color(0xff1e90ff),
                    Image.network(
                      'http://d.lanrentuku.com/down/png/1904/fantasy_and_role_play_game/knight_2913116.png',
                      width: 100,
                    ),
                    '学生会专区'),
                info(
                    Color(0xff4285f4),
                    Image.network(
                      'http://d.lanrentuku.com/down/png/1904/fantasy_and_role_play_game/potion_2913113.png',
                      width: 100,
                    ),
                    '校团委专区'),
                info(
                    Color(0xff4169e1),
                    Image.network(
                      'http://d.lanrentuku.com/down/png/1904/fantasy_and_role_play_game/bow_arrow_2913123.png',
                      width: 100,
                    ),
                    '实验室专区'),
                info(
                    Colors.teal,
                    Image.network(
                      'http://d.lanrentuku.com/down/png/1904/fantasy_and_role_play_game/viking_2913107.png',
                      width: 100,
                    ),
                    '电气协会专区'),
                info(
                    Color(0xff1e90ff),
                    Image.network(
                      'http://d.lanrentuku.com/down/png/1904/international_food/green_curry.png',
                      width: 100,
                    ),
                    '学生会专区'),
                info(
                    Color(0xff4285f4),
                    Image.network(
                      'http://d.lanrentuku.com/down/png/1904/fantasy_and_role_play_game/potion_2913113.png',
                      width: 100,
                    ),
                    '校团委专区'),
              ],
            ),
          )
        ],
      );
    } else {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            //列表
            Container()
          ]);
    }
  }

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: GlobalConfig.themeData,
        home: new Scaffold(
          appBar: AppBar(
              elevation: 0,
              title: Text('社区'),
              centerTitle: true,
              actions: <Widget>[
                IconButton(
                  icon: UsrData.isGrid ? Icon(Icons.apps) : Icon(Icons.menu),
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onPressed: () async {
                    setState(() {
                      UsrData.isGrid = !UsrData.isGrid;
                    });
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setBool('isGrid', UsrData.isGrid);
                  },
                )
              ]),
          body: ListView(
            padding: EdgeInsets.all(20),
            children: <Widget>[
              mainScreen(context),
            ],
          ),
        ));
  }
}
