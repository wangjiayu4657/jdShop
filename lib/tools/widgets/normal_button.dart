import 'package:flutter/material.dart';
import 'package:jdShop/tools/extension/int_extension.dart';

class NormalButton extends StatelessWidget {
  const NormalButton({
    Key? key,
    this.title,
    this.width,
    this.height,
    this.style,
    this.textColor = Colors.white,
    this.backgroundColor,
    this.onPressed
  }) : super(key: key);

  final String? title;
  final double? width;
  final double? height;
  final TextStyle? style;
  final Color? textColor;
  final Color? backgroundColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: width ?? double.infinity,
        height: height ?? 44.px,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8.px),
        ),
        child: Text(title ?? "",style: style ?? TextStyle(color: textColor)),
      ),
    );
  }
}
