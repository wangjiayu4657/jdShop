import '../../../tools/http/http_client.dart';
import '../../../tools/extension/object_extension.dart';
import '../../../pages/Login/view_models/user_info_service.dart';

class RegisterViewModel {

  late String _tel = "";
  late String _code = "";

  //发送验证码
  void sendCodeRequest(String tel) async {
    _tel = tel;
    if(!_checkTelephoneNumber()) return;
    var response = await HttpClient.request(url: "api/sendCode",method: "post",params: {"tel":tel});
    print("result === $response");
    bool result = response["success"];
    if(!result) {
      String msg = response["message"];
      showToast(msg);
    } else {
      _code = response["code"];
    }
  }
  
  //校验验证码
  Future<bool> checkCodeRequest() async {
    if(!_checkCode()) return false;
    Map<String,dynamic> params = {"tel":_tel,"code":_code};
    var response = await HttpClient.request(url: "api/validateCode",method: "post",params: params);
    bool result = response["success"];
    return result;
  }

  /*
  [{"_id":"5d35623c303a591b50cd74a2",
  "username":"15212345678",
  "tel":"15212345678",
  "salt":"758a06618c69880a6cee5314ee42d52f"
  }]
  */
  //注册账号
  void registerAccountRequest(Map<String,dynamic> params) async {
    var response = await HttpClient.request(url: "api/register",method: "post",params: params);
    bool result = response["success"];
    String msg = response["message"];

    showToast(msg);
    Map<String,dynamic> userInfo = {};

    if(result) {
      List<Map<String,dynamic>> users = response["userinfo"];
      userInfo = users.first;
    } else {
      String tel = params["tel"];
      String password = params["password"];
      String id = "${tel}_$password";

      userInfo = {
        "id": id,
        "tel": tel,
        "username": tel,
        "salt": id,
      };
    }

    UserInfoService.saveUserInfo(userInfo);
  }

  //校验手机号码格式是否正确
  bool _checkTelephoneNumber() {
    RegExp regExp = RegExp(r"^1\d{10}$");
    if(!regExp.hasMatch(_tel)){
      showToast("手机号码格式不正确!");
      return false;
    }
    return true;
  }

  //校验验证码是否正确
  bool _checkCode() {
    if(_code.isEmpty){
      showToast("请输入验证码");
      return false;
    } else if(_code.length < 6){
      showToast("验证码格式不正确");
      return false;
    }
    return true;
  }
}