import 'package:flutter/material.dart';
import 'package:jdShop/tools/extension/double_extension.dart';

import '../../../tools/extension/int_extension.dart';
import '../../../tools/extension/color_extension.dart';
import '../../../tools/extension/string_extension.dart';

class Stepper extends StatefulWidget {
  const Stepper({Key? key}) : super(key: key);

  @override
  State<Stepper> createState() => _StepperState();
}

class _StepperState extends State<Stepper> {
  late int _count = 1;
  late double _textWidth = 40.px;
  late final TextEditingController _controller = TextEditingController(text: "1");

  //收起键盘
  void hideKeyBoard() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  //点击`-`安妞
  void minusButtonClick() {
    setState(() {
      _count -= 1;
      _count = _count < 0 ? 0 : _count;
      _controller.text = "$_count";
      hideKeyBoard();
    });
  }

  //点击`+`按钮
  void plusButtonClick() {
    setState(() {
      _count += 1;
      _controller.text = "$_count";
      hideKeyBoard();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 34.px,
      decoration: BoxDecoration(
        border: Border.all(color: ColorExtension.lineColor)
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildStepButton("-", minusButtonClick),
          buildStepInputWidget(),
          buildStepButton("+", plusButtonClick),
        ],
      ),
    );
  }

  Widget buildStepButton(String title,VoidCallback? onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 24.px,
        height: 24.px,
        alignment: Alignment.center,
        padding: EdgeInsets.only(bottom: 2.px),
        margin: EdgeInsets.symmetric(vertical: 4.px,horizontal: 8.px),
        child: Text(title,style: TextStyle(fontSize: 18.px)),
      ),
    );
  }

  Widget buildStepInputWidget() {
    return Container(
      width: _textWidth > 40.px ? _textWidth.px : 40.px,
      constraints: BoxConstraints(
        maxWidth: 80.px
      ),
      padding: EdgeInsets.fromLTRB(10.px, 4.px, 8.px, 4.px),
      decoration: const BoxDecoration(
        border: Border(
          left: BorderSide(color: ColorExtension.lineColor),
          right: BorderSide(color: ColorExtension.lineColor),
        )
      ),
      child: TextField(
        controller: _controller,
        keyboardType: const TextInputType.numberWithOptions(),
        textAlign: TextAlign.center,
        onChanged: (val){
          // val = val.length > 8 ? val.substring(0,8) : val;
          setState(() {
            _count = int.parse(val);
            _textWidth = val.calculateWidth(context: context).px + 16.px;
          });
        },
        decoration: const InputDecoration(
          border: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
          disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
          contentPadding: EdgeInsets.symmetric(vertical: 0),
        ),
      ),
    );
  }
}
