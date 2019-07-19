/**
 * register page
 */
import 'package:flutter/material.dart';
import 'package:data_plugin/bmob/table/bmob_user.dart';
import 'package:data_plugin/bmob/response/bmob_error.dart';
import 'package:data_plugin/bmob/response/bmob_registered.dart';
import 'package:data_plugin/utils/dialog_util.dart';
import '../../global_config.dart';
import 'package:toast/toast.dart';
import '../../public_func/PublicFunc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/userData.dart';
import '../settings_config.dart';
import '../../data/user.dart';

Icon schoolIcon = Icon(Icons.flash_on);
bool infoOK = false;

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  String _username, _password, _email, _phone, _school = "电气学院";
  bool _isObscure = true;
  Color _eyeColor;
  List _loginMethod = [
    {
      "title": "facebook",
      "icon": Icons.feedback,
    },
    {
      "title": "google",
      "icon": Icons.account_box,
    },
    {
      "title": "twitter",
      "icon": Icons.account_circle,
    },
  ];
  Widget mainScreen(BuildContext context) {
    return new PublicFunc().showMask(
        context,
        ListView(
          padding: EdgeInsets.symmetric(horizontal: 22.0),
          children: <Widget>[
            SizedBox(
              height: kToolbarHeight,
            ),
            //注册标题
            buildTitle(),
            buildTitleLine(),
            SizedBox(height: 70.0),
            //用户名
            buildUserTextField(),
            SizedBox(height: 30.0),
            //电子邮件
            buildEmailTextField(),
            SizedBox(height: 30.0),
            //手机号
            buildPhoneTextField(),
            SizedBox(height: 20.0),
            //密码
            buildPasswordTextField(context),
            //选择学院
            buildOtherInfo(context),
            SizedBox(height: 10.0),
            //忘记密码
            // buildForgetPasswordText(context),
            //注册按钮
            buildRegisterButton(context),
            SizedBox(height: 10.0),
            // buildOtherRegisterText(),
            // buildOtherMethod(context),
            buildRegisterText(context),
          ],
        ),
        '注册中');
  }

  @override
  void initState() {
    super.initState();
    PublicFunc.loading = false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: GlobalConfig.themeData,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            leading: IconButton(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              color: Colors.white,
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
//                var args=ModalRoute.of(context).settings.arguments;
//                Toast.show(args, context,
//                    duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
                //返回上一页
                PublicFunc.back(context, {});
              },
            ),
          ),
          body: Form(key: _formKey, child: mainScreen(context))),
    );
  }

  ListTile schoolItem(BuildContext context, String schoolInfo, Icon icon) {
    return ListTile(
      title: Text(schoolInfo),
      trailing: icon,
      onTap: () {
        setState(() {
          _school = schoolInfo;
          schoolIcon = icon;
        });
        Toast.show(schoolInfo, context);
      },
    );
  }

  Container buildOtherInfo(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              width: (MediaQuery.of(context).size.width - 60) / 3,
              child: FlatButton(
                  shape: SettingConfig.cardShape,
                  onPressed: () {
                    showDialog<Null>(
                      context: context,
                      builder: (BuildContext context) {
                        return SimpleDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            title: Text('选择你的学院'),
                            children: <Widget>[
                              schoolItem(
                                  context, "计算机学院", Icon(Icons.computer)),
                              schoolItem(context, "电气学院", Icon(Icons.flash_on)),
                              schoolItem(context, "管理学院", Icon(Icons.people)),
                            ]);
                      },
                    );
                  },
                  child: Container(
                      child: Column(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.all(5),
                        child: schoolIcon,
                      ),
                      Container(
                        child: Text(_school),
                      )
                    ],
                  ))),
            ),
          ]),
    );
  }

  Align buildRegisterText(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.only(top: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('已有账号？'),
            GestureDetector(
              child: Text(
                '点击登录',
                style: TextStyle(color: Colors.blue),
              ),
              onTap: () {
                //返回登录
                // var args = ModalRoute.of(context).settings.arguments;
                // print(args);
                PublicFunc.back(context, '我是传给父页面的参数');
              },
            ),
          ],
        ),
      ),
    );
  }

  ButtonBar buildOtherMethod(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: _loginMethod
          .map((item) => Builder(
                builder: (context) {
                  return IconButton(
                      icon: Icon(item['icon'],
                          color: Theme.of(context).iconTheme.color),
                      onPressed: () {
                        //TODO : 第三方登录方法
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text("${item['title']}登录"),
                          action: SnackBarAction(
                            label: "取消",
                            onPressed: () {},
                          ),
                        ));
                      });
                },
              ))
          .toList(),
    );
  }

  Align buildOtherRegisterText() {
    return Align(
        alignment: Alignment.center,
        child: Text(
          '其他账号登录',
          style: TextStyle(color: Colors.grey, fontSize: 14.0),
        ));
  }

  Align buildRegisterButton(BuildContext context) {
    return Align(
      child: SizedBox(
        height: 45.0,
        width: 270.0,
        child: RaisedButton(
          child: Text(
            '注册',
            style: Theme.of(context).primaryTextTheme.headline,
          ),
          color: GlobalConfig.themeData.primaryColor,
          onPressed: () {
//            if (_formKey.currentState.validate()) {
            ///只有输入的内容符合要求通过才会到达此处
            _formKey.currentState.save();
            //TODO 执行登录方法
            print('username:$_username , password:$_password');
            _register();
//            }
          },
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(50.0))),
        ),
      ),
    );
  }

  Padding buildForgetPasswordText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: FlatButton(
          child: Text(
            '忘记密码？',
            style: TextStyle(fontSize: 14.0, color: Colors.grey),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  TextFormField buildPasswordTextField(BuildContext context) {
    return TextFormField(
      onSaved: (String value) => _password = value,
      obscureText: _isObscure,
      validator: (String value) {
        if (value.isEmpty) {
          return '请输入密码';
        }
      },
      decoration: InputDecoration(
          labelText: '密码',
          suffixIcon: IconButton(
              icon: Icon(
                Icons.remove_red_eye,
                color: _eyeColor,
              ),
              onPressed: () {
                setState(() {
                  _isObscure = !_isObscure;
                  _eyeColor = _isObscure
                      ? Colors.grey
                      : Theme.of(context).iconTheme.color;
                });
              })),
    );
  }

  TextFormField buildUserTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: '用户名',
      ),
      onSaved: (String value) => _username = value,
    );
  }

  TextFormField buildEmailTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: '电子邮件',
      ),
      onSaved: (String value) => _email = value,
    );
  }

  TextFormField buildPhoneTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: '手机号',
      ),
      onSaved: (String value) => _phone = value,
    );
  }

  Padding buildTitleLine() {
    return Padding(
      padding: EdgeInsets.only(left: 12.0, top: 4.0),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          color: Colors.black,
          width: 40.0,
          height: 2.0,
        ),
      ),
    );
  }

  Padding buildTitle() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        '注册',
        style: TextStyle(fontSize: 42.0),
      ),
    );
  }

  _infoConfirm() {
    showDialog<Null>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: GlobalConfig.dark
              ? ThemeData.dark().backgroundColor
              : Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          title: Text('请确认你的注册信息',
              style: TextStyle(
                  color: GlobalConfig.dark ? Colors.white : Colors.black)),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('用户名:$_username'),
                Text('电子邮箱:$_email'),
                Text('手机号:$_phone'),
                Text('学院:$_school')
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('确定',
                  style: TextStyle(
                      color: GlobalConfig.dark
                          ? Colors.blue
                          : GlobalConfig.themeData.primaryColor)),
              onPressed: () {
                infoOK = true;
                PublicFunc.back(context);
                Toast.show('请点击按钮继续注册', context,
                    duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
              },
            ),
            FlatButton(
              child: Text('取消',
                  style: TextStyle(
                      color: GlobalConfig.dark
                          ? Colors.blue
                          : GlobalConfig.themeData.primaryColor)),
              onPressed: () {
                PublicFunc.back(context);
              },
            ),
          ],
        );
      },
    );
  }

  ///用户名密码注册
  _register() {
    User usrInfo = User();
    usrInfo.username = _username;
    usrInfo.password = _password;
    usrInfo.email = _email;
    usrInfo.mobilePhoneNumber = _phone;
    usrInfo.school = _school;
    usrInfo.job = '小菜鸟';
    usrInfo.confirm = false;

    //含有大或小写和数字,且位数在6～13
    RegExp rules = RegExp(r"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,13}$");
    //是电子邮件格式
    RegExp isEmail = RegExp(r"^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$");
    //是手机号码格式
    RegExp isPhone = RegExp(
        r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$');

    if (_username == '') {
      Toast.show('请输入用户名或邮箱', context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
    } else if (!rules.hasMatch(_username)) {
      Toast.show('请输入仅含字母和数字的6~13位用户名', context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
    } else {
      if (!isEmail.hasMatch(_email)) {
        Toast.show('请输入正确的电子邮件', context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
      } else {
        if (!isPhone.hasMatch(_phone)) {
          Toast.show('请输入正确的手机号', context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
        } else {
          if (_password == '') {
            Toast.show('请输入密码', context,
                duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
          } else if (!rules.hasMatch(_password)) {
            Toast.show('请输入仅含字母和数字的6~13位密码', context,
                duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
          } else {
            // Toast.show(rules.hasMatch(_password).toString(), context,
            //     duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
            //发起注册请求
            if (!infoOK) {
              _infoConfirm();
            } else {
              PublicFunc.loading = true;
              setState(() {});
              usrInfo.register().then((BmobRegistered data) async {
                PublicFunc.loading = false;
                Toast.show("注册成功！", context,
                    duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setInt('confirm_login', 1);
                prefs.setString('user_name', _username);
                print(data.objectId);
                prefs.setString('user_id', data.objectId);
                prefs.setBool('confirm', false);

                UsrData.usrName = _username;
                UsrData.usrJob = '小菜鸟';
                UsrData.usrId = data.objectId;
                PublicFunc.back(context, 'confirm_login');
                // showSuccess(context, data.objectId);
              }).catchError((e) {
                PublicFunc.loading = false;
                setState(() {});
                if (BmobError.convert(e).error.contains('username')) {
                  Toast.show("注册失败！用户名已存在", context,
                      duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
                } else if (BmobError.convert(e).error.contains('email')) {
                  Toast.show("注册失败！邮箱已被注册", context,
                      duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
                } else if (BmobError.convert(e)
                    .error
                    .contains('mobilePhoneNumber')) {
                  Toast.show("注册失败!手机号已被注册", context,
                      duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
                }
                // showError(context, BmobError.convert(e).error);
              });
              infoOK = false;
            }
          }
        }
      }
    }
  }
}
