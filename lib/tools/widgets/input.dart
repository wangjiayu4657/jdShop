import 'package:flutter/material.dart';

import '../../tools/widgets/code_button.dart';
import '../../../tools/extension/int_extension.dart';

typedef ValueCallBack<T> = void Function(T value);

//输入框
class Input extends StatefulWidget {
  const Input({
    Key? key,
    this.leading,
    this.trailing,
    this.placeholder,
    this.keyboardType,
    this.obscureText,
    Color? enabledColor,
    Color? focusedColor,
    this.isShowVerificationCode,
    this.valueCallBack,
    this.callback
  }) : enabledColor = enabledColor ?? Colors.black12,
       focusedColor = focusedColor ?? Colors.black12,
        super(key: key);

  ///输入框前面的组件
  final Widget? leading;
  ///输入框末尾的组件
  final Widget? trailing;
  ///输入文本是否为密码
  final bool? obscureText;
  ///占位符
  final String? placeholder;
  ///默认下边框颜色
  final Color enabledColor;
  ///聚焦时的边框颜色
  final Color focusedColor;
  ///是否显示获取验证码按钮
  final bool? isShowVerificationCode;
  ///键盘样式
  final TextInputType? keyboardType;
  ///文本输入时的回调
  final ValueCallBack? valueCallBack;
  ///获取验证码按钮点击回调
  final VoidCallback? callback;

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.px,vertical: 4.px),
      child: TextField(
        keyboardType: widget.keyboardType,
        obscureText: widget.obscureText ?? false,
        onChanged: widget.valueCallBack,
        cursorColor: Colors.black26,
        decoration: InputDecoration(
          hintText: widget.placeholder,
          hintStyle: const TextStyle(color: Colors.black26),
          prefixIconColor: Colors.black54,
          focusColor: Colors.black54,
          prefixIcon: widget.leading,
          suffix: buildCodeButton(),
          prefixIconConstraints: BoxConstraints(minWidth: 34.px),
          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(width: 0.5, color: widget.enabledColor)),
          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(width: 0.5, color: widget.focusedColor)),
        ),
      ),
    );
  }

  //构建验证码按钮
  Widget buildCodeButton() {
    bool isShowCodeButton = widget.isShowVerificationCode ?? false;
    return isShowCodeButton ? widget.trailing ?? CodeButton(second: 5,callback: widget.callback) : const Text("");
  }
}
