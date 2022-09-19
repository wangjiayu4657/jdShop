import 'package:flutter/material.dart';

import '../../pages/CustomWidgets/placeholder_image.dart';
import '../../tools/extension/int_extension.dart';
import 'widgets/stepper.dart' as step;

class CartPage extends StatefulWidget {
  static const String routeName = "/cart";
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  late bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("购物车")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: buildListViewWidget()),
          buildBottomToolWidget()
        ],
      ),
    );
  }

  //购物车商品列表
  Widget buildListViewWidget() {
    return ListView.builder(
      padding: EdgeInsets.all(8.px),
      shrinkWrap: true,
      itemCount: 20,
      itemBuilder: (context,idx){
        return Column(
          children: [
            buildListViewItemWidget(),
            Divider(height: 1.px)
          ],
        );
      },
    );
  }

  //购物车商品列表 - item
  Widget buildListViewItemWidget() {
    return Row(
       children: [
         buildListViewItemCheckBoxWidget(),
         buildListViewItemPlaceholderImageWidget(),
         Expanded(child: buildListViewItemContentWidget())
       ],
    );
  }

  //购物车商品列表 - item - checkBox
  Widget buildListViewItemCheckBoxWidget() {
    return SizedBox(
      width: 30.px,
      child: Checkbox(
        value: _isChecked,
        onChanged: (val) => setState(() {
          _isChecked = val ?? false;
        })
      ),
    );
  }

  //购物车商品列表 - item - placeholderImage
  Widget buildListViewItemPlaceholderImageWidget() {
    return Container(
      width: 80.px,
      padding: EdgeInsets.all(10.px),
      child: const PlaceholderImage(url: "https://www.itying.com/images/flutter/list2.jpg"),
    );
  }

  //购物车商品列表 - item - 内容
  Widget buildListViewItemContentWidget() { 
    return Padding(
      padding: EdgeInsets.all(8.px),
      child: Column(
        children: [
          Text("菲特旋转盖轻量杯不锈钢保温杯学生杯商务杯情侣杯保冷杯子便携水杯LHC4131WB(450Ml)白蓝",style: TextStyle(fontSize: 12.px),),
          buildListViewItemContentPriceWidget()
        ],
      ),
    );
  }

  //购物车商品列表 - item - 内容 - 价格
  Widget buildListViewItemContentPriceWidget() { 
    return Padding(
      padding: EdgeInsets.fromLTRB(4.px, 15.px, 4.px, 2.px),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text("￥23"),
          step.Stepper()
        ],
      ),
    );
  }

  //购物车底部工具条
  Widget buildBottomToolWidget() {
    return Container(
      height: 48.px,
      color: Colors.black12,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildBottomToolAllSelectedButtonWidget(),
          buildBottomToolSettlementButtonWidget()
        ],
      ),
    );
  }

  //购物车底部工具条 - 全选按钮
  Widget buildBottomToolAllSelectedButtonWidget() {
    return Container(
      margin: EdgeInsets.all(4.px),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Checkbox(
            value: _isChecked,
            onChanged: (val) {
              setState(() => _isChecked = val ?? false);
            }
          ),
          const Text("全选")
        ],
      ),
    );
  }

  //购物车底部工具条 - 结算按钮
  Widget buildBottomToolSettlementButtonWidget() {
    return InkWell(
      onTap: (){
        debugPrint("结算");
      },
      child: Container(
        width: 96.px,
        height: 48.px,
        color: Colors.redAccent,
        alignment: Alignment.center,
        child: const Text("结算",style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
