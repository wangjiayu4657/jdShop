import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../pages/Category/models/product_detail_model.dart';

//商品详情 - 详情
class ProductDetailDetailPage extends StatefulWidget {
  const ProductDetailDetailPage({Key? key,this.model}) : super(key: key);

  final ProductDetailModel? model;

  @override
  State<ProductDetailDetailPage> createState() => _ProductDetailDetailPageState();
}

class _ProductDetailDetailPageState extends State<ProductDetailDetailPage> {

  @override
  Widget build(BuildContext context) {
    return const WebView(
      backgroundColor: Colors.green,
      initialUrl: "https://www.baidu.com",
    );
  }
}
