import 'package:flutter/material.dart';
import 'package:data_plugin/utils/dialog_util.dart';
import 'package:data_plugin/bmob/response/bmob_error.dart';
import 'package:data_plugin/bmob/bmob_file_manager.dart';
import 'package:data_plugin/bmob/type/bmob_file.dart';
import 'package:data_plugin/data_plugin.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import '../store/model/index.dart';

class AvatarUtil {
  static dynamic imgPath;
  static String _url;
  static BmobFile _bmobFile;

  ///上传文件，上传文件涉及到android的文件访问权限，调用此方法前需要开发者们先适配好应用在各个android版本的权限管理。
  static _uploadFile(String path, BuildContext context) {
    if (path == null) {
      DataPlugin.toast("请先选择文件");
      return;
    }
    DataPlugin.toast("上传中，请稍候……");
    File file = new File(path);
    BmobFileManager.upload(file).then((BmobFile bmobFile) {
      _bmobFile = bmobFile;
      _url = bmobFile.url;
      print("${bmobFile.cdn}\n${bmobFile.url}\n${bmobFile.filename}");
      DataPlugin.toast(
          "上传成功：${bmobFile.cdn}\n${bmobFile.url}\n${bmobFile.filename}");
    }).catchError((e) {
      showError(context, BmobError.convert(e).error);
    });
  }

/*拍照*/
  static Future takePhoto(BuildContext context) async {
    File image = await ImagePicker.pickImage(source: ImageSource.camera);
    print(image);
    // 通知获得头像，刷新UI
    Provider.of<ThemeChange>(context).avatarChange(image);
    _uploadFile(imgPath.path, context);
  }

  /*相册*/
  static Future openGallery(BuildContext context) async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    // 通知获得头像，刷新UI
    Provider.of<ThemeChange>(context).avatarChange(image);
    //开始上传头像
    if (imgPath != null) {
      print(imgPath.path);
//      _uploadFile(imgPath.path, context);
    }
  }
}
