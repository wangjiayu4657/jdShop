import 'package:flutter/material.dart';
import 'package:jdShop/tools/share/const_config.dart';

import '../../tools/widgets/normal_button.dart';
import '../../tools/extension/int_extension.dart';
import '../../tools/extension/color_extension.dart';
import '../../pages/CustomWidgets/placeholder_image.dart';

//订单结算页
class SettlementPage extends StatefulWidget {
  static const String routeName = "/settlement";
  const SettlementPage({Key? key}) : super(key: key);

  @override
  State<SettlementPage> createState() => _SettlementPageState();
}

class _SettlementPageState extends State<SettlementPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("订单页面")),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10.px),
        color: ColorExtension.bgColor,
        child: buildContentWidget(),
      ),
    );
  }

  Widget buildContentWidget() {
    return Column(
      children: [
        Expanded(child: buildListViewWidget()),
        SizedBox(height: 10.px),
        buildBottomToolWidget()
      ],
    );
  }

  Widget buildListViewWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildListViewHeaderWidget(),
        SizedBox(height: 10.px),
        Expanded(child: buildListViewContentWidget()),
        buildListViewFooterWidget()
      ],
    );
  }

  Widget buildListViewHeaderWidget(){
    return Container(
      height: 48.px,
      color: Colors.white,
      child: ListTile(
        leading: const Icon(Icons.location_on),
        title: const Text("请添加您的收货地址"),
        trailing: Icon(Icons.arrow_forward_ios,size: 16.px),
        minLeadingWidth: 8.px,
        visualDensity: const VisualDensity(horizontal: -4),
      ),
    );
  }
  
  Widget buildListViewContentWidget() { 
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (context,idx){
        return buildListViewContentItemWidget();
      },
    );
  }

  Widget buildListViewContentItemWidget() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 15.px),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: 8.px),
          Row(
            children: [
              buildListViewContentItemImageWidget(),
              SizedBox(width: 10.px),
              Expanded(child: buildListViewContentItemContentWidget()),
            ],
          ),
          SizedBox(height: 8.px),
          const Divider(height: 1)
        ],
      ),
    );
  }

  Widget buildListViewContentItemImageWidget() {
    return Container(
      width: 64.px,
      height: 80.px,
      padding: EdgeInsets.symmetric(vertical: 8.px),
      child: const PlaceholderImage(url: "https://jdmall.itying.com/public/upload/dTGwzmlZEDu7dHpTjnMuaEPf.png"),
    );
  }

  Widget buildListViewContentItemContentWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("flutter仿京东商城项目实战练习"),
        SizedBox(height: 4.px),
        const Text("白色,系带"),
        SizedBox(height: 4.px),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:const [
            Text("￥100",style: TextStyle(color: Colors.redAccent)),
            Text("x1")
          ],
        )
      ],
    );
  }

  Widget buildListViewFooterWidget(){
    return Container(
      height: 105.px,
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(15.px, 15.px, 15.px, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("商品总金额: ￥180元"),
          SizedBox(height: 10.px),
          const Text("立减: ￥10元"),
          SizedBox(height: 10.px),
          const Text("运费: ￥18元")
        ],
      ),
    );
  }

  //构建底部工具组件
  Widget buildBottomToolWidget() {
    return Container(
      height: 64.px,
      padding: EdgeInsets.symmetric(horizontal: 15.px),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: ColorExtension.lineColor))
      ),
      child: Row(
        children: [
          Expanded(child: buildTotalPriceWidget("128元")),
          NormalButton(
            width: 100.px,
            height: 34.px,
            title: "立即下单",
            backgroundColor: Colors.redAccent
          )
        ],
      ),
    );
  }

  Widget buildTotalPriceWidget(String price) {
    return Row(
      children: [
        const Text("实付款: "),
        Text("￥$price",style: TextStyle(color: Colors.redAccent,fontSize: 18.px))
      ],
    );
  }
}
