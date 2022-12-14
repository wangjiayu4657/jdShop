import 'dart:convert';
import 'package:flutter/services.dart';

import '../../pages/Category/models/tab_item_model.dart';
import '../../pages/Profile/models/setting_model.dart';

class JsonParse {
  static Future<T> dataFromJson<T>(String path) async {
    //获取json字符串
    final jsonPath = await rootBundle.loadString(path);
    //将json字符串转为map/list
    final result = json.decode(jsonPath);
    return result;
  }

  static Future<List<TabItemModel>> mapToTabItemModelFromLocalJson(String path) async{
    List result = await dataFromJson(path);
    return result.map((e) => TabItemModel.fromJson(e)).toList();
  }

  //从本地获取设置数据模型
  static Future<List<SettingModel>> loadSettingItemFromFile(String path) async{
    List result = await dataFromJson(path);
    return result.map((e) => SettingModel.fromJson(e)).toList();
  }

}