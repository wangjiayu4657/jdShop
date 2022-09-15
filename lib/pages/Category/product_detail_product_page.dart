import 'package:flutter/material.dart';

import '../../tools/extension/int_extension.dart';
import '../../tools/extension/color_extension.dart';
import '../../pages/CustomWidgets/placeholder_image.dart';
import '../../tools/widgets/shopping_button.dart';
import '../../pages/Category/models/product_detail_model.dart';


//商品详情 - 商品
class ProductDetailProductPage extends StatefulWidget {
  const ProductDetailProductPage({Key? key, this.model}) : super(key: key);

  final ProductDetailModel? model;

  @override
  State<ProductDetailProductPage> createState() => _ProductDetailProductPageState();
}

class _ProductDetailProductPageState extends State<ProductDetailProductPage> {

  //展示底部条件筛选组件
  void showFilterSheetWidget() {
    showBottomSheet(
      context: context,
      builder: (context) => buildFilterSheetWidget()
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(8.px),
      child: Column(
        children: [
          buildProductPictureWidget(),
          buildProductDescWidget(),
          buildProductPriceWidget(),
          buildOtherListWidget(),
        ],
      ),
    );
  }

  //构建商品图片组件
  Widget buildProductPictureWidget() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: PlaceholderImage(
        url: widget.model?.imgUrl,
        fit: BoxFit.contain
      ),
    );
  }

  //构建商品描述组件
  Widget buildProductDescWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.px,horizontal: 10.px),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.model?.title ?? "", style: Theme.of(context).textTheme.headline2),
          SizedBox(height: 10.px),
          Text(widget.model?.subTitle ?? "", style: TextStyle(fontSize: 12.px,color: Colors.black45)),
        ],
      ),
    );
  }

  //构建价格组件
  Widget buildProductPriceWidget() {
    return Container(
      height: 40.px,
      margin: EdgeInsets.symmetric(vertical: 8.px,horizontal: 10.px),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildProductPriceSpecialOfferWidget(),
          buildProductPriceOriginalPriceWidget()
        ],
      ),
    );
  }

  //构建价格-特价组件
  Widget buildProductPriceSpecialOfferWidget() {
    return Row(
      children: [
        const Text("特价: "),
        Text("¥${widget.model?.price ?? ""}",style: Theme.of(context).textTheme.headline2?.copyWith(color: Colors.redAccent))
      ],
    );
  }

  //构建价格-原价组件
  Widget buildProductPriceOriginalPriceWidget() {
    return Row(
      children: [
        const Text("原价: "),
        Text("¥${widget.model?.oldPrice ?? ""}",style: Theme.of(context).textTheme.headline2?.copyWith(
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
          onTap: showFilterSheetWidget,
          leading: Text(title,style: const TextStyle(color: Colors.black54,fontWeight: FontWeight.bold)),
          title: Text(text,style: const TextStyle(color: Colors.black54,fontWeight: FontWeight.normal),),
        ),
        const Divider(height: 1)
      ],
    );
  }

  //构建底部筛选条件组件
  Widget buildFilterSheetWidget() {
    return InkWell(
      onTap: (){
        Navigator.of(context).pop();
      },
      child: Container(
        color: Colors.black12,
        alignment: Alignment.bottomCenter,
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 20.px),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    buildFilterSheetColorWidget(),
                    buildFilterSheetSizeWidget(),
                    SizedBox(height: 100.px),
                    buildFilterSheetButtonWidget()
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //构建底部筛选条件-标题组件
  Widget buildFilterSheetTitleWidget(String title) {
    return Container(
      width: 80.px,
      padding: EdgeInsets.symmetric(vertical: 8.px),
      alignment: Alignment.center,
      child: Text(title,style: Theme.of(context).textTheme.bodyText1),
    );
  }

  //构建底部筛选条件-颜色组件
  Widget buildFilterSheetColorWidget() {
    const List<String> colors = ["红色","黄色","蓝色","绿色","粉色","灰色"];
    return buildFilterSheetItemsWidget("颜色 : ",colors);
  }

  //构建底部筛选条件-尺寸组件
  Widget buildFilterSheetSizeWidget() {
    const List<String> sizes = ["ML","L","XL","XXL"];
    return buildFilterSheetItemsWidget("尺寸 : ",sizes);
  }

  //构建底部筛选条件-条件组件
  Widget buildFilterSheetItemsWidget(String title,List<String> items) {
    return Wrap(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildFilterSheetTitleWidget(title),
            Expanded(
              child: Wrap(
                spacing: 10.px,
                children: items.map((text) => buildFilterSheetItemWidget(text)).toList()
              ),
            )
          ],
        )
      ],
    );
  }


  //构建底部筛选条件-条件子(item)组件
  Widget buildFilterSheetItemWidget(String text) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: (){
        debugPrint(text);
        Navigator.pop(context);
      },
      child: Chip(
        backgroundColor: ColorExtension.bgColor,
        padding: EdgeInsets.symmetric(horizontal: 8.px),
        visualDensity: VisualDensity(vertical: -1.px),
        label: Text(text),
        labelStyle: TextStyle(color: Colors.black54,fontSize: 12.px,fontWeight: FontWeight.normal),
      ),
    );
  }

  //构建底部筛选条件-按钮组件
  Widget buildFilterSheetButtonWidget() {
    return Container(
      padding: EdgeInsets.all(10.px),
      // color: Colors.green,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ShoppingButton(
              title: "加入购物车",
              backgroundColor: Colors.redAccent,
              onPressed: (){
                debugPrint("加入购物车");
              }
            ),
          ),
          Expanded(
            child: ShoppingButton(
              title: "立即购买",
              backgroundColor: Colors.orange,
              onPressed: (){
                debugPrint("立即购买");
              }
            ),
          )
        ],
      ),
    );
  }
}
