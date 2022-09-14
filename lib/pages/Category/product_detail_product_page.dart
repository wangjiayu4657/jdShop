import 'package:flutter/material.dart';

import '../../tools/extension/int_extension.dart';
import '../../pages/CustomWidgets/placeholder_image.dart';

//商品详情 - 商品
class ProductDetailProductPage extends StatelessWidget {
  const ProductDetailProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(8.px),
      child: Column(
        children: [
          buildProductPictureWidget(),
          buildProductDescWidget(context),
          buildProductPriceWidget(context),
          buildOtherListWidget(),
        ],
      ),
    );
  }

  //构建商品图片组件
  Widget buildProductPictureWidget() {
    return const AspectRatio(
      aspectRatio: 16/9,
      child: PlaceholderImage(
        url: "https://www.itying.com/images/flutter/p1.jpg",
        fit: BoxFit.contain
      ),
    );
  }

  //构建商品描述组件
  Widget buildProductDescWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.px,horizontal: 10.px),
      child: Column(
        children: [
          Text(
            "联想ThinkPad 翼480（0VCD） 英特尔酷睿i5 14英寸轻薄窄边框笔记本电脑",
            style: Theme.of(context).textTheme.headline2
          ),
          SizedBox(height: 10.px),
          Text(
            "震撼首发，15.9毫米全金属外观，4.9毫米轻薄窄边框，指纹电源按钮，杜比音效，2G独显，预装正版office软件",
            style: TextStyle(fontSize: 12.px,color: Colors.black45)
          ),
        ],
      ),
    );
  }

  //构建价格组件
  Widget buildProductPriceWidget(BuildContext context) {
    return Container(
      height: 40.px,
      margin: EdgeInsets.symmetric(vertical: 8.px,horizontal: 10.px),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildProductPriceSpecialOfferWidget(context),
          buildProductPriceOriginalPriceWidget(context)
        ],
      ),
    );
  }

  //构建价格-特价组件
  Widget buildProductPriceSpecialOfferWidget(BuildContext context) {
    return Row(
      children: [
        const Text("特价: "),
        Text("¥28",style: Theme.of(context).textTheme.headline2?.copyWith(color: Colors.redAccent))
      ],
    );
  }

  //构建价格-原价组件
  Widget buildProductPriceOriginalPriceWidget(BuildContext context) {
    return Row(
      children: [
        const Text("原价: "),
        Text("¥28",style: Theme.of(context).textTheme.headline2?.copyWith(
          decoration: TextDecoration.lineThrough
        ))
      ],
    );
  }

  //构建其他条目组件
  Widget buildOtherListWidget() {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        buildOtherListItemWidget("已选 : ", "115，黑色，XL，1件"),
        buildOtherListItemWidget("运费 : ", "免运费"),
      ],
    );
  }

  //构建其他条目子组件
  Widget buildOtherListItemWidget(String title,String text) {
    return Column(
      children: [
        ListTile(
          leading: Text(title,style: const TextStyle(color: Colors.black54,fontWeight: FontWeight.bold)),
          title: Text(text,style: const TextStyle(color: Colors.black54,fontWeight: FontWeight.normal),),
        ),
        const Divider(height: 1)
      ],
    );
  }
}
