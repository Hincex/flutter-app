import 'package:IVAT/public_func/PublicFunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../../global_config.dart';

class Mission extends StatefulWidget {
  @override
  MissionState createState() => MissionState();
}

class MissionState extends State<Mission> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: GlobalConfig.themeData,
      home: Scaffold(
          appBar: AppBar(
            title: Text('任务'),
            elevation: 0,
            leading: IconButton(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              color: Colors.white,
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                PublicFunc.back(context, {});
              },
            ),
          ),
          body: Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
              child: Column(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Swiper(
                      itemBuilder: (BuildContext context, int index) {
                        return PublicFunc.commonCard(Image.network(
                          "http://d.lanrentuku.com/down/png/1904/fantasy_and_role_play_game/viking_2913107.png",
                          fit: BoxFit.cover,
                        ));
                      },
                      itemCount: 10,
                      viewportFraction: 0.8,
                      scale: 0.9,
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: Text('已接受任务'),
                  )
                ],
              ))),
    );
  }
}
