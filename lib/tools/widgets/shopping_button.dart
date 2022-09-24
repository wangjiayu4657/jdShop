import 'package:flutter/material.dart';

import '../../tools/extension/int_extension.dart';


class ShoppingButton extends StatelessWidget {
  const ShoppingButton({
    Key? key,
    required this.title,
    this.width,
    this.height,
    this.fontSize,
    this.fontWeight,
    this.textColor,
    this.onPressed,
    this.backgroundColor,
  }) : super(key: key);

  final String title;
  final double? width;
  final double? height;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? textColor;
  final Color? backgroundColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 40.px,
      height: height ?? 34.px,
      margin: EdgeInsets.symmetric(horizontal: 15.px),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(backgroundColor),
          minimumSize: MaterialStateProperty.resolveWith((states) => Size(double.infinity, 36.px))
        ),
        child: Text(title,
          style: TextStyle(
            color: textColor,
            fontSize: fontSize,
            fontWeight: fontWeight
          )
        )
      ),
    );
  }
}
