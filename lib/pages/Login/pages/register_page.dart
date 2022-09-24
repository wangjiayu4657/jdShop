import 'package:flutter/material.dart';

import '../../../pages/Login/widgets/next_button.dart';
import '../../../tools/extension/color_extension.dart';
import '../../../tools/extension/int_extension.dart';
import '../../../tools/widgets/input.dart';


class RegisterPage extends StatefulWidget {
  static const String routeName = "/register";
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("手机快速注册")),
      body: Container(
        padding: EdgeInsets.only(top: 20.px),
        child: buildStepFirstWidget(),
      ),
    );
  }

  Widget buildStepFirstWidget() {
    return Column(
      children: [
        buildFirstStepContentWidget(),
        SizedBox(height: 24.px),
        NextButton(callback: (){})
      ],
    );
  }

  Widget buildFirstStepContentWidget() {
    return Container(
      height: 44.px,
      margin: EdgeInsets.symmetric(horizontal: 15.px),
      decoration: BoxDecoration(
        border: Border.all(color: ColorExtension.lineColor)
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildFirstStepContentLeadingWidget(),
          Expanded(child: buildFirstStepContentInputWidget())
        ],
      ),
    );
  }

  Widget buildFirstStepContentLeadingWidget() {
    return InkWell(
      onTap: (){},
      child: Padding(
        padding: EdgeInsets.only(left: 15.px),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text("+86"),
            Icon(Icons.keyboard_arrow_down)
          ],
        ),
      ),
    );
  }

  Widget buildFirstStepContentInputWidget() {
    return Input(
      placeholder: "请输入手机号",
      valueCallBack: (text){
        print("text == $text");
      },
    );
  }
}
