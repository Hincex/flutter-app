import 'dart:math';
import 'dart:ui' as prefix0;

import 'package:IVAT/data/community.dart';
import 'package:IVAT/data/userData.dart';
import 'package:IVAT/nav/nav.dart';
import 'package:IVAT/public_func/PublicFunc.dart';
import 'package:IVAT/settings/settings_config.dart';
import 'package:data_plugin/bmob/bmob_query.dart';
import 'package:data_plugin/bmob/response/bmob_error.dart';
import 'package:data_plugin/utils/dialog_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import '../global_config.dart' show GlobalConfig;
import 'package:flutter/animation.dart';

bool isGrid = true;
List _cardGradient = [
  [Color(0XFFa61b29), Color(0XF0c04851)],
  [Color(0XFFFFC800), Color(0XF0FFA500)],
  [Color(0XF04169E1), Color(0XF01E90FF)],
  [Color(0XFF4285F4), Color(0X804169E1)],
  [Color(0XFF4285F4), Color(0X804169E1)],
  [Color(0XFF4285F4), Color(0X804169E1)],
  [Color(0XFF4285F4), Color(0X804169E1)],
  [Color(0XFF4285F4), Color(0X804169E1)],
  [Color(0XFF4285F4), Color(0X804169E1)],
  [Color(0XFF4285F4), Color(0X804169E1)],
  [Color(0XFF4285F4), Color(0X804169E1)],
  [Color(0XFF4285F4), Color(0X804169E1)],
  [Color(0XFF4285F4), Color(0X804169E1)],
  [Color(0XFF4285F4), Color(0X804169E1)],
  [Color(0XFF4285F4), Color(0X804169E1)],
  [Color(0XFF4285F4), Color(0X804169E1)],
  [Color(0XFF4285F4), Color(0X804169E1)],
  [Color(0XFF4285F4), Color(0X804169E1)],
  [Color(0XFF4285F4), Color(0X804169E1)],
  [Color(0XFF4285F4), Color(0X804169E1)],
];

class Club extends StatefulWidget {
  @override
  ClubState createState() => ClubState();
}

class ClubState extends State<Club> with TickerProviderStateMixin {
  bool show = false;
  int _index;
  int _tempindex;
  //横向的卡片信息
  Container info(
      String img, String title, String description, String data, int index) {
    return Container(
      child: PublicFunc.commonCard(Container(
        decoration: BoxDecoration(
            color: Color(0xff4285f4),
            gradient: LinearGradient(colors: _cardGradient[index])
            // image: DecorationImage(fit: BoxFit.fill, image: NetworkImage(img))),
            ),
        child: FlatButton(
          padding: EdgeInsets.all(0),
          child: Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              //图片
              Positioned(
                right: -100,
                bottom: 0,
                top: 0,
                child: Image(
                  image: NetworkImage(img),
                  width: 200,
                  height: 200,
                ),
              ),
              //描述
              Positioned(
                  left: 20,
                  top: 60,
                  child: Text(
                    description,
                    style: TextStyle(fontSize: 15, color: Colors.white70),
                  )),
              //标题
              Positioned(
                  left: 20,
                  top: 20,
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  )),
            ],
          ),
          onPressed: () {
            setState(() {
              _tempindex = _index;
              _index = index;
              //如果再次点击相同的，则取消显示
              if (_tempindex == _index) {
                show = !show;
              } else {
                show = true;
              }
            });
            PublicFunc.navTo('/club_page', context, [title, data], null);
            // Toast.show('进入了$title', context);
          },
        ),
      )),
    );
  }
  //纵向的卡片信息

  InkWell infolist(
      String img, String title, String description, String data, int index) {
    return InkWell(
      child: ListTile(
        title: Text(title),
        subtitle: Text(description),
        trailing: Icon(Icons.chevron_right),
      ),
      onTap: () {
        setState(() {
          _tempindex = _index;
          _index = index;
          //如果再次点击相同的，则取消显示
          if (_tempindex == _index) {
            show = !show;
          } else {
            show = true;
          }
        });
        PublicFunc.navTo('/club_page', context, [title, data], null);
        // Toast.show('进入了$title', context);
      },
    );
  }

  //卡片控件
  Widget list() {
    if (UsrData.isGrid) {
      return Container(
          child: GridView.builder(
        shrinkWrap: true,
        primary: false,
        reverse: false,
        scrollDirection: Axis.vertical,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1, //每行三列
            crossAxisSpacing: 10.0, // 横向间距
            childAspectRatio: 2),
        itemBuilder: (BuildContext context, int index) {
          return _messages[index];
        },
        itemCount: _messages.length,
      ));
    } else {
      return Container(
          child: ListView.builder(
        shrinkWrap: true,
        primary: false,
        reverse: false,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          return _messageslist[index];
        },
        itemCount: _messageslist.length,
      ));
    }
  }

  Widget mainScreen(BuildContext context) {
    return new PublicFunc().show(
        context,
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            //列表
            list(),
          ],
        ),
        '加载中');
  }

  final List<Widget> _messages = [];
  final List<Widget> _messageslist = [];

  ///等于条件查询
  void _queryWhereEqual(BuildContext context,
      [AnimationController controller]) {
    BmobQuery<Community> query = BmobQuery();
    query.setOrder("community_name");
    // show = false;
    query.queryObjects().then((data) {
      PublicFunc.loading = false;
      setState(() {});
//      showSuccess(context, data.toString());
      List<Community> messages =
          data.map((i) => Community.fromJson(i)).toList();
      for (int i = 0; i < messages.length; i++) {
        //横向卡片
        _messages.add(info(messages[i].img, messages[i].community_name,
            messages[i].description, messages[i].data_name, i));
        //纵向卡片
        _messageslist.add(infolist(messages[i].img, messages[i].community_name,
            messages[i].description, messages[i].data_name, i));
        setState(() {});
        // print(messages[i].community_name);
      }
      if (controller != null) {
        controller.dispose();
      }
    }).catchError((e) {
      setState(() {});
      showError(context, BmobError.convert(e).error);
    });
  }

  void initState() {
    super.initState();
    PublicFunc.loading = true;
    _queryWhereEqual(context);
  }

  @override
  Widget build(BuildContext context) {
    AnimationController controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: GlobalConfig.themeData,
        home: Scaffold(
          appBar: AppBar(
              elevation: 0,
              title: Text('资料库'),
              centerTitle: true,
              leading: RotationTransition(
                turns: controller,
                child: IconButton(
                  icon: Icon(Icons.refresh),
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onPressed: () {
                    _messages.clear();
                    _messageslist.clear();
                    controller.forward();
                    // Toast.show('加载中', context,
                    //     duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
                    _queryWhereEqual(context, controller);
                  },
                ),
              ),
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
