import 'package:flutter/material.dart';
import 'package:jdShop/pages/Other/search_page.dart';
import 'package:provider/provider.dart';

import '../../tools/share/const_config.dart';
import '../../tools/extension/int_extension.dart';
import '../../tools/extension/color_extension.dart';
import '../../pages/Category/product_detail_detail_page.dart';
import '../../pages/Category/product_detail_product_page.dart';
import '../../pages/Category/product_detail_evaluation_page.dart';
import '../../tools/widgets/shopping_button.dart';
import '../../pages/Category/view_models/product_detail_view_model.dart';

class ProductDetailPage extends StatefulWidget {
  static const String routeName = "/productDetail";
  const ProductDetailPage({Key? key,this.id}) : super(key: key);

  final String? id;

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {

  late final ProductDetailViewModel _viewModel = ProductDetailViewModel(id: widget.id);

  //展示下拉菜单
  void showMenuWidget() {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(width - 70.px, 82.px, 10.px, 0),
      items: popupMenuItems()
    );
  }

  //选中下拉菜单
  void menuItemSelected(int index){
    debugPrint("index === $index");
    if(index == 1){
      Future(() => Navigator.pushNamed(context, SearchPage.routeName));
    }
  }

  @override
  void initState() {
    super.initState();
    _viewModel.detailDataRequest();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: ChangeNotifierProvider<ProductDetailViewModel>(
        create: (context) => _viewModel,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: const Text("商品详情"),
            bottom: tabBarWidget(),
            actions: [
              IconButton(
                onPressed: showMenuWidget,
                icon: const Icon(Icons.more_horiz))
            ],
          ),
          body: Column(
            children: [
              Expanded(child: tabBarViewWidget()),
              bottomToolWidget()
            ],
          ),
        ),
      ),
    );
  }

  //导航栏底部的二级菜单
  PreferredSizeWidget tabBarWidget() {
    const List<String> tabs = ["商品","详情","评价"];

    return PreferredSize(
      preferredSize: Size.fromHeight(34.px),
      child: Material(
        elevation: 0,
        color: Colors.white,
        child: TabBar(
          labelColor: Colors.redAccent,
          unselectedLabelColor: Colors.black45,
          indicatorSize: TabBarIndicatorSize.label,
          tabs: tabs.map((text) {
            return Tab(child: Text(text,style: TextStyle(fontSize: 14.px)));
          }).toList(),
        ),
      ),
    );
  }

  //导航栏内容
  Widget tabBarViewWidget() {
    return Consumer<ProductDetailViewModel>(
      builder: (context,viewModel,child){
        return TabBarView(
          children: [
            ProductDetailProductPage(viewModel:viewModel),
            ProductDetailDetailPage(model: viewModel.model),
            ProductDetailEvaluationPage(model:viewModel.model)
          ],
        );
      },
    );
  }

  //下拉菜单item
  List<PopupMenuEntry> popupMenuItems() {
    const List<String> itemNames = ["首页","搜索"];
    const List<IconData> itemIcons = [Icons.home,Icons.search];

    return List.generate(itemNames.length, (index) {
      return PopupMenuItem(
        onTap: () => menuItemSelected(index),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(itemIcons[index]),
            Text(itemNames[index])
          ],
        )
      );
    });
  }

  Widget bottomToolWidget() {
    return Container(
      height: 80.px,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: ColorExtension.lineColor))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          shoppingCartWidget(),
          Expanded(
            child: ShoppingButton(
              title: "加入购物车",
              backgroundColor: Colors.redAccent,
              onPressed: (){
                debugPrint("加入购物车");
              }
            )
          ),
          Expanded(
            child: ShoppingButton(
              title: "立即购买",
              backgroundColor: Colors.orange,
              onPressed: (){
                debugPrint("立即购买");
              }
            )
          )
        ],
      ),
    );
  }

  //购物车
  Widget shoppingCartWidget() {
    return InkWell(
      onTap: () => debugPrint("加入购物车"),
      child: Container(
        width: 80.px,
        padding: EdgeInsets.symmetric(vertical: 10.px,horizontal: 10.px),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.shopping_cart),
            Text("购物车")
          ],
        ),
      ),
    );
  }
}
