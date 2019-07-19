import 'package:data_plugin/bmob/response/bmob_error.dart';
import 'package:data_plugin/bmob/response/bmob_handled.dart';
import '../../data/user.dart';
import 'package:data_plugin/utils/dialog_util.dart';
import '../../global_config.dart' show GlobalConfig;
import '../../settings/settings_config.dart';
import 'package:data_plugin/bmob/table/bmob_user.dart' show BmobUser;
import 'package:IVAT/public_func/PublicFunc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/userData.dart' show UsrData;
import 'package:toast/toast.dart';
import '../../data/user.dart';
import 'package:data_plugin/bmob/bmob_query.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';
/**
 * home page
 */
import 'package:flutter/material.dart';

bool _back = false;

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  String usrName = 'XXX', school = 'XX学院', createTime = '还未注册';

  ///查询一条数据
  _querySingle(BuildContext context) {
    //后续补充历史信息
    if (UsrData.usrId != null) {
      BmobQuery<_User> bmobQuery = BmobQuery();
      bmobQuery.setInclude("author");
      bmobQuery.queryObject(UsrData.usrId).then((data) {
        PublicFunc.loading = false;
        User user = User.fromJson(data);
        setState(() {
          usrName = user.username == null ? '请登录' : user.username;
          school = user.school == null ? '没有学院' : user.school;
          createTime = user.createdAt == null ? '还未注册' : user.createdAt;
        });
        // showSuccess(context, "查询一条数据成功：$user");
      }).catchError((e) {
        PublicFunc.loading = false;
        Toast.show('数据获取失败!', context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
        // showError(context, BmobError.convert(e).error);
      });
    } else {
      showError(context, "请先新增一条数据");
    }
  }

  Align buildLoginButton(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        height: 45.0,
        width: 270.0,
        child: RaisedButton(
          child: Text(
            '退出登录',
            style: Theme.of(context).primaryTextTheme.headline,
          ),
          color: GlobalConfig.themeData.primaryColor,
          onPressed: () async {
            //退出时清空本地用户名usrData.usrName和本地登陆凭证pref.getInt("confirm_login")
            SharedPreferences pref = await SharedPreferences.getInstance();
            if (pref.getInt('confirm_login') == null) {
              Toast.show("退出啥啊你退", context,
                  duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
            } else {
              showDialog<Null>(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: GlobalConfig.dark
                        ? ThemeData.dark().backgroundColor
                        : Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    title: Text('确定退出吗',
                        style: TextStyle(
                            color: GlobalConfig.dark
                                ? Colors.white
                                : Colors.black)),
                    // content: SingleChildScrollView(
                    //   child: ListBody(
                    //     children: <Widget>[
                    //       Text('内容 1'),
                    //       Text('内容 2'),
                    //     ],
                    //   ),
                    // ),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('确定',
                            style: TextStyle(
                                color: GlobalConfig.dark
                                    ? Colors.blue
                                    : GlobalConfig.themeData.primaryColor)),
                        onPressed: () {
                          pref.remove('confirm_login');
                          pref.remove('user_name');
                          pref.remove('user_id');
                          pref.remove('confirm');

                          UsrData.usrName = '请登录';
                          UsrData.usrId = '';
                          Toast.show("退出成功", context,
                              duration: Toast.LENGTH_SHORT,
                              gravity: Toast.CENTER);
                          _back = true;
                          PublicFunc.back(context);
                        },
                      ),
                      FlatButton(
                        child: Text('取消',
                            style: TextStyle(
                                color: GlobalConfig.dark
                                    ? Colors.blue
                                    : GlobalConfig.themeData.primaryColor)),
                        onPressed: () {
                          // _querySingle(context);
                          PublicFunc.back(context);
                        },
                      ),
                    ],
                  );
                },
              ).then((val) {
                if (_back == true) {
                  //返回设置首页
                  PublicFunc.back(context);
                  _back = false;
                }
              });
            }
          },
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(50.0))),
        ),
      ),
    );
  }

  TimelineModel items(String _txt, IconData _icon) {
    return TimelineModel(
        Container(
          child: Card(
              clipBehavior: Clip.hardEdge,
              shape: SettingConfig.cardShape,
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      _txt,
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ))),
        ),
        position: TimelineItemPosition.random,
        iconBackground: GlobalConfig.themeData.primaryColor,
        icon: Icon(_icon, color: Colors.white));
  }

  Widget mainScreen(BuildContext context) {
    List<TimelineModel> lineItems = [
      TimelineModel(
          Card(
              clipBehavior: Clip.hardEdge,
              shape: SettingConfig.cardShape,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    CircleAvatar(
                        minRadius: 10,
                        maxRadius: 20,
                        child:
                            Text(usrName[0], style: TextStyle(fontSize: 25))),
                    Text(usrName)
                  ],
                ),
              )),
          position: TimelineItemPosition.random,
          iconBackground: GlobalConfig.themeData.primaryColor,
          icon: Icon(Icons.people, color: Colors.white)),
      items('是$school的小伙子', Icons.school),
      items('$createTime\n加入电气协会', Icons.history),
    ];
    return new PublicFunc().show(
        context,
        Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 40),
            child: Stack(
              children: <Widget>[
                Timeline(
                    children: lineItems,
                    lineColor: GlobalConfig.themeData.primaryColor,
                    position: TimelinePosition.Center),
                buildLoginButton(context)
              ],
            )),
        '加载中');
  }

  @override
  void initState() {
    super.initState();
    PublicFunc.loading = true;
    _querySingle(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: GlobalConfig.themeData,
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              title: Text('设置中心'),
              centerTitle: true,
              elevation: 0.0,
              leading: IconButton(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                color: Colors.white,
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  //返回上一页
                  PublicFunc.back(context);
                },
              ),
            ),
            body: mainScreen(context)));
  }
}

class _User {}
