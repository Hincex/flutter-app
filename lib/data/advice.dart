import 'package:data_plugin/bmob/bmob_utils.dart';
import 'package:data_plugin/bmob/response/bmob_saved.dart';
import 'package:data_plugin/bmob/table/bmob_object.dart';
import 'package:data_plugin/bmob/response/bmob_handled.dart';

import 'package:data_plugin/bmob/bmob_dio.dart';
import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:data_plugin/bmob/response/bmob_registered.dart';

import 'package:data_plugin/bmob/bmob.dart';
part 'advice.g.dart';

@JsonSerializable()
class Advice extends BmobObject {
  factory Advice.fromJson(Map<String, dynamic> json) => _$AdviceFromJson(json);

  Map<String, dynamic> toJson() => _$AdviceToJson(this);

  String user;
  String content;

  Advice();

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
