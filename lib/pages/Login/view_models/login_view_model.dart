import 'package:flutter/material.dart';
import 'package:jdShop/pages/Login/view_models/user_service.dart';

import '../models/user_model.dart';
import '../../../tools/http/http_client.dart';
import '../../../tools/share/user_manager.dart';
import '../../../tools/extension/object_extension.dart';

class LoginViewModel extends ChangeNotifier {
  //是否登录
  // late UserModel? loginModel;
  // late bool _isLogin = false;
  // late final UserManager _userManager = UserManager.instance;

  // LoginViewModel() {
  //   _initLoginState();
  // }

  // void _initLoginState() async {
  //   _isLogin = _userManager.isLogin;
  //   loginModel = _userManager.currentUser;
  // }

  //登录请求
  Future<UserModel?> loginRequest(String userName,String password) async {
    var param = {"username":userName,"password":password};
    var response = await HttpClient.request(url: "api/doLogin",method: "post",params: param);
    bool isSuccess = response["success"];
    UserModel? loginModel;
    if(isSuccess){
      showToast(response["message"]);
      loginModel = UserModel.fromJson(response);
      // _isLogin = true;
    } else {
      String id = "${userName}_$password";
      var userInfo = await UserService.userInfo(id);
      bool success = userInfo["success"];
      showToast(userInfo["message"]);
      loginModel = success ? UserModel.fromJson(userInfo) : null;
      // _isLogin = success;
    }
    // _userManager.saveLoginState(_isLogin);

    return loginModel;
  }

  //退出登录
  // void loginOutRequest() {
  //   _isLogin = false;
  //   loginModel = null;
  //   _userManager.saveLoginState(_isLogin);
  // }


  // setter and getter

  // bool get isLogin => _isLogin;
  //
  // set isLogin(bool value) {
  //   _isLogin = value;
  //   notifyListeners();
  // }
}