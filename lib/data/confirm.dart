import 'package:data_plugin/bmob/bmob_utils.dart';
import 'package:data_plugin/bmob/table/bmob_user.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:data_plugin/bmob/bmob_dio.dart';
import 'package:data_plugin/bmob/bmob.dart';
import 'package:data_plugin/bmob/response/bmob_updated.dart';
import 'package:data_plugin/bmob/response/bmob_error.dart';

part 'confirm.g.dart';

@JsonSerializable()
class Confirm extends BmobUser {
  factory Confirm.fromJson(Map<String, dynamic> json) =>
      _$ConfirmFromJson(json);

  Map<String, dynamic> toJson() => _$ConfirmToJson(this);

  String confirmCode;
  bool used;


  Confirm();

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
      String tableName = 'Confirm';
      Map responseData = await BmobDio.getInstance().put(
          Bmob.BMOB_API_CLASSES + tableName + Bmob.BMOB_API_SLASH + objectId,
          data: params);
      BmobUpdated bmobUpdated = BmobUpdated.fromJson(responseData);
      return bmobUpdated;
    }
  }
}
