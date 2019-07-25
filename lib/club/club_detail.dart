import 'dart:async';

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
import 'package:webview_flutter/webview_flutter.dart';

class ClubDetail extends StatefulWidget {
  @override
  ClubDetailState createState() => ClubDetailState();
}

class ClubDetailState extends State<ClubDetail> {
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

  Widget mainscreen(BuildContext context) {
    if (PublicFunc.loading) {
      return Stack(
        children: <Widget>[
          WebView(
            initialUrl: args[1], // 加载的url
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController web) {
              _controller = web;
              // webview 创建调用，
              //  web.loadUrl(url)
              // web.canGoBack().then((res) {
              //   print(res); // 是否能返回上一级
              // });
              // web.currentUrl().then((url) {
              //   print(url); // 返回当前url
              // });
              // web.canGoForward().then((res) {
              //   print(res); //是否能前进
              // });
              PublicFunc.loading = false;
            },
            onPageFinished: (String value) {
              // webview 页面加载调用
            },
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SpinKitWave(
                color: GlobalConfig.dark
                    ? Colors.white
                    : GlobalConfig.themeData.primaryColor,
                width: 50,
                height: 50,
                type: SpinKitWaveType.center,
              ),
              Text('加载中')
            ],
          )
        ],
      );
    } else {
      return WebView(
        initialUrl: args[1], // 加载的url
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController web) {
          PublicFunc.loading = false;
          _controller = web;
          // webview 创建调用，
          //  web.loadUrl(url)
          // web.canGoBack().then((res) {
          //   print(res); // 是否能返回上一级
          // });
          // web.currentUrl().then((url) {
          //   print(url); // 返回当前url
          // });
          // web.canGoForward().then((res) {
          //   print(res); //是否能前进
          // });
        },
        onPageFinished: (String value) {
          // webview 页面加载调用
        },
      );
    }
  }

  WebViewController _controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(args[0]),
        elevation: 0,
        backgroundColor: GlobalConfig.themeData.primaryColor,
        leading: IconButton(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          color: Colors.white,
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            // PublicFunc.back(context, {});
            _controller.canGoBack().then((res) {
              if (res) {
                _controller.goBack();
              } else {
                return PublicFunc.back(context);
              }
            });
          },
        ),
      ),
      body: Stack(
        children: <Widget>[
          WebView(
            initialUrl: args[1], // 加载的url
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController web) {
              _controller = web;
              // webview 创建调用，
              //  web.loadUrl(url)
              // web.canGoBack().then((res) {
              //   print(res); // 是否能返回上一级
              // });
              // web.currentUrl().then((url) {
              //   print(url); // 返回当前url
              // });
              // web.canGoForward().then((res) {
              //   print(res); //是否能前进
              // });
              PublicFunc.loading = false;
            },
            onPageFinished: (String value) {
              // webview 页面加载调用
            },
          ),
        ],
      ),
    );
  }
}
