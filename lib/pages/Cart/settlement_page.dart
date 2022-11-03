import 'package:flutter/material.dart';

import '../../tools/widgets/normal_button.dart';
import '../../tools/extension/object_extension.dart';
import '../../tools/extension/int_extension.dart';
import '../../tools/extension/color_extension.dart';
import '../../pages/Cart/address_list_page.dart';
import '../../pages/Cart/address_add_page.dart';
import '../../pages/Cart/models/address_model.dart';
import '../../pages/CustomWidgets/placeholder_image.dart';
import '../../pages/Cart/view_models/address_view_model.dart';
import '../Category/models/product_detail_model.dart';

//订单结算页
class SettlementPage extends StatefulWidget {
  static const String routeName = "/settlement";
  const SettlementPage({Key? key,this.arguments}) : super(key: key);

  final Map<String,dynamic>? arguments;

  @override
  State<SettlementPage> createState() => _SettlementPageState();
}

class _SettlementPageState extends State<SettlementPage> {

  late String totalPrice = "0";
  late AddressModel model = AddressModel();
  late List<ProductDetailModel> products = [];

  @override
  void initState() {
    super.initState();

    products = widget.arguments?["products"] ?? [];
    var total = products.fold<double>(0, (previousValue, element) => previousValue + mapToDouble(element.price) * element.count);
    totalPrice = "$total";

    defaultAddress();
  }

  //获取默认地址
  void defaultAddress() async{
    model = await AddressViewModel.defaultModel;
    setState(() { });
  }

  //跳转目标页
  void gotoTargetWidget() {
    String routeName = model.address == null ? AddressAddPage.routeName : AddressListPage.routeName;
    //返回时刷新地址
    Navigator.pushNamed(context, routeName).then(refreshAddress);
  }

  //刷新地址
  void refreshAddress(value) {
    if(value == null){
      defaultAddress();
    } else {
      setState(() {
        model = value as AddressModel;
        AddressViewModel.changeDefaultState(model);
      });
    }
  }

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
        title: Text(model.address ?? "请添加您的收货地址"),
        trailing: Icon(Icons.arrow_forward_ios,size: 16.px),
        minLeadingWidth: 8.px,
        visualDensity: const VisualDensity(horizontal: -4),
        contentPadding: EdgeInsets.symmetric(horizontal:12.px),
        onTap: gotoTargetWidget,
      ),
    );
  }
  
  Widget buildListViewContentWidget() { 
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context,idx){
        return buildListViewContentItemWidget(products[idx]);
      },
    );
  }

  Widget buildListViewContentItemWidget(ProductDetailModel model) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 15.px),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: 8.px),
          Row(
            children: [
              buildListViewContentItemImageWidget(model),
              SizedBox(width: 10.px),
              Expanded(child: buildListViewContentItemContentWidget(model)),
            ],
          ),
          SizedBox(height: 8.px),
          const Divider(height: 1)
        ],
      ),
    );
  }

  Widget buildListViewContentItemImageWidget(ProductDetailModel model) {
    return Container(
      width: 64.px,
      height: 80.px,
      padding: EdgeInsets.symmetric(vertical: 8.px),
      child: PlaceholderImage(url: model.imgUrl),
    );
  }

  Widget buildListViewContentItemContentWidget(ProductDetailModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(model.title ?? ""),
        SizedBox(height: 4.px),
        Text(model.filter),
        SizedBox(height: 4.px),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:[
            Text("${model.price}",style: const TextStyle(color: Colors.redAccent)),
            Text("x ${model.count}")
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
          Text("商品总金额: ￥$totalPrice元"),
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
    double orderPrice = mapToDouble(totalPrice) - 10 + 18;
    return Container(
      height: 64.px,
      padding: EdgeInsets.symmetric(horizontal: 15.px),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: ColorExtension.lineColor))
      ),
      child: Row(
        children: [
          Expanded(child: buildTotalPriceWidget("$orderPrice元")),
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
