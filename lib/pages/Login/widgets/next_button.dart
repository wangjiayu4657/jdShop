import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../tools/extension/int_extension.dart';
import '../../../tools/extension/color_extension.dart';
import '../../../tools/widgets/normal_button.dart';

class NextButton extends StatefulWidget {
  const NextButton({
    Key? key,
    this.title,
    this.height,
    this.textStyle,
    this.backgroundColor,
    this.callback,
  }) : super(key: key);

  final String? title;
  final double? height;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final VoidCallback? callback;

  @override
  State<NextButton> createState() => _NextButtonState();
}

class _NextButtonState extends State<NextButton> {
  final TapGestureRecognizer _tapGestureRecognizer = TapGestureRecognizer();

  void _contactCustomerService() {
    print("联系客服");
  }

  @override
  void initState() {
    super.initState();
    _tapGestureRecognizer.onTap = _contactCustomerService;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        NormalButton(
          title: widget.title ?? "下一步",
          height: widget.height,
          backgroundColor: widget.backgroundColor ?? ColorExtension.bgColor,
          style: widget.textStyle ?? const TextStyle(color: Colors.black45,fontWeight: FontWeight.bold),
          callback: widget.callback,
        ),
        SizedBox(height: 10.px),
        Text.rich(
          TextSpan(children: [
            const TextSpan(text: "遇到问题?您可以",style: TextStyle(color: Colors.black26)),
            TextSpan(
              text: "联系客服",
              recognizer: _tapGestureRecognizer,
              style:const TextStyle(
                color: Colors.black45,
                decoration: TextDecoration.underline
              )
            )
          ])
        )
      ],
    );
  }
}
