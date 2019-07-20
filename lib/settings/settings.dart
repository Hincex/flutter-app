import 'package:IVAT/data/user.dart';
import 'package:data_plugin/bmob/bmob_file_manager.dart';
import 'package:data_plugin/bmob/type/bmob_file.dart';
import 'package:data_plugin/data_plugin.dart';
// import 'package:data_plugin/bmob/bmob_dio.dart';
// import 'package:data_plugin/bmob/table/bmob_user.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/painting.dart';
import 'package:toast/toast.dart';
import '../global_config.dart' show GlobalConfig; //全局设置
import 'settings_config.dart' show SettingConfig; //设置界面变量
import 'package:provider/provider.dart';
import '../store/model/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../public_func/PublicFunc.dart';
import '../data/userData.dart';
import 'dart:io';
import 'dart:async';
import '../data/confirm.dart';
import 'package:data_plugin/bmob/bmob_query.dart';
import 'package:data_plugin/utils/dialog_util.dart';
import 'package:data_plugin/bmob/response/bmob_error.dart';
import 'package:data_plugin/bmob/response/bmob_updated.dart';
import 'package:image_picker/image_picker.dart';

final TextEditingController _controller = TextEditingController();

class Settings extends StatefulWidget {
  @override
  SettingsState createState() => SettingsState();
}

//界面构造
class SettingsState extends State<Settings> {
  var _imgPath;
  String _url;
  BmobFile _bmobFile;

  ///上传文件，上传文件涉及到android的文件访问权限，调用此方法前需要开发者们先适配好应用在各个android版本的权限管理。
  _uploadFile(String path) {
    if (path == null) {
      DataPlugin.toast("请先选择文件");
      return;
    }
    DataPlugin.toast("上传中，请稍候……");
    File file = new File(path);
    BmobFileManager.upload(file).then((BmobFile bmobFile) {
      _bmobFile = bmobFile;
      _url = bmobFile.url;
      print("${bmobFile.cdn}\n${bmobFile.url}\n${bmobFile.filename}");
      DataPlugin.toast(
          "上传成功：${bmobFile.cdn}\n${bmobFile.url}\n${bmobFile.filename}");
    }).catchError((e) {
      showError(context, BmobError.convert(e).error);
    });
  }

/*拍照*/
  Future _takePhoto() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    print(image);
    setState(() {
      _imgPath = image;
    });
  }

  /*相册*/
  Future _openGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imgPath = image;
    });
    //开始上传头像
    if (_imgPath != null) {
      print(_imgPath.path);
      _uploadFile(_imgPath.path);
    }
  }

  //个人卡片
  Container infoCard(BuildContext context) {
    return Container(
        child: PublicFunc.commonCard(Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 40),
                child: CircleAvatar(
                    backgroundImage:
                        _imgPath == null ? null : FileImage(_imgPath),
                    minRadius: 20,
                    maxRadius: 25,
                    child: FlatButton(
                        padding: EdgeInsets.all(0),
                        child: _imgPath == null
                            ? Text(UsrData.usrName[0],
                                style: TextStyle(
                                    fontSize: 25, color: Colors.white))
                            : null,
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onPressed: () {
                          showDialog<Null>(
                            context: context,
                            barrierDismissible: true,
                            builder: (BuildContext context) {
                              return SimpleDialog(
                                  backgroundColor: GlobalConfig.dark
                                      ? ThemeData.dark().backgroundColor
                                      : Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                  title: Text(
                                    '上传你的头像',
                                    style: TextStyle(
                                        color: GlobalConfig.dark
                                            ? Colors.white
                                            : Colors.black),
                                    textAlign: TextAlign.center,
                                  ),
                                  children: <Widget>[
                                    ListTile(
                                      title: Text('拍照',
                                          style: TextStyle(
                                              color: GlobalConfig.dark
                                                  ? Colors.white
                                                  : Colors.black)),
                                      trailing: Icon(Icons.camera),
                                      onTap: () {
                                        _takePhoto();
                                      },
                                    ),
                                    ListTile(
                                      title: Text('图库',
                                          style: TextStyle(
                                              color: GlobalConfig.dark
                                                  ? Colors.white
                                                  : Colors.black)),
                                      trailing: Icon(Icons.photo),
                                      onTap: () {
                                        _openGallery();
                                      },
                                    ),
                                  ]);
                            },
                          );
                        })),
              ),
              FlatButton(
                onPressed: () {
                  PublicFunc.navTo('/user', context);
                },
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          //用户名
                          Container(
                            child: Text(
                              UsrData.usrName,
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                          //其他
                          Container(
                            child: Text(
                              UsrData.usrJob,
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 60),
                      child: Icon(Icons.chevron_right),
                    )
                  ],
                ),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(children: <Widget>[
                      info(
                        context,
                        '消息',
                        '1',
                        () {
                          PublicFunc.navTo('/message', context);
                        },
                      ),
                      info(
                        context,
                        '任务',
                        '3',
                        () {
                          PublicFunc.navTo('/announce', context);
                        },
                      ),
                      info(
                        context,
                        '奖励',
                        '10',
                        () {
                          PublicFunc.navTo('/announce', context);
                        },
                      ),
                    ]),
                    Row()
                  ],
                )
              ],
            ),
          )
        ],
      ),
    )));
  }

  Container info(
      BuildContext context, String text, String info, Function func) {
    return Container(
      width: (MediaQuery.of(context).size.width - 80) / 3,
      child: FlatButton(
          // shape: SettingConfig.cardShape,
          onPressed: () {
            func();
          },
          child: Container(
              child: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(5),
                child: Text(info,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              Container(
                child: Text(text),
              )
            ],
          ))),
    );
  }

  //依次是显示文字，图标，按下执行函数
  Container settingButton(
      BuildContext context, String text, CircleAvatar icon, Function func) {
    return Container(
      width: (MediaQuery.of(context).size.width - 80) / 3,
      child: FlatButton(
          onPressed: () {
            func();
          },
          child: Container(
              child: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(5),
                child: icon,
              ),
              Container(
                child: Text(text),
              )
            ],
          ))),
    );
  }

