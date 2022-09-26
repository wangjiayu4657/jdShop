import 'package:flutter/material.dart';

import '../../../tools/widgets/input.dart';
import '../../../tools/widgets/code_button.dart';
import '../../../tools/extension/int_extension.dart';
import '../../../tools/extension/color_extension.dart';
import '../../../pages/Login/widgets/next_button.dart';
import '../../../pages/Login/pages/register_third_page.dart';


class RegisterSecondPage extends StatefulWidget {
  static const String routeName = "/register_second";
  const RegisterSecondPage({Key? key}) : super(key: key);

  @override
  State<RegisterSecondPage> createState() => _RegisterSecondPageState();
}

class _RegisterSecondPageState extends State<RegisterSecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("手机快速注册")),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.px,horizontal: 15.px),
        child: Column(
          children: [
            buildTitleWidget(),
            SizedBox(height: 8.px),
            buildCodeWidget(),
            SizedBox(height: 24.px),
            buildNextStepButton()
          ],
        ),
      ),
    );
  }

  Widget buildTitleWidget() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.px),
      alignment: Alignment.bottomLeft,
      child: Text(
        "请输入收到的验证码",
        textAlign: TextAlign.left,
        style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 14.px),
      )
    );
  }

  Widget buildCodeWidget() {
    return SizedBox(
      height: 40.px,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Input(
              placeholder: "请输入验证码",
              borderType: BorderType.outlineBorder,
              borderColor: ColorExtension.lineColor,
              contentPadding: EdgeInsets.only(left: 12.px),
              hintStyle: TextStyle(fontSize: 14.px,color: Colors.black26),
            ),
          ),
          SizedBox(width: 8.px),
          Expanded(
            flex: 2,
            child: CodeButton(
              second: 12,
              height: 40.px,
              callback: (){},
            ),
          )
        ],
      ),
    );
  }

  Widget buildNextStepButton() {
    return NextButton(callback: () => Navigator.pushNamed(context, RegisterThirdPage.routeName));
  }
}
