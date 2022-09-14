import 'package:flutter/material.dart';

class ProductDetailProductPage extends StatelessWidget {
  const ProductDetailProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: ListView.builder(
        itemCount: 20,
        itemBuilder: (context,idx){
          return ListTile(title: Text("这是第$idx条"));
        },
      )
    );
  }
}
