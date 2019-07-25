import 'package:IVAT/data/content.dart';
import 'package:IVAT/data/userData.dart';
import 'package:IVAT/public_func/PublicFunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:toast/toast.dart';
import '../global_config.dart' show GlobalConfig; //全局设置
import '../settings/settings_config.dart';
import 'package:data_plugin/bmob/bmob_query.dart';
import 'package:data_plugin/utils/dialog_util.dart';
import 'package:data_plugin/bmob/response/bmob_error.dart';

class ClubPage extends StatefulWidget {
  @override
  ClubPageState createState() => ClubPageState();
}

class ClubPageState extends State<ClubPage> {
  List<Widget> _books = [];
  int _index;
  int _tempindex;
  Widget books(String img, String title, String content,int index) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      GestureDetector(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            //图片
            Image(
              image: NetworkImage(img),
              fit: BoxFit.fill,
            ),
          ],
        ),
        onTap: () {
          setState(() {
            _tempindex = _index;
            _index = index;
            //如果再次点击相同的，则取消显示
            if (_tempindex == _index) {
              // show = !show;
            } else {
              // show = true;
            }
          });
          PublicFunc.navTo('/club_detail', context, [title,content], null);
          // Toast.show('进入了$title', context);
        },
      ),

      //标题
      Container(
        padding: EdgeInsets.all(1),
        decoration: BoxDecoration(color: Color(0X80000000)),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 13, color: Colors.white),
        ),
      )
    ]);
  }

  ///等于条件查询
  void _queryWhereEqual(BuildContext context) {
    BmobQuery<Content> query = BmobQuery();
    query.addWhereEqualTo("type", args[1]);
    query.queryObjects().then((data) {
      PublicFunc.loading = false;
      setState(() {});
      // showSuccess(context, data.toString());
      List<Content> messages = data.map((i) => Content.fromJson(i)).toList();
      for (int i = 0; i < messages.length; i++) {
        _books.add(books(messages[i].img, messages[i].title,messages[i].content, i));
        setState(() {});
      }
    }).catchError((e) {
      PublicFunc.loading = false;
      setState(() {});
      showError(context, BmobError.convert(e).error);
    });
    _firstin = false;
  }

  var args;
  bool _firstin = true;
  @override
  void initState() {
    PublicFunc.loading = true;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _firstin = true;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    args = ModalRoute.of(context).settings.arguments;
  }

  Widget mainScreen(BuildContext context) {
    return new PublicFunc().show(
        context,
        Container(
          margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Column(
            children: <Widget>[
              Container(
                  child: GridView.builder(
                shrinkWrap: true,
                primary: false,
                reverse: false,
                scrollDirection: Axis.vertical,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, //每行三列
                    crossAxisSpacing: 10.0, // 横向间距
                    childAspectRatio: 0.567),
                itemBuilder: (BuildContext context, int index) {
                  return _books[index];
                },
                itemCount: _books.length,
              ))
            ],
          ),
        ),
        '加载中');
  }

  @override
  Widget build(BuildContext context) {
    if (_firstin) {
      _queryWhereEqual(context);
    }
    //   print(args);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: GlobalConfig.themeData,
      home: Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text(args[0]),
            leading: IconButton(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              color: Colors.white,
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                PublicFunc.back(context);
              },
            ),
          ),
          body: ListView(
            children: <Widget>[
              mainScreen(context),
            ],
          )),
    );
  }
  // return MaterialApp(
  //   theme: GlobalConfig.themeData,
  //   debugShowCheckedModeBanner: false,
  //   routes: {
  //     "/": (_) => WebviewScaffold(
  //           url: "https://wenku.baidu.com/view/0618529559eef8c75ebfb300.html",
  //           appBar: AppBar(
  //               elevation: 0,
  //               title: Text(args[0]),
  //               leading: IconButton(
  //                 highlightColor: Colors.transparent,
  //                 splashColor: Colors.transparent,
  //                 color: Colors.white,
  //                 icon: Icon(Icons.arrow_back_ios),
  //                 onPressed: () {
  //                   PublicFunc.back(context, {});
  //                 },
  //               )),
  //           hidden: true,
  //           initialChild: Container(
  //               color: Colors.redAccent,
  //               child: Stack(
  //                 children: <Widget>[
  //                   Container(
  //                     height: MediaQuery.of(context).size.height,
  //                     width: MediaQuery.of(context).size.width,
  //                     decoration: BoxDecoration(
  //                         color: GlobalConfig.themeData.backgroundColor),
  //                   ),
  //                   Column(
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       children: [
  //                         SpinKitWave(
  //                           color: GlobalConfig.dark
  //                               ? Colors.white
  //                               : GlobalConfig.themeData.primaryColor,
  //                           width: 50,
  //                           height: 50,
  //                           type: SpinKitWaveType.center,
  //                         ),
  //                         Text('加载中')
  //                       ]),
  //                 ],
  //               )),
  //           // 允许LocalStorage
  //           withLocalStorage: true,
  //           // 允许执行js代码
  //           withJavascript: true,
  //         )
  //   },
  // );
}
