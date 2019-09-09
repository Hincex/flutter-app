import 'package:IVAT/data/user.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import '../global_config.dart' show GlobalConfig; //全局设置
import 'package:provider/provider.dart';
import '../store/model/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../public_func/PublicFunc.dart';
import '../data/userData.dart';
import '../data/confirm.dart';
import 'package:data_plugin/bmob/bmob_query.dart';
import 'package:data_plugin/utils/dialog_util.dart';
import 'package:data_plugin/bmob/response/bmob_error.dart';
import 'package:data_plugin/bmob/response/bmob_updated.dart';
import '../settings/settings_config.dart';
// 通用组件
import '../widget/CardColumn.dart';
import '../widget/ListItem.dart';
import '../widget/SettingButton.dart';
import '../widget/Info.dart';
import '../widget/UserCard.dart';
// 通用工具
import '../util/theme_util.dart';

final TextEditingController _controller = TextEditingController();

class Settings extends StatefulWidget {
  @override
  SettingsState createState() => SettingsState();
}

//界面构造
class SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '电气协会',
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeChange>(context).themeUsr,
      home: Scaffold(
          appBar: AppBar(
            title: Text("设置"),
            centerTitle: true,
            elevation: 0.0,
          ),
          body: ListView(children: [
            //个人卡片
            Container(
              margin: EdgeInsets.only(bottom: 50),
              child: Stack(
                overflow: Overflow.visible,
                children: <Widget>[
                  UserCard(fatherContext: context),
                  Positioned(
                    left: 0.0,
                    right: 0.0,
                    top: 80.0,
                    child: InfoCard(fatherContext: context),
                  )
                ],
              ),
            ),
            //设置卡片
            SettingCard(fatherContext: context),
            //下方设置卡片
            BottomCard(fatherContext: context)
          ])),
    );
  }
}

class InfoCard extends StatelessWidget {
  InfoCard({@required this.fatherContext});
  final BuildContext fatherContext;
  @override
  Widget build(BuildContext context) {
    return CardColumn(
      height: 100,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Info(
                height: 60,
                width: (MediaQuery.of(context).size.width - 80) / 3,
                info: Text('1',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )),
                title: Text('消息'),
                onTap: () => PublicFunc.navTo('/message', fatherContext)),
            Info(
                height: 60,
                width: (MediaQuery.of(context).size.width - 80) / 3,
                info: Text('3',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )),
                title: Text('任务'),
                onTap: () => PublicFunc.navTo('/mission', fatherContext)),
            Info(
                height: 60,
                width: (MediaQuery.of(context).size.width - 80) / 3,
                info: Text('10',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )),
                title: Text('奖励'),
                onTap: () => PublicFunc.navTo('/announce', fatherContext)),
            // Row()
          ],
        ),
      ],
    );
  }
}

class SettingCard extends StatelessWidget {
  SettingCard({@required this.fatherContext});
  final BuildContext fatherContext;
  @override
  Widget build(BuildContext context) {
    return CardColumn(
      children: <Widget>[
        //第一排设置
        Container(
          margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // 通知公告
              SettingButton(
                  icon: CircleAvatar(
                    radius: 20.0,
                    child: Icon(Icons.book,
                        color: GlobalConfig.dark ? Colors.green : Colors.white),
                    backgroundColor:
                        GlobalConfig.dark ? Colors.white : Colors.green,
                  ),
                  title: Text('通知公告'),
                  onTap: () => PublicFunc.navTo('/announce', fatherContext)),
              //开发团队
              SettingButton(
                  icon: CircleAvatar(
                    radius: 20.0,
                    child: Icon(Icons.person,
                        color: GlobalConfig.dark ? Colors.black : Colors.white),
                    backgroundColor:
                        GlobalConfig.dark ? Colors.white : Colors.black,
                  ),
                  title: Text('开发团队'),
                  onTap: () => PublicFunc.navTo('/team', fatherContext)),
              //意见反馈
              SettingButton(
                  icon: CircleAvatar(
                    radius: 20.0,
                    child: Icon(Icons.info,
                        color:
                            GlobalConfig.dark ? Colors.purple : Colors.white),
                    backgroundColor:
                        GlobalConfig.dark ? Colors.white : Colors.purple,
                  ),
                  title: Text('意见反馈'),
                  onTap: () => PublicFunc.navTo('/advice', fatherContext)),
            ],
          ),
        ),
        //第二排设置

        Container(
          margin: EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //主题切换
              SettingButton(
                  icon: CircleAvatar(
                    radius: 20.0,
                    child: Icon(Icons.color_lens,
                        color: GlobalConfig.dark ? Colors.pink : Colors.white),
                    backgroundColor:
                        GlobalConfig.dark ? Colors.white : Colors.pink,
                  ),
                  title: Text('主题风格'),
                  onTap: () => ThemeUtil.selectTheme(fatherContext)),
              //夜间模式切换
              SettingButton(
                  icon: CircleAvatar(
                    radius: 20.0,
                    child: Icon(
                        GlobalConfig.dark
                            ? Icons.brightness_2
                            : Icons.brightness_5,
                        color:
                            GlobalConfig.dark ? Colors.orange : Colors.white),
                    backgroundColor:
                        GlobalConfig.dark ? Colors.white : Colors.orange,
                  ),
                  title: Text(GlobalConfig.dark ? '夜间模式' : '日间模式'),
                  onTap: () => ThemeUtil.themeMode(fatherContext)),
              //检查更新
              SettingButton(
                  icon: CircleAvatar(
                    radius: 20.0,
                    child: Icon(Icons.update,
                        color: GlobalConfig.dark ? Colors.blue : Colors.white),
                    backgroundColor:
                        GlobalConfig.dark ? Colors.white : Colors.blue,
                  ),
                  title: Text('检查更新'),
                  onTap: () => PublicFunc.navTo('/update', fatherContext)),
            ],
          ),
        )
      ],
    );
  }
}

