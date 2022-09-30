import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../tools/extension/int_extension.dart';
import '../../tools/extension/object_extension.dart';
import '../../pages/Cart/settlement_page.dart';
import '../../pages/CustomWidgets/placeholder_image.dart';
import '../../pages/Category/models/product_detail_model.dart';
import 'widgets/stepper.dart' as step;
import 'view_models/cart_view_model.dart';

class CartPage extends StatefulWidget {
  static const String routeName = "/cart";
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  late bool _isEditing = false;
  final CartViewModel _viewModel = CartViewModel();

  //删除
  void deleteProduct() {
    _viewModel.deleteProduct();
    showToast("删除成功");
  }

  //结算
  void settlement() {
    debugPrint("结算");
    Navigator.pushNamed(context, SettlementPage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _viewModel,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("购物车"),
          actions: [
            TextButton(
              onPressed: (){
                setState(() => _isEditing = !_isEditing);
              },
              child: Text(_isEditing ? "完成" : "编辑",style: const TextStyle(color: Colors.white)))
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: buildListViewWidget()),
            SafeArea(child: buildBottomToolWidget())
          ],
        ),
      ),
    );
  }

  //购物车商品列表
  Widget buildListViewWidget() {
    return Consumer<CartViewModel>(
      builder: (context,viewModel,child){
        return ListView.builder(
          padding: EdgeInsets.all(8.px),
          shrinkWrap: true,
          itemCount: viewModel.products.length,
          itemBuilder: (context,idx){
            return Column(
              children: [
                buildListViewItemWidget(viewModel.products[idx]),
                Divider(height: 1.px)
              ],
            );
          },
        );
      },
    );
  }

  //购物车商品列表 - item
  Widget buildListViewItemWidget(ProductDetailModel model) {
    return Row(
       children: [
         buildListViewItemCheckBoxWidget(model),
         buildListViewItemPlaceholderImageWidget(model),
         Expanded(child: buildListViewItemContentWidget(model))
       ],
    );
  }

  //购物车商品列表 - item - checkBox
  Widget buildListViewItemCheckBoxWidget(ProductDetailModel model) {
    return SizedBox(
      width: 30.px,
      child: Checkbox(
        value: model.isChecked,
        onChanged: (val) {
          model.isChecked = val ?? false;
          _viewModel.selectedProduct();
        }
      ),
    );
  }

  //购物车商品列表 - item - placeholderImage
  Widget buildListViewItemPlaceholderImageWidget(ProductDetailModel model) {
    return Container(
      width: 80.px,
      padding: EdgeInsets.all(10.px),
      child: PlaceholderImage(url: model.imgUrl),
    );
  }

  //购物车商品列表 - item - 内容
  Widget buildListViewItemContentWidget(ProductDetailModel model) {
    String productTitle = "${model.title}   ${model.filter}";
    return Padding(
      padding: EdgeInsets.all(8.px),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(productTitle, style: TextStyle(fontSize: 12.px)),
          buildListViewItemContentPriceWidget(model)
        ],
      ),
    );
  }

  //购物车商品列表 - item - 内容 - 价格
  Widget buildListViewItemContentPriceWidget(ProductDetailModel model) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 15.px, 4.px, 2.px),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("￥${model.price}",style: TextStyle(color: Colors.redAccent,fontSize: 18.px)),
          step.Stepper(value: model.count,callBack: (val) => _viewModel.changeProductCount(val, model))
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
          Consumer<CartViewModel>(
            builder: (context,viewModel,child){
              return Checkbox(
                value: viewModel.isAllChecked,
                onChanged: (val) {
                  viewModel.isAllChecked = val ?? false;
                  viewModel.allSelected(val ?? false);
                }
              );
            },
          ),
          const Text("全选"),
          SizedBox(width: 15.px),
          _isEditing ? const Text("") : buildBottomToolTotalPriceWidget()
        ],
      ),
    );
  }

  //购物车底部工具条 - 全选按钮
  Widget buildBottomToolTotalPriceWidget() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text("总计: "),
        Consumer<CartViewModel>(
          builder: (context,viewModel,child){
            return Text("￥${viewModel.totalPrice}",style: TextStyle(fontSize: 20.px,color: Colors.redAccent));
          }
        )
      ],
    );
  }

  //购物车底部工具条 - 结算按钮
  Widget buildBottomToolSettlementButtonWidget() {
    return InkWell(
      onTap: _isEditing ? deleteProduct : settlement,
      child: Container(
        width: 96.px,
        height: 48.px,
        color: Colors.redAccent,
        alignment: Alignment.center,
        child: Text(_isEditing ? "删除" : "结算",style: const TextStyle(color: Colors.white)),
      ),
    );
  }
}
