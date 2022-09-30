import 'package:flutter/material.dart';

import '../../pages/Login/models/user_model.dart';
import '../../pages/Login/view_models/user_service.dart';

///实例
var userManager = UserManager();

///单例类
class UserManager extends ChangeNotifier {

  //是否登录
  late bool _isLogin = false;
  //当前用户信息
  late UserModel? currentUser = UserModel();

  // 工厂方法构造函数 - 通过UserModel()获取对象1
  factory UserManager() => _getInstance();

  // instance的getter方法 - 通过UserModel.instance获取对象2
  static UserManager get instance => _getInstance();

  // 静态变量_instance，存储唯一对象
  static UserManager? _instance;

  // 获取唯一对象
  static UserManager _getInstance() {
    _instance ??= UserManager._internal();
    return _instance!;
  }

  //初始化...
  UserManager._internal() {
    initUserInformation();
  }

  //初始化用户信息
  void initUserInformation() async {
    _isLogin = await UserService.isLogin;
    var userMap = await UserService.currentUserInfo;
    if(userMap != null) {
      currentUser = UserModel.fromJson(userMap);
    }
  }

  //获取所有用户信息
  Future<List<String>> get userInfoList async {
    return await UserService.userInfoList;
  }

  //获取用户信息
  Future<Map<String,dynamic>> userInfo(String id) async {
    return await UserService.userInfo(id);
  }

  //检查是否注册过
  Future<bool> checkIsRegister(Map<String,dynamic> info) async{
    return await UserService.checkIsRegister(info);
  }

  //保存用户信息
  void saveUserInfo(Map<String,dynamic> info) async {
    UserService.saveUserInfo(info);
    notifyListeners();
  }

  //删除用户信息
  void removeUserInfo(Map<String,dynamic> info) async{
    UserService.removeUserInfo(info);
    notifyListeners();
  }

  bool get isLogin => _isLogin;

  set isLogin(bool value) {
    _isLogin = value;
    UserService.saveLoginState(value);
    notifyListeners();
  }
}