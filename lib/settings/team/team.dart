import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../global_config.dart' show GlobalConfig; //全局设置
import '../settings_config.dart';
import '../../public_func/PublicFunc.dart';
import 'package:device_info/device_info.dart';

class Team extends StatefulWidget {
  @override
  TeamState createState() => TeamState();
}

class TeamState extends State<Team> {
  //列表项
  Widget listItem(
      String title, String subtitle, Widget leftIcon, Widget rightIcon) {
    return ListTile(
      title: Text('$title'),
      subtitle: Text('$subtitle'),
      leading: leftIcon,
      trailing: rightIcon,
    );
  }

  Future deviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    // AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    // print('Running on ${androidInfo.model}'); // e.g. "Moto G (4)"

    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    print('Running on ${iosInfo.utsname.machine}');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: GlobalConfig.themeData,
      home: Scaffold(
        appBar: AppBar(
          title: Text('开发团队'),
          elevation: 0,
          leading: IconButton(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            color: Colors.white,
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              PublicFunc.back(context, {});
            },
          ),
        ),
        body: Container(
          // margin: EdgeInsets.all(20),
          child: ListView(
            children: <Widget>[
              Stack(
                alignment: Alignment(0, 35),
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(20),
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    color: GlobalConfig.themeData.primaryColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Text(
                            'V1.0.0',
                            style: TextStyle(fontSize: 40, color: Colors.white),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 5),
                          child: Text(
                            'Feel Free',
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(20),
                    child: PublicFunc.commonCard(Column(
                      children: <Widget>[
                        listItem('作者', 'Vince He', Icon(Icons.pages),
                            Icon(Icons.chevron_right)),
                        listItem('特别鸣谢', 'Google Inc.', Icon(Icons.pages),
                            Icon(Icons.chevron_right))
                      ],
                    )),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
