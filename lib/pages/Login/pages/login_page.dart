import 'package:flutter/material.dart';

import '../../../pages/Login/pages/register_page.dart';
import '../../../tools/extension/int_extension.dart';
import '../../../tools/widgets/shopping_button.dart';
import '../../../tools/widgets/input.dart';


class LoginPage extends StatefulWidget {
  static const String routeName = "/login";
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  void hiddenKeyboard()  {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.close),
        ),
        title: const Text("登录"),
        actions: [
          TextButton(onPressed: (){}, child: const Text("客服",style: TextStyle(color: Colors.white)))
        ],
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: hiddenKeyboard,
        child: ListView(
          children: [
            buildLogoImageWidget(),
            buildUserNameInputWidget(),
            buildPasswordInputWidget(),
            buildForgetAndRegisterButton(),
            SizedBox(height: 45.px),
            buildLoginButtonWidget()
          ],
        ),
      ),
    );
  }

  Widget buildLogoImageWidget() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Image.asset("assets/images/login.png"),
    );
  }

  Widget buildUserNameInputWidget() {
    return Input(
        placeholder: "用户名/手机号",
        leading: const Icon(Icons.person,color: Colors.black54),
        borderType: BorderType.underlineBorder,
        isShowVerificationCode: true,
        valueCallBack: (text) {
          print("username == $text");
       },
    );
  }

  Widget buildPasswordInputWidget() {
    return Input(
      placeholder: "请输入密码",
      obscureText: true,
      borderType: BorderType.underlineBorder,
      leading: const Icon(Icons.lock,color: Colors.black54),
      valueCallBack: (text) {
        print("password == $text");
      },
    );
  }

  Widget buildForgetAndRegisterButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.px),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: (){},
            child: Text("忘记密码",style: TextStyle(color: Colors.black54,fontSize: 14.px))
          ),
          TextButton(
            onPressed: (){},
            child: Text("新用户注册",style: TextStyle(color: Colors.black54,fontSize: 14.px))
          ),
        ],
      ),
    );
  }

  //构建登录组件
  Widget buildLoginButtonWidget() {
    return ShoppingButton(
      title: "登 录",
      height: 44.px,
      fontWeight: FontWeight.bold,
      backgroundColor: Colors.redAccent,
      onPressed: () => Navigator.pushNamed(context, RegisterPage.routeName),
    );
  }
}