//设置卡片
  Container settingCard(BuildContext context) {
    return Container(
        child: PublicFunc.commonCard(
      Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            //第一排设置
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  //通知公告
                  settingButton(
                    context,
                    '通知公告',
                    CircleAvatar(
                      radius: 20.0,
                      child: Icon(Icons.book,
                          color:
                              GlobalConfig.dark ? Colors.green : Colors.white),
                      backgroundColor:
                          GlobalConfig.dark ? Colors.white : Colors.green,
                    ),
                    () {
                      PublicFunc.navTo('/announce', context);
                    },
                  ),
                  //开发团队
                  settingButton(
                    context,
                    '开发团队',
                    CircleAvatar(
                      radius: 20.0,
                      child: Icon(Icons.person,
                          color:
                              GlobalConfig.dark ? Colors.black : Colors.white),
                      backgroundColor:
                          GlobalConfig.dark ? Colors.white : Colors.black,
                    ),
                    () {
                      PublicFunc.navTo('/team', context);
                    },
                  ),
                  //意见反馈
                  settingButton(
                    context,
                    '意见反馈',
                    CircleAvatar(
                      radius: 20.0,
                      child: Icon(Icons.info,
                          color:
                              GlobalConfig.dark ? Colors.purple : Colors.white),
                      backgroundColor:
                          GlobalConfig.dark ? Colors.white : Colors.purple,
                    ),
                    () {
                      PublicFunc.navTo('/advice', context);
                    },
                  ),
                ],
              ),
            ),
            //第二排设置

            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  //主题切换
                  settingButton(
                    context,
                    '主题风格',
                    CircleAvatar(
                      radius: 20.0,
                      child: Icon(Icons.color_lens,
                          color:
                              GlobalConfig.dark ? Colors.pink : Colors.white),
                      backgroundColor:
                          GlobalConfig.dark ? Colors.white : Colors.pink,
                    ),
                    () {
                      selectTheme(context);
                    },
                  ),
                  //夜间模式切换
                  settingButton(
                    context,
                    GlobalConfig.dark ? '夜间模式' : '日间模式',
                    CircleAvatar(
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
                    () {
                      themeMode(context);
                    },
                  ),
                  //检查更新
                  settingButton(
                    context,
                    "检查更新",
                    CircleAvatar(
                      radius: 20.0,
                      child: Icon(Icons.update,
                          color:
                              GlobalConfig.dark ? Colors.blue : Colors.white),
                      backgroundColor:
                          GlobalConfig.dark ? Colors.white : Colors.blue,
                    ),
                    () {
                      PublicFunc.navTo('/update', context);
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
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
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
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

  //下方设置卡片
  Container bottomCard(BuildContext context) {
    return Container(
        child: PublicFunc.commonCard(Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('身份认证'),
            subtitle: Text('进行身份认证'),
            //之前显示icon
            leading: Icon(Icons.adjust, color: SettingConfig.cardIconColor),
            trailing: Icon(Icons.chevron_right),
            onTap: () async {
              // 未登录则跳转登录
              if (await PublicFunc.userLogin() != 1) {
                Toast.show("请先登录账号!", context,
                    duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
                PublicFunc.navTo('/login', context);
              } else {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                bool confirm = prefs.getBool('confirm');
                if (confirm != null && confirm == false) {
                  _buildConfirmCode(context);
                } else {
                  // showToast('你已认证过',position:ToastPosition.bottom);
                  Toast.show('你已认证过!', context,
                      duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
                }
                // PublicFunc.navTo('/identity', context);
              }
            },
          ),
          ListTile(
            title: Text('小工具包'),
            subtitle: Text('电气常用工具'),
            //之前显示icon
            leading:
                Icon(Icons.developer_mode, color: SettingConfig.cardIconColor),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              // getUserName();
              // PublicFunc.navTo('/user', context);
            },
          ),
          ListTile(
            title: Text('设置中心'),
            //之前显示icon
            leading: Icon(Icons.settings, color: SettingConfig.cardIconColor),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              // getUserName();
              PublicFunc.navTo('/user', context);
            },
          ),
        ],
      ),
    )));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeChange>(context).themeUsr,
      home: Scaffold(
          appBar: AppBar(
            title: Text("设置"),
            centerTitle: true,
            elevation: 0.0,
          ),
          body: ListView(padding: EdgeInsets.all(20), children: [
            //个人卡片
            infoCard(context),
            //设置卡片
            settingCard(context),
            //下方设置卡片
            bottomCard(context),
          ])),
    );
  }
}

