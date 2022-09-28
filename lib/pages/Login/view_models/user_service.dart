import 'dart:convert';

import '../../../tools/storage/storage.dart';

///用户信息服务类
class UserService {
  static const String _userTable = "user_table";   //用户信息表
  static const String _loginState = "login_state"; //用户登录状态

  //获取登录状态
  static Future<bool> get isLogin async {
    return await Storage.fetchBool(_loginState);
  }

  //保存登录状态
  static void saveLoginState(bool login){
    print("loginState == $login");
    Storage.save<bool>(_loginState, login);
  }

  //获取当前用户信息
  static Future<Map<String,dynamic>> get currentUserInfo async {
    var users = await userInfoList;
    var userInfo = json.decode(users.last);
    return userInfo;
  }

  //获取所有用户信息
  static Future<List<String>> get userInfoList async {
    return await Storage.fetchList(_userTable);
  }

  //获取用户信息
  static Future<Map<String,dynamic>> userInfo(String id) async {
     var source = await UserService.userInfoList;
     List<Map<String,dynamic>> users = source.map((e) => json.decode(e) as Map<String,dynamic>).toList();

     Map<String,dynamic> userInfo = {};
     if(users.any((element) => element["id"] == id)){
       for(Map<String,dynamic> map in users) {
         if(map["id"] == id) {
           userInfo = map;
           userInfo.addAll({"success":true,"message":"登录成功"});
           break;
         }
       }
     } else {
       userInfo = {"success":false,"message":"登录失败，用户名或者密码错误"};
     }
     return userInfo;
  }

  //检查是否注册过
  static Future<bool> checkIsRegister(Map<String,dynamic> info) async{
    String userId = info["id"];

    var source = await UserService.userInfoList;
    List<Map<String,dynamic>> users = source.map((e) => json.decode(e) as Map<String,dynamic>).toList();
    bool isRegister = users.any((element) => element["id"] == userId);
    return isRegister;
  }

  //保存用户信息
  static void saveUserInfo(Map<String,dynamic> info) async {
    bool isRegister = await checkIsRegister(info);
    if(!isRegister) {
      var source = await UserService.userInfoList;
      String userInfo = json.encode(info);
      source.add(userInfo);
      Storage.save<List<String>>(_userTable, source);
      print('保存成功: users == ${UserService.userInfoList}');
    }
  }

  //删除用户信息
  static void removeUserInfo(Map<String,dynamic> info) async{
    String userId = info["id"];

    var source = await UserService.userInfoList;
    List<Map<String,dynamic>> users = source.map((e) => json.decode(e) as Map<String,dynamic>).toList();
    users.retainWhere((element) => element["id"] != userId);

    List<String> tempUsers = users.map((e) => json.encode(e)).toList();
    Storage.save<List<String>>(_userTable, tempUsers);
  }
}