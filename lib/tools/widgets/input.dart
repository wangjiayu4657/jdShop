import 'package:flutter/material.dart';

import '../../tools/widgets/code_button.dart';
import '../../../tools/extension/int_extension.dart';
import '../../../tools/extension/color_extension.dart';

typedef ValueCallBack<T> = void Function(T value);

enum BorderType {
  noBorder, //无边框
  outlineBorder, //四周都有边框
  underlineBorder //底部有边框
}

//输入框
class Input extends StatefulWidget {
  const Input({
    Key? key,
    this.leading,
    this.trailing,
    this.hintStyle,
    this.borderType = BorderType.noBorder,
    this.borderWidth = 1,
    Color? borderColor,
    this.placeholder,
    this.keyboardType,
    this.obscureText,
    this.isShowVerificationCode,
    this.contentPadding,
    this.valueCallBack,
    this.callback
  }) : borderColor = ColorExtension.lineColor,
       super(key: key);

  ///输入框前面的组件
  final Widget? leading;
  ///输入框末尾的组件
  final Widget? trailing;
  ///占位符字体样式
  final TextStyle? hintStyle;
  ///边框风格
  final BorderType? borderType;
  ///边框宽度
  final double? borderWidth;
  ///边框颜色
  final Color borderColor;
  ///输入文本是否为密码
  final bool? obscureText;
  ///占位符
  final String? placeholder;
  ///是否显示获取验证码按钮
  final bool? isShowVerificationCode;
  ///键盘样式
  final TextInputType? keyboardType;
  ///文本输入时的回调
  final ValueCallBack? valueCallBack;
  final EdgeInsets? contentPadding;
  ///获取验证码按钮点击回调
  final VoidCallback? callback;

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(textBaseline: TextBaseline.alphabetic),
      keyboardType: widget.keyboardType,
      obscureText: widget.obscureText ?? false,
      onChanged: widget.valueCallBack,
      cursorColor: Colors.black26,
      decoration: InputDecoration(
        hintText: widget.placeholder,
        hintStyle: widget.hintStyle ?? const TextStyle(color: Colors.black26),
        prefixIconColor: Colors.black54,
        focusColor: Colors.black54,
        prefixIcon: widget.leading,
        suffix: buildCodeButton(),
        prefixIconConstraints: BoxConstraints(minWidth: 34.px),
        border: buildBorder(),
        enabledBorder: buildBorder(),
        focusedBorder: buildBorder(),
        disabledBorder: buildBorder(),
        contentPadding: widget.contentPadding ?? EdgeInsets.zero
      ),
    );
  }

  ///构建边框
  InputBorder buildBorder() {
    if(widget.borderType == BorderType.noBorder){
      return buildOutlineBorder(0,Colors.transparent);
    } else if(widget.borderType == BorderType.outlineBorder){
      return buildOutlineBorder(widget.borderWidth ?? 1,widget.borderColor);
    } else {
      return buildUnderLineBorder(widget.borderWidth ?? 0.5,widget.borderColor);
    }
  }

  //构建四周边框
  OutlineInputBorder buildOutlineBorder(double width,Color color) {
    return OutlineInputBorder(borderSide: BorderSide(width: width,color: color));
  }

  //构建底部边框
  UnderlineInputBorder buildUnderLineBorder(double width,Color color) {
    return UnderlineInputBorder(borderSide: BorderSide(width: width, color: color));
  }

  //构建验证码按钮
  Widget buildCodeButton() {
    bool isShowCodeButton = widget.isShowVerificationCode ?? false;
    return isShowCodeButton ? widget.trailing ?? CodeButton(second: 5,callback: widget.callback) : const Text("");
  }
}
