import 'package:data_plugin/bmob/response/bmob_handled.dart';
import 'package:data_plugin/bmob/table/bmob_user.dart';
import '../../public_func/PublicFunc.dart';
import 'package:toast/toast.dart';
/**
 * login page
 */
import 'package:flutter/material.dart';
import 'package:data_plugin/bmob/response/bmob_error.dart';
import 'package:data_plugin/utils/dialog_util.dart';
import '../../global_config.dart' show GlobalConfig;

class EmailReset extends StatefulWidget {
  @override
  _EmailResetState createState() => _EmailResetState();
}

class _EmailResetState extends State<EmailReset> {
  final _formKey = GlobalKey<FormState>();
  String _email;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: GlobalConfig.themeData,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            leading: IconButton(
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
          body: Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 22.0),
                children: <Widget>[
                  SizedBox(
                    height: kToolbarHeight,
                  ),
                  buildTitle(),
                  buildTitleLine(),
                  SizedBox(height: 30.0),
                  buildVerifyTextField(context),
                  SizedBox(height: 30.0),
                ],
              ))),
    );
  }

  TextFormField buildVerifyTextField(BuildContext context) {
    return TextFormField(
      onSaved: (String value) => _email = value,
      validator: (String value) {
        if (value.isEmpty) {
          return '请输入邮箱';
        }
      },
      decoration: InputDecoration(
          labelText: '邮箱',
          suffixIcon: IconButton(
              icon: Icon(
                Icons.send,
              ),
              onPressed: () {
                _formKey.currentState.save();
                _sendEmail(context);
              })),
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
        '发送重置密码邮件',
        style: TextStyle(fontSize: 42.0),
      ),
    );
  }

  ///发送重置密码邮件到邮箱
  _sendEmail(BuildContext context) {
    BmobUser bmobUser = BmobUser();
    bmobUser.email = _email;
    //是电子邮件格式
    RegExp isEmail = RegExp(r"^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$");
    if (!isEmail.hasMatch(_email)) {
      Toast.show('请输入正确的电子邮件', context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
    } else {
      bmobUser.requestPasswordResetByEmail().then((BmobHandled bmobHandled) {
        Toast.show('已发送，请注意查收邮件', context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
        // showSuccess(context, '已发送，请注意查收邮件');
      }).catchError((e) {
        showError(context, BmobError.convert(e).error);
      });
    }
  }
}