//功能函数
//本地持久化主题设置
void saveTheme(index) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt('localTheme', index);
  // print(index);
}

//判断是否夜间模式
void setTheme(index, BuildContext context) {
  if (GlobalConfig.dark) {
    Toast.show('请先关闭夜间模式！', context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
  } else {
    GlobalConfig.tempThemeData = GlobalConfig.themes[index];
    GlobalConfig.themeData = GlobalConfig.themes[index];
    Provider.of<ThemeChange>(context).themechange(GlobalConfig.themes[index]);
    saveTheme(index);
    Timer(Duration(milliseconds: 50), () {
      // 只在倒计时结束时回调
      PublicFunc.back(context);
    });
  }
}

//选择主题
void selectTheme(BuildContext context) {
  //主题选择对话框
  showDialog<Null>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return SimpleDialog(
          backgroundColor: GlobalConfig.dark
              ? ThemeData.dark().backgroundColor
              : Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          title: Text(
            '选择你的主题',
            style: TextStyle(
                color: GlobalConfig.dark ? Colors.white : Colors.black),
            textAlign: TextAlign.center,
          ),
          children: <Widget>[
            ListTile(
              title: Text('水鸭青',
                  style: TextStyle(
                      color: GlobalConfig.dark ? Colors.white : Colors.black)),
              trailing: CircleAvatar(backgroundColor: Colors.teal),
              onTap: () {
                setTheme(1, context);
              },
            ),
            ListTile(
              title: Text('基佬紫',
                  style: TextStyle(
                      color: GlobalConfig.dark ? Colors.white : Colors.black)),
              trailing: CircleAvatar(backgroundColor: Colors.purple),
              onTap: () {
                setTheme(2, context);
              },
            ),
            ListTile(
              title: Text('姨妈红',
                  style: TextStyle(
                      color: GlobalConfig.dark ? Colors.white : Colors.black)),
              trailing: CircleAvatar(backgroundColor: Colors.red),
              onTap: () {
                setTheme(3, context);
              },
            ),
            ListTile(
              title: Text('少女粉',
                  style: TextStyle(
                      color: GlobalConfig.dark ? Colors.white : Colors.black)),
              trailing: CircleAvatar(backgroundColor: Colors.pinkAccent),
              onTap: () {
                setTheme(4, context);
              },
            ),
            ListTile(
              title: Text('谷歌蓝',
                  style: TextStyle(
                      color: GlobalConfig.dark ? Colors.white : Colors.black)),
              trailing: CircleAvatar(backgroundColor: Colors.blue),
              onTap: () {
                setTheme(5, context);
              },
            ),
            // ListTile(
            //   title: Text('羽光白',
            //       style: TextStyle(
            //           color: GlobalConfig.dark ? Colors.white : Colors.black)),
            //   trailing: CircleAvatar(backgroundColor: Colors.white),
            //   onTap: () {
            //     setTheme(6, context);
            //   },
            // ),
          ]);
    },
  );
}

//夜间/日间模式切换
void themeMode(BuildContext context) {
  GlobalConfig.dark = !GlobalConfig.dark;
  /**主题切换逻辑 */
  GlobalConfig.themeData =
      GlobalConfig.dark ? GlobalConfig.themes[0] : GlobalConfig.tempThemeData;
  Provider.of<ThemeChange>(context).themechange(GlobalConfig.themeData);
}
