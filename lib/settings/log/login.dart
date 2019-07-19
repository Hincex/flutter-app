/**
 * login page
 */
import 'package:flutter/material.dart';
import 'package:data_plugin/bmob/table/bmob_user.dart';
import 'package:data_plugin/bmob/response/bmob_error.dart';
import 'package:data_plugin/utils/dialog_util.dart';
import '../../global_config.dart' show GlobalConfig;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import '../../public_func/PublicFunc.dart';
import '../../data/userData.dart';
import '../../data/user.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

TextEditingController controller;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  String _email, _password;
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
            //登录标题
            buildTitle(),
            buildTitleLine(),
            SizedBox(height: 70.0),
            //用户名
            buildEmailTextField(),
            SizedBox(height: 30.0),
            //密码
            buildPasswordTextField(context),
            //忘记密码
            buildForgetPasswordText(context),
            SizedBox(height: 60.0),
            //登录按钮
            buildLoginButton(context),
            SizedBox(height: 30.0),
            // buildOtherLoginText(),
            // buildOtherMethod(context),
            //点击注册
            buildRegisterText(context),
          ],
        ),
        '登录中');
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
                //返回上一页
                PublicFunc.back(context, {});
              },
            ),
          ),
          body: Form(key: _formKey, child: mainScreen(context))),
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
            Text('没有账号？'),
            GestureDetector(
              child: Text(
                '点击注册',
                style: TextStyle(color: Colors.blue),
              ),
              onTap: () {
                //TODO 跳转到注册页面
                print('去注册');
                PublicFunc.navTo('/register', context, {}, (value) {
                  //返回设置首页
                  if (value == 'confirm_login') {
                    // print('进来啦额');
                    PublicFunc.back(context);
                  }
                });
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

  Align buildOtherLoginText() {
    return Align(
        alignment: Alignment.center,
        child: Text(
          '其他账号登录',
          style: TextStyle(color: Colors.grey, fontSize: 14.0),
        ));
  }

  Align buildLoginButton(BuildContext context) {
    return Align(
      child: SizedBox(
        height: 45.0,
        width: 270.0,
        child: RaisedButton(
          child: Text(
            '登录',
            style: Theme.of(context).primaryTextTheme.headline,
          ),
          color: GlobalConfig.themeData.primaryColor,
          onPressed: () {
//            if (_formKey.currentState.validate()) {
//            ///只有输入的内容符合要求通过才会到达此处/47
            _formKey.currentState.save();
            //TODO 执行登录方法
            print('email:$_email , password:$_password');
            _login(context);
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
            PublicFunc.navTo('/reset_email', context);
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

  TextFormField buildEmailTextField() {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: '用户名/邮箱',
      ),
      validator: (String value) {
//        var emailReg = RegExp(
//            r"[\w!#$%&'*+/=?^_`{|}~-]+(?:\.[\w!#$%&'*+/=?^_`{|}~-]+)*@(?:[\w](?:[\w-]*[\w])?\.)+[\w](?:[\w-]*[\w])?");
//        if (!emailReg.hasMatch(value)) {
//          return '请输入正确的邮箱地址';
//        }
      },
      onSaved: (String value) => _email = value,
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
        '登录',
        style: TextStyle(fontSize: 42.0),
      ),
    );
  }

  ///用户名和密码登录
  void _login(BuildContext context) {
    User bmobUserRegister = User();
    bmobUserRegister.username = _email;
    bmobUserRegister.password = _password;
    User bmobUser = User();
    bmobUser.objectId = "7c7fd3afe1";
    RegExp rules = RegExp(r"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,13}$");
    //如果没输入
    if (_email == '') {
      Toast.show('请输入用户名或邮箱', context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
    } else {
      if (_password == '') {
        Toast.show('请输入密码', context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
      } else if (!rules.hasMatch(_password)) {
        Toast.show('请输入仅含字母和数字的6~13位密码', context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
      } else {
        PublicFunc.loading = true;
        setState(() {});
        bmobUserRegister.login().then((User bmobUser) async {
          PublicFunc.loading = false;
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setInt('confirm_login', 1);
          prefs.setString('user_name', bmobUser.username);
          prefs.setString(
              'user_job', bmobUser.job == null ? '小菜鸟' : bmobUser.job);
          prefs.setString('user_id', bmobUser.objectId);
          prefs.setBool('confirm', bmobUser.confirm);
          UsrData.usrName = bmobUser.username;
          UsrData.usrJob = bmobUser.job == null ? '小菜鸟' : bmobUser.job;
          UsrData.usrId = bmobUser.objectId;
          Toast.show("登录成功！", context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
          //返回设置页
          PublicFunc.back(context);
          // showSuccess(
          //     context, bmobUser.getObjectId() + "\n" + bmobUser.username);
        }).catchError((e) {
          PublicFunc.loading = false;
          setState(() {});
          Toast.show("用户名或密码错误！", context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
          // showError(context, BmobError.convert(e).error);
        });
      }
    }
  }
}
