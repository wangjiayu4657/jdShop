import 'dart:math';

import 'package:flutter/material.dart';


import 'user_service.dart';
import '../models/login_model.dart';
import '../../../tools/http/http_client.dart';
import '../../../tools/extension/object_extension.dart';


class LoginViewModel extends ChangeNotifier {

  //是否登录
  late LoginModel? loginModel;
  late bool _isLogin = false;

  LoginViewModel() {
    _initLoginState();
  }

  void _initLoginState() async {
    _isLogin = await UserService.isLogin;
    if(_isLogin){
      var jsonData = await UserService.currentUserInfo;
      loginModel = LoginModel.fromJson(jsonData);
    }
  }

  //登录请求
  Future<LoginModel?> loginRequest(String userName,String password) async {
    var param = {"username":userName,"password":password};
    var response = await HttpClient.request(url: "api/doLogin",method: "post",params: param);
    bool isSuccess = response["success"];
    if(isSuccess){
      showToast(response["message"]);
      loginModel = LoginModel.fromJson(response);
      _isLogin = true;
    } else {
      String id = "${userName}_$password";
      var userInfo = await UserService.userInfo(id);
      bool success = userInfo["success"];
      print("success  == $success");
      showToast(userInfo["message"]);
      loginModel = success ? LoginModel.fromJson(userInfo) : null;
      _isLogin = success;
    }
    UserService.saveLoginState(_isLogin);
    return loginModel;
  }

  // setter and getter

  bool get isLogin => _isLogin;

  set isLogin(bool value) {
    _isLogin = value;
    print("_isLogin == $value");
    notifyListeners();
  }
}