import 'dart:convert';

import '../../../tools/storage/storage.dart';

///用户信息服务类
class UserInfoService {
  static const String _userTable = "user_table";

  //获取当前用户信息
  static Future<Map<String,dynamic>> get currentUserInfo async {
    var users = await userInfoList;
    var userInfo = json.decode(users.last);
    return userInfo;
  }

  //获取用户信息
  static Future<List<String>> get userInfoList async {
    return await Storage.fetchList(_userTable);
  }

  //检查是否注册过
  static Future<bool> checkIsRegister(Map<String,dynamic> info) async{
    String userId = info["id"];

    var source = await UserInfoService.userInfoList;
    List<Map<String,dynamic>> users = source.map((e) => json.decode(e) as Map<String,dynamic>).toList();
    bool isRegister = users.any((element) => element["id"] == userId);
    return isRegister;
  }

  //保存用户信息
  static void saveUserInfo(Map<String,dynamic> info) async {
    bool isRegister = await checkIsRegister(info);
    if(!isRegister) {
      var source = await UserInfoService.userInfoList;
      String userInfo = json.encode(info);
      source.add(userInfo);
      Storage.save<List<String>>(_userTable, source);
      print('保存成功: users == ${UserInfoService.userInfoList}');
    }
  }

  //删除用户信息
  static void removeUserInfo(Map<String,dynamic> info) async{
    String userId = info["id"];

    var source = await UserInfoService.userInfoList;
    List<Map<String,dynamic>> users = source.map((e) => json.decode(e) as Map<String,dynamic>).toList();
    users.retainWhere((element) => element["id"] != userId);

    List<String> tempUsers = users.map((e) => json.encode(e)).toList();
    Storage.save<List<String>>(_userTable, tempUsers);
  }
}