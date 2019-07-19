import 'package:data_plugin/bmob/bmob_utils.dart';
import 'package:data_plugin/bmob/response/bmob_saved.dart';
import 'package:data_plugin/bmob/table/bmob_user.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:data_plugin/bmob/bmob_dio.dart';
import 'package:data_plugin/bmob/bmob.dart';
part 'advice.g.dart';

@JsonSerializable()
class Advice extends BmobUser {
  factory Advice.fromJson(Map<String, dynamic> json) =>
      _$AdviceFromJson(json);

  Map<String, dynamic> toJson() => _$AdviceToJson(this);

  String user;
  String content;

  Advice();

  ///新增一条数据
  Future<BmobSaved> save() async {
    Map<String, dynamic> map = getParams();
    String params = getParamsJsonFromParamsMap(map);
    print(params);
    String tableName = 'Advice';

    Map responseData = await BmobDio.getInstance()
        .post(Bmob.BMOB_API_CLASSES + tableName, data: params);
    BmobSaved bmobSaved = BmobSaved.fromJson(responseData);
    return bmobSaved;
  }
}
