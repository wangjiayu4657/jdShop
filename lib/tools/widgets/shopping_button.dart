import 'package:flutter/material.dart';

import '../../tools/extension/int_extension.dart';


class ShoppingButton extends StatelessWidget {
  const ShoppingButton({
    Key? key,
    required this.title,
    this.backgroundColor,
    this.onPressed
  }) : super(key: key);

  final String title;
  final Color? backgroundColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.px),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.resolveWith((states) {
            return Size(double.infinity, 36.px);
          }),
          backgroundColor: MaterialStateProperty.all(backgroundColor)
        ),
        child: Text(title,style: const TextStyle(color: Colors.white))
      ),
    );
  }
}
