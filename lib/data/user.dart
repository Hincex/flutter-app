import 'package:data_plugin/bmob/table/bmob_user.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:data_plugin/bmob/bmob_dio.dart';
import 'package:data_plugin/bmob/bmob.dart';
import 'package:data_plugin/bmob/response/bmob_updated.dart';
import 'package:data_plugin/bmob/response/bmob_error.dart';
part 'user.g.dart';

@JsonSerializable()
class User extends BmobUser {
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  int age;
  int gender;
  String nickname;
  String job;
  String school;
  bool confirm;
  User();

  ///修改一条数据
  Future<BmobUpdated> update() async {
    Map<String, dynamic> map = getParams();
    String objectId = map[Bmob.BMOB_PROPERTY_OBJECT_ID];
    if (objectId.isEmpty || objectId == null) {
      BmobError bmobError =
          new BmobError(Bmob.BMOB_ERROR_CODE_LOCAL, Bmob.BMOB_ERROR_OBJECT_ID);
      throw bmobError;
    } else {
      String params = getParamsJsonFromParamsMap(map);
      print(params);
      String tableName = '_User';
      Map responseData = await BmobDio.getInstance().put(
          Bmob.BMOB_API_CLASSES + tableName + Bmob.BMOB_API_SLASH + objectId,
          data: params);
      BmobUpdated bmobUpdated = BmobUpdated.fromJson(responseData);
      return bmobUpdated;
    }
  }

  ///账号密码登录
  Future<User> login() async {
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
    User bmobUser = User.fromJson(result);
    BmobDio.getInstance().setSessionToken(bmobUser.sessionToken);
    return bmobUser;
  }
}