class BottomCard extends StatelessWidget {
  BottomCard({@required this.fatherContext});
  final BuildContext fatherContext;
  @override
  Widget build(BuildContext context) {
    return CardColumn(
      children: <Widget>[
        ListItem(
          title: Text('身份认证'),
          subtitle: Text('进行身份认证'),
          //之前显示icon
          leading: Icon(Icons.adjust, color: SettingConfig.cardIconColor),
          onTap: () async {
            // 未登录则跳转登录
            if (await PublicFunc.userLogin() != 1) {
              Toast.show("请先登录账号!", fatherContext,
                  duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
              PublicFunc.navTo('/login', fatherContext);
            } else {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              bool confirm = prefs.getBool('confirm');
              if (confirm != null && confirm == false) {
                _buildConfirmCode(fatherContext);
              } else {
                // showToast('你已认证过',position:ToastPosition.bottom);
                Toast.show('你已认证过!', fatherContext,
                    duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
              }
              // PublicFunc.navTo('/identity', context);
            }
          },
        ),
        ListItem(
          title: Text('小工具包'),
          subtitle: Text('电气常用工具'),
          //之前显示icon
          leading:
              Icon(Icons.developer_mode, color: SettingConfig.cardIconColor),
        ),
        ListItem(
          title: Text('设置中心'),
          //之前显示icon
          leading: Icon(Icons.settings, color: SettingConfig.cardIconColor),
          onTap: () => PublicFunc.navTo('/user', fatherContext),
        )
      ],
    );
  }
}

_buildConfirmCode(BuildContext context) {
  String _confirmCode;

  ///查询数据
  void _queryWhereEqual(BuildContext context) {
    if (_confirmCode != null) {
      BmobQuery<Confirm> bmobQuery = BmobQuery();
      bmobQuery.queryObject(_confirmCode).then((data) async {
        Confirm msg = Confirm.fromJson(data);
        if (!msg.used) {
          Toast.show('认证成功!', context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
          //然后修改数据，使认证编码不可重复使用
          User usr = User();
          usr.objectId = UsrData.usrId;
          usr.confirm = true;
          //先将账号的认证状态改为true
          await usr.update().then((BmobUpdated bmobUpdated) {
            // showSuccess(context, "修改一条数据成功：${bmobUpdated.updatedAt}");
          }).catchError((e) {
            showError(context, BmobError.convert(e).error);
          });
          //再把认证编码丢弃
          Confirm confirm = Confirm();
          confirm.objectId = _confirmCode;
          confirm.used = true;
          confirm.update().then((BmobUpdated bmobUpdated) async {
            PublicFunc.back(context);
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setBool('confirm', true);
            // showSuccess(context, "修改一条数据成功：${bmobUpdated.updatedAt}");
          }).catchError((e) {
            Toast.show('认证失败!', context,
                duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
            // showError(context, BmobError.convert(e).error);
          });
          _confirmCode = '';
        }
        //已使用
        else {
          Toast.show('该编码已被使用!', context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
        }
        // showSuccess(context, data.toString());
      }).catchError((e) {
        Toast.show('该编码不存在!', context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
        // showError(context, BmobError.convert(e).error);
      });
    } else {
      showError(context, "请先新增一条数据");
    }
  }

  void _handleSubmitted(String value) {
    _controller.clear();
    _confirmCode = value;
  }

  return showDialog<Null>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: GlobalConfig.dark
              ? ThemeData.dark().backgroundColor
              : Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          title: Text('请输入你的认证编码',
              style: TextStyle(
                  color: GlobalConfig.dark ? Colors.white : Colors.black)),
          content: SingleChildScrollView(
            child: TextField(
                controller: _controller,
                onSubmitted: _handleSubmitted,
                decoration: InputDecoration(
                    hintText: '输入认证编码',
                    suffixIcon: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                              radius: 20.0,
                              backgroundColor: Colors.transparent,
                              child: IconButton(
                                icon: Icon(Icons.send),
                                color: GlobalConfig.themeData.primaryColor,
                                onPressed: () {
                                  _handleSubmitted(_controller.text);
                                  _queryWhereEqual(context);
                                  // PublicFunc.back(context);
                                },
                              )),
                        ])),
                maxLines: null,
                maxLength: 255),
          ),
        );
      });
}
