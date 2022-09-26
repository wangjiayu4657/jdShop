import '../../../tools/http/http_client.dart';

class RegisterViewModel {
  RegisterViewModel({this.tel});

  //电话号码
  final String? tel;


  void sendCodeRequest() {
    HttpClient.request(url: "api/sendCode",method: "post");
  }
}