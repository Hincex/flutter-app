import 'package:data_plugin/bmob/bmob_utils.dart';
import 'package:data_plugin/bmob/table/bmob_object.dart';
import 'package:data_plugin/bmob/table/bmob_user.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:data_plugin/bmob/bmob_dio.dart';
import 'package:data_plugin/bmob/bmob.dart';
import 'package:data_plugin/bmob/response/bmob_updated.dart';
import 'package:data_plugin/bmob/response/bmob_error.dart';

part 'confirm.g.dart';

@JsonSerializable()
class Confirm extends BmobObject {
  factory Confirm.fromJson(Map<String, dynamic> json) =>
      _$ConfirmFromJson(json);

  Map<String, dynamic> toJson() => _$ConfirmToJson(this);

  String confirmCode;
  bool used;

  Confirm();

  @override
  Map getParams() {
    // TODO: implement getJson
    Map<String, dynamic> map = toJson();
    Map<String, dynamic> data = new Map();
    //去除空值
    map.forEach((key, value) {
      if (value != null) {
        data[key] = value;
      }
    });
    return map;
  }
}
