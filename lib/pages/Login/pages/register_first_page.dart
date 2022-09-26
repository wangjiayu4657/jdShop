import 'package:flutter/material.dart';

import '../../../tools/widgets/input.dart';
import '../../../tools/widgets/code_button.dart';
import '../../../tools/extension/int_extension.dart';
import '../../../tools/extension/color_extension.dart';
import '../../../pages/Login/widgets/next_button.dart';
import '../../../pages/Login/pages/register_second_page.dart';


class RegisterFirstPage extends StatefulWidget {
  static const String routeName = "/register_first";
  const RegisterFirstPage({Key? key}) : super(key: key);

  @override
  State<RegisterFirstPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterFirstPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("手机快速注册")),
      body: buildContentWidget(),
    );
  }

  //构建内容组件
  Widget buildContentWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.px,horizontal: 15.px),
      child: Column(
        children: [
          buildContentTelWidget(),
          SizedBox(height: 12.px),
          buildCodeWidget(),
          SizedBox(height: 24.px),
          NextButton(callback: () => Navigator.pushNamed(context, RegisterSecondPage.routeName))
        ],
      ),
    );
  }

  //构建手机号组件
  Widget buildContentTelWidget() {
    return Container(
      height: 44.px,
      // margin: EdgeInsets.symmetric(horizontal: 15.px),
      decoration: BoxDecoration(
        border: Border.all(color: ColorExtension.lineColor)
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildContentTelLeadingWidget(),
          Expanded(child: buildContentTelInputWidget())
        ],
      ),
    );
  }

  //构建手机号 - 前缀组件
  Widget buildContentTelLeadingWidget() {
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

  //构建手机号 - 输入组件
  Widget buildContentTelInputWidget() {
    return Padding(
      padding: EdgeInsets.only(left: 8.px),
      child: Input(
        placeholder: "请输入手机号",
        valueCallBack: (text){
          print("text == $text");
        },
      ),
    );
  }

  //构建验证码组件
  Widget buildCodeWidget() {
    return Column(
      children: [
        buildCodeTitleWidget(),
        buildCodeInputWidget()
      ],
    );
  }

  //构建验证码 - 标题组件
  Widget buildCodeTitleWidget() {
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

  //构建验证码 - 输入组件
  Widget buildCodeInputWidget() {
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
}
