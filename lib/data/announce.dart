import 'package:data_plugin/bmob/table/bmob_user.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:data_plugin/bmob/bmob_dio.dart';
import 'package:data_plugin/bmob/bmob.dart';
part 'announce.g.dart';

@JsonSerializable()
class Announce extends BmobUser {
  factory Announce.fromJson(Map<String, dynamic> json) =>
      _$AnnounceFromJson(json);

  Map<String, dynamic> toJson() => _$AnnounceToJson(this);

  String author;
  String title;
  String content;

  Announce();

  ///账号密码登录
  Future<Announce> login() async {
    Map<String, dynamic> map = toJson();
    Map<String, dynamic> data = new Map();
    //去除由服务器生成的字段值
    map.remove("objectId");
    map.remove("createdAt");
    map.remove("updatedAt");
    map.remove("sessionToken");
    //去除空值
    map.forEach((key, value) {
      if (value != null) {
        data[key] = value;
      }
    });
    //Map转String
    //发送请求
    Map result = await BmobDio.getInstance()
        .get(Bmob.BMOB_API_LOGIN + getUrlParams(data));
    print(result);
    Announce bmobUser = Announce.fromJson(result);
    BmobDio.getInstance().setSessionToken(bmobUser.sessionToken);
    return bmobUser;
  }
}
