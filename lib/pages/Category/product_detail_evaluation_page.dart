import 'package:flutter/material.dart';

import 'models/product_detail_model.dart';

//商品详情 - 评价
class ProductDetailEvaluationPage extends StatefulWidget {
  const ProductDetailEvaluationPage({Key? key,this.model}) : super(key: key);

  final ProductDetailModel? model;
  @override
  State<ProductDetailEvaluationPage> createState() => _ProductDetailEvaluationPageState();
}

class _ProductDetailEvaluationPageState extends State<ProductDetailEvaluationPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: const Center(child: Text("评价"),),
    );
  }
}
