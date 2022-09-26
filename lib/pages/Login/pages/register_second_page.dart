import 'package:flutter/material.dart';
import 'package:jdShop/pages/Login/pages/login_page.dart';
import 'package:jdShop/pages/Main/main_page.dart';

import '../widgets/next_button.dart';
import '../../../tools/widgets/input.dart';
import '../../../tools/extension/int_extension.dart';

class RegisterSecondPage extends StatefulWidget {
  static const String routeName = "/register_second";
  const RegisterSecondPage({Key? key}) : super(key: key);

  @override
  State<RegisterSecondPage> createState() => _RegisterSecondPageState();
}

class _RegisterSecondPageState extends State<RegisterSecondPage> {

  //密码是否可见
  bool _isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("手机快速注册")),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.px,vertical: 10.px),
        child: Column(
          children: [
            buildPasswordInputWidget(),
            SizedBox(height: 15.px),
            buildPasswordShowWidget(),
            SizedBox(height: 24.px),
            buildNextStepButton()
          ],
        ),
      ),
    );
  }

  Widget buildPasswordInputWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.px),
          child: const Text("请设置登录密码",style: TextStyle(color: Colors.black87),),
        ),
        Input(
          placeholder: "请设置为6-20位字符",
          borderType: BorderType.outlineBorder,
          contentPadding: EdgeInsets.only(left: 15.px),
        )
      ],
    );
  }

  Widget buildPasswordShowWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: (){
            setState(() => _isVisible = !_isVisible);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon( _isVisible ? Icons.check_circle : Icons.radio_button_off,color: Colors.redAccent),
              SizedBox(width: 8.px),
              Text("密码可见",style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.black54,fontSize: 16.px))
            ]
          ),
        ),
        SizedBox(height: 20.px),
        const Text(
          "密码由6-20位字母,数字或半角符号组成,不能是10位一下纯数字/字母/半角符号,字母需区分大小写",
          style: TextStyle(color: Colors.black26),
        )
      ],
    );
  }

  Widget buildNextStepButton() {
    return NextButton(title: "完  成",callback: (){
      Navigator.pushNamedAndRemoveUntil(context, MainPage.routeName, (route) => false);
    });
  }
}
