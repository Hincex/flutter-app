import 'package:data_plugin/bmob/bmob.dart';
import 'package:data_plugin/bmob/bmob_query.dart';
import 'package:data_plugin/bmob/bmob_utils.dart';
import 'package:data_plugin/bmob/response/bmob_error.dart';
import 'package:data_plugin/bmob/response/bmob_saved.dart';
import 'package:data_plugin/bmob/table/bmob_user.dart';
import 'package:data_plugin/utils/dialog_util.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import '../../global_config.dart' show GlobalConfig;
import '../settings_config.dart';
import '../../public_func/PublicFunc.dart';
import '../../data/userData.dart';
import '../../data/advice.dart';

String _name = UsrData.usrName;

//发送信息
class ChatMessage extends StatelessWidget {
  ChatMessage({this.text, this.animationController});

  final AnimationController animationController;
  final String text;
  @override
  Widget build(BuildContext context) {
    return SizeTransition(
        sizeFactor:
            CurvedAnimation(parent: animationController, curve: Curves.easeOut),
        axisAlignment: 0.0,
        child: (Container(
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                //右对齐
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  //发送内容
                  Flexible(
                    child: Card(
                        shape: SettingConfig.cardShape,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              //昵称
                              // Container(
                              //   child: Text(_name,
                              //       style: Theme.of(context).textTheme.subhead),
                              // ),
                              //发送内容
                              Container(
                                // margin: const EdgeInsets.only(top: 10.0),
                                child: Text(text),
                              )
                            ],
                          ),
                        )),
                  ),
                  //头像
                  Container(
                    margin: const EdgeInsets.only(left: 10.0),
                    child: CircleAvatar(
                        child: Text(_name[0], style: TextStyle(fontSize: 25))),
                  ),
                ]))));
  }
}

class AdviceWidget extends StatefulWidget {
  @override
  AdviceWidgetState createState() => AdviceWidgetState();
}

class AdviceWidgetState extends State<AdviceWidget>
    with TickerProviderStateMixin {
  FlatButton qaButton(context, text, routes) {
    return FlatButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5))),
        color: GlobalConfig.themeData.primaryColor,
        onPressed: () {
          Navigator.of(context).pushNamed("$routes");
        },
        child: Container(
            child: Text(
          '$text',
          style: TextStyle(color: Colors.white),
        )));
  }

  Container qaCard(List<Widget> childrenEle) {
    return Container(
        margin: EdgeInsets.only(top: 10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: childrenEle));
  }

  Container content(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          PublicFunc.commonCard(Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Hi,这里是Q&A和意见反馈',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[Text('亲～有什么问题请点击下方选项或直接发送哦～')],
                ),
                //Q&A卡片
                qaCard([
                  qaButton(context, '实验室介绍', '/team'),
                  qaButton(context, '协会介绍', '/team'),
                  qaButton(context, '实验室介绍', '/team'),
                ]),
                qaCard([
                  qaButton(context, '实验室介绍', '/team'),
                  qaButton(context, '协会介绍', '/team'),
                  qaButton(context, '实验室介绍', '/team'),
                ]),
              ],
            ),
          )),
        ],
      ),
    );
  }

  final List<ChatMessage> _messages = <ChatMessage>[];

  final TextEditingController _textController = TextEditingController();
  bool _isComposing = false;
  int _time = 0;

  ///等于条件查询
  void _queryWhereEqual(BuildContext context) {
    BmobQuery<Advice> query = BmobQuery();
    query.addWhereEqualTo("user", UsrData.usrName);
    query.queryObjects().then((data) {
      PublicFunc.loading = false;
      setState(() {});
      // showSuccess(context, data.toString());
      List<Advice> advices = data.map((i) => Advice.fromJson(i)).toList();
      for (Advice advice in advices) {
        if (advice != null) {
          ChatMessage message = ChatMessage(
              text: advice.content,
              animationController: AnimationController(
                  duration: Duration(milliseconds: 500), vsync: this));
          setState(() {
            _messages.insert(0, message);
          });
          message.animationController.forward();
        }
      }
    }).catchError((e) {
      PublicFunc.loading = false;
      setState(() {});
      showError(context, BmobError.convert(e).error);
    });
  }

  @override
  void initState() {
    super.initState();
    PublicFunc.loading = true;
    _queryWhereEqual(context);
  }

  @override
  void dispose() {
    for (ChatMessage message in _messages)
      message.animationController.dispose();
    super.dispose();
  }

  ///保存一条数据
  _saveSingle(BuildContext context, String text) {
    Advice bmobUser = Advice();
    bmobUser.objectId = UsrData.usrId;
    Advice advice = Advice();
    advice.user = UsrData.usrName;
    advice.content = text;
    print(BmobUtils.getTableName(advice));
    if (_time == 3) {
      Toast.show('你已经连发了三条了,谢谢你的建议但请你考虑一下服务器的负荷哦~', context,
          duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
      _time = 0;
    } else {
      advice.save().then((BmobSaved bmobSaved) {
        Toast.show('发送成功,感谢你的建议🙏', context,
            duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
        // String message =
        //     "创建一条数据成功：${bmobSaved.objectId} - ${bmobSaved.createdAt}";
        // currentObjectId = bmobSaved.objectId;
        // showSuccess(context, message);
        _time++;
      }).catchError((e) {
        showError(context, BmobError.convert(e).error);
      });
    }
  }

  Widget inputArea() {
    void _handleSubmitted(String text) {
      if (text.length < 15) {
        Toast.show('好歹写个十五字吧。。。', context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
      } else {
        _saveSingle(context, text);
        _textController.clear();
        ChatMessage message = ChatMessage(
            text: text,
            animationController: AnimationController(
                duration: Duration(milliseconds: 500), vsync: this));
        setState(() {
          _messages.insert(0, message);
          _isComposing = false;
        });
        message.animationController.forward();
      }
    }

    return SafeArea(
      child: TextField(
          controller: _textController,
          onSubmitted: _handleSubmitted,
          onChanged: (String text) {
            setState(() {
              _isComposing = text.length > 0;
            });
          },
          decoration: InputDecoration(
              hintText: '发送建议',
              suffixIcon: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                        radius: 20.0,
                        backgroundColor: Colors.transparent,
                        child: IconButton(
                          icon: Icon(_isComposing ? Icons.send : Icons.edit),
                          color: GlobalConfig.themeData.primaryColor,
                          onPressed: () {
                            if (_textController.text.length > 0) {
                              _isComposing = true;
                              _handleSubmitted(_textController.text);
                            } else {
                              _isComposing = false;
                            }

                            // print(_isComposing);
                          },
                        )),
                  ])),
          maxLines: null,
          maxLength: 255),
    );
  }

  Widget mainScreen(BuildContext context) {
    return new PublicFunc().show(
        context,
        Padding(
          padding: EdgeInsets.all(5.0),
          child: Column(children: <Widget>[
            Container(
              child: content(context),
            ),
            Flexible(
              child: ListView.builder(
                padding: EdgeInsets.all(8.0),
                reverse: true,
                itemBuilder: (_, int index) => _messages[index],
                itemCount: _messages.length,
              ),
            ),
            // Flexible(child: content(context, _messages)),
            // Divider(height: 1.0),
            inputArea()
          ]),
        ),
        '加载中');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: GlobalConfig.themeData,
      home: Scaffold(
          appBar: AppBar(
            title: Text('意见反馈'),
            elevation: 0,
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
          body: mainScreen(context)),
    );
  }
}
