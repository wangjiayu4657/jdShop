import 'package:flutter/material.dart';
import 'package:jdShop/tools/extension/int_extension.dart';

class NormalButton extends StatelessWidget {
  const NormalButton({
    Key? key,
    this.title,
    this.width,
    this.height,
    this.style,
    this.backgroundColor,
    this.callback
  }) : super(key: key);

  final String? title;
  final double? width;
  final double? height;
  final TextStyle? style;
  final Color? backgroundColor;
  final VoidCallback? callback;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height ?? 44.px,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8.px),
      ),
      child: InkWell(
        onTap: callback,
        child: Text(title ?? "",style: style),
      ),
    );
  }
}
