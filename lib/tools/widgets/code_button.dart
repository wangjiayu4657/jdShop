import 'dart:async';
import 'package:flutter/material.dart';

import '../../tools/extension/int_extension.dart';
import '../../tools/extension/color_extension.dart';

//倒计时按钮
class CodeButton extends StatefulWidget {
  const CodeButton({
    Key? key,
    int? second,
    this.height,
    String? startTitle,
    String? endTitle,
    this.callback
  }) : second = second ?? 59,
       startTitle = startTitle ?? "获取验证码",
       endTitle = endTitle ?? "重新获取",
       super(key: key);

  ///倒计时的秒数
  final int second;
  final double? height;
  ///起始时的标题
  final String startTitle;
  ///倒计时结束时的标题
  final String endTitle;
  ///回调
  final VoidCallback? callback;

  @override
  State<CodeButton> createState() => _CodeButtonState();
}

class _CodeButtonState extends State<CodeButton> {
  bool _isEnable = true;
  late int second = widget.second;
  late String codeTitle = widget.startTitle;

  void initTimer() {
    _isEnable = false;
    setState(() {
      codeTitle = "剩余时间: $second s";
    });
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        second -= 1;
        codeTitle = "剩余时间: $second s";
        if (second == 0) {
          timer.cancel();
          second = widget.second;
          codeTitle = widget.endTitle;
          _isEnable = true;
        }
      });
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height ?? 34.px,
      decoration: BoxDecoration(
        color: ColorExtension.bgColor,
        borderRadius: BorderRadius.circular(4.px)
      ),
      child: TextButton(
        onPressed: _isEnable ? (){
          initTimer();
          if(widget.callback != null) widget.callback!();
        } : null,
        child: Text(codeTitle,style: TextStyle(color: Colors.black26,fontSize: 14.px))
      ),
    );
  }
}
