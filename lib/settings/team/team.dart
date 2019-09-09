import 'package:flutter/material.dart';
import '../../global_config.dart' show GlobalConfig; //全局设置
import '../../public_func/PublicFunc.dart';
import 'package:device_info/device_info.dart';
import '../../widget/ListItem.dart';
import '../../widget/CardColumn.dart';

class Team extends StatefulWidget {
  @override
  TeamState createState() => TeamState();
}

class TeamState extends State<Team> {
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
                overflow: Overflow.visible,
                // alignment: Alignment(5,5),
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
                            style: TextStyle(fontSize: 30, color: Colors.white),
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
                  Positioned(
                    left: 0.0,
                    right: 0.0,
                    top: 80.0,
                    child: CardColumn(
                      height: 240,
                      children: [
                        ListItem(
                          title: Text('作者'),
                          subtitle: Text('Vince He'),
                          leading: Icon(Icons.offline_bolt),
                        ),
                        ListItem(
                          title: Text('UI设计'),
                          subtitle: Text('李丽莎'),
                          leading: Icon(Icons.palette),
                        ),
                        ListItem(
                          title: Text('特别鸣谢'),
                          subtitle: Text('Google Inc.'),
                          leading: Icon(Icons.pages),
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
