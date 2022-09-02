import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  static const String routeName = "/cart";
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("购物车")),
      body: const Center(
        child: Text("购物车界面"),
      ),
    );
  }
}
