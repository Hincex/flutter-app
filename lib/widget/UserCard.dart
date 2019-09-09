import 'package:flutter/material.dart';
import 'package:IVAT/global_config.dart';
import 'package:IVAT/public_func/PublicFunc.dart';
import '../data/userData.dart';
import '../util/avatar_util.dart';

class UserCard extends StatelessWidget {
  UserCard({@required this.fatherContext});
  final BuildContext fatherContext;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      margin: EdgeInsets.only(bottom: 10),
      width: MediaQuery.of(context).size.width,
      color: GlobalConfig.themeData.primaryColor,
      child: Stack(
        // mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Positioned(top: 10, left: 20, child: UserAvatar()),
          Positioned(
            top: 10,
            left: 80,
            child: GestureDetector(
              onTap: () {
                PublicFunc.navTo('/user', fatherContext);
              },
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    //用户名
                    Container(
                      // margin: EdgeInsets.only(right: 30),
                      child: Text(
                        UsrData.usrName,
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                    ),
                    //其他
                    Container(
                      child: Text(
                        UsrData.usrJob,
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Container(
            //   child: Icon(Icons.chevron_right),
            // )
          )
        ],
      ),
    );
  }
}

class UserAvatar extends StatefulWidget {
  @override
  _UserAvatarState createState() => _UserAvatarState();
}

class _UserAvatarState extends State<UserAvatar> {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        backgroundImage:
            AvatarUtil.imgPath == null ? null : FileImage(AvatarUtil.imgPath),
        minRadius: 20,
        maxRadius: 25,
        child: GestureDetector(
            child: AvatarUtil.imgPath == null
                ? Text(UsrData.usrName[0],
                    style: TextStyle(fontSize: 25, color: Colors.white))
                : null,
            // 长按弹出头像选择
            onLongPress: () async {
              if (await PublicFunc.userLogin() == 1) {
                showDialog<Null>(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return SimpleDialog(
                        backgroundColor: GlobalConfig.dark
                            ? ThemeData.dark().backgroundColor
                            : Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
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
                              AvatarUtil.takePhoto(context);
                              PublicFunc.back(context);
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
                              AvatarUtil.openGallery(context);
                            },
                          ),
                        ]);
                  },
                );
              }
            }));
  }
}
