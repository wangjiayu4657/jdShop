import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../tools/extension/int_extension.dart';
import '../../pages/CustomWidgets/placeholder_image.dart';
import '../../tools/widgets/shopping_button.dart';
import '../../pages/Category/models/product_detail_model.dart';
import '../../pages/Category/view_models/product_detail_view_model.dart';
import '../../tools/event_bus/cart_event_bus.dart';
import '../../pages/Cart/widgets/stepper.dart' as step;
import '../Cart/view_models/cart_services.dart';


//商品详情 - 商品
class ProductDetailProductPage extends StatefulWidget {
  const ProductDetailProductPage({Key? key, required this.viewModel}) : super(key: key);

  final ProductDetailViewModel viewModel;

  @override
  State<ProductDetailProductPage> createState() => _ProductDetailProductPageState();
}

class _ProductDetailProductPageState extends State<ProductDetailProductPage> with AutomaticKeepAliveClientMixin {

  late StreamSubscription _sheetSubscription;  //event_bus

  //展示底部条件筛选组件
  void showFilterSheetWidget() {
    showBottomSheet(
      context: context,
      builder: (ctx) => buildFilterSheetWidget()
    );
  }

  //获取加入购物车时的数量
  void valueChange(int count){
    debugPrint("count == $count");
    widget.viewModel.model?.count = count;
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    _sheetSubscription = eventBus.on<CartEventBus>().listen((event) {
      showFilterSheetWidget();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _sheetSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
        url: widget.viewModel.model?.imgUrl,
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
          Text(widget.viewModel.model?.title ?? "", style: Theme.of(context).textTheme.headline2),
          SizedBox(height: 10.px),
          Text(widget.viewModel.model?.subTitle ?? "", style: TextStyle(fontSize: 12.px,color: Colors.black45)),
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
        Text("¥${widget.viewModel.model?.price ?? ""}",style: Theme.of(context).textTheme.headline2?.copyWith(color: Colors.redAccent))
      ],
    );
  }

  //构建价格-原价组件
  Widget buildProductPriceOriginalPriceWidget() {
    return Row(
      children: [
        const Text("原价: "),
        Text("¥${widget.viewModel.model?.oldPrice ?? ""}",style: Theme.of(context).textTheme.headline2?.copyWith(
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
        buildSelectedItemWidget(),
        buildFreightItemWidget(),
      ],
    );
  }

  //构建展示已筛选条件组件
  Widget buildSelectedItemWidget() {
    return Column(
      children: [
        ListTile(
          onTap:() => showFilterSheetWidget(),
          leading: const Text("已选: ",style: TextStyle(color: Colors.black54,fontWeight: FontWeight.bold)),
          title: Consumer<ProductDetailViewModel>(
            builder: (context,viewModel,child){
              return Text(
                viewModel.filterItem,
                style: const TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.normal
                )
              );
            },
          ),
        ),
        const Divider(height: 1)
      ],
    );
  }

  //构建运费组件
  Widget buildFreightItemWidget() {
    return Column(
      children: const [
        ListTile(
          // onTap: showFilterSheetWidget,
          leading: Text("运费: ",style: TextStyle(color: Colors.black54,fontWeight: FontWeight.bold)),
          title: Text("免运费",style: TextStyle(color: Colors.black54,fontWeight: FontWeight.normal),),
        ),
        Divider(height: 1)
      ],
    );
  }

  //构建底部筛选条件组件
  Widget buildFilterSheetWidget() {
    return InkWell(
      onTap: () => Navigator.of(context).pop(),
      child: Container(
        color: Colors.black26,
        alignment: Alignment.bottomCenter,
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 20.px),
          child: SingleChildScrollView(
            child: Column(
              children: [
                buildFilterSheetContentWidget(),
                buildStepperWidget(),
                SizedBox(height: 50.px),
                buildFilterSheetButtonWidget()
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
      child: Text(title,textAlign: TextAlign.start,style: Theme.of(context).textTheme.bodyText1),
    );
  }

  //构建底部筛选条件内容组件
  Widget buildFilterSheetContentWidget() {
    List<FilterModel> items = widget.viewModel.model?.filters ?? [];
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: items.map((model) => buildFilterSheetItemsWidget(model.cate, model.items)).toList(),
    );
  }

  //构建底部筛选条件-条件组件
  Widget buildFilterSheetItemsWidget(String? title,List<FilterItemModel>? itemModels) {
    List<FilterItemModel>? items = itemModels ?? [];
    return Wrap(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildFilterSheetTitleWidget(title ?? ""),
            Expanded(
              child: Wrap(
                spacing: 10.px,
                children: items.map((model) => buildFilterSheetItemWidget(model)).toList()
              ),
            )
          ],
        )
      ],
    );
  }

  //构建底部筛选条件-条件子(item)组件
  Widget buildFilterSheetItemWidget(FilterItemModel itemModel) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => widget.viewModel.changeFilterItemModelState(itemModel),
      child: Consumer<ProductDetailViewModel>(
        builder: (context,viewModel,child){
          return Chip(
            backgroundColor: itemModel.bgColor,
            padding: EdgeInsets.symmetric(horizontal: 8.px),
            visualDensity: VisualDensity(vertical: -1.px),
            label: Text(itemModel.item ?? ""),
            labelStyle: TextStyle(color: itemModel.textColor,fontSize: 12.px,fontWeight: FontWeight.normal),
          );
        },
      ),
    );
  }

  Widget buildStepperWidget() {
    return Container(
      height: 50.px,
      padding: EdgeInsets.only(left: 25.px),
      child: Row(
        children: [
          Text("数量",textAlign: TextAlign.start,style: Theme.of(context).textTheme.bodyText1),
          SizedBox(width: 15.px),
          step.Stepper(callBack: (count) => valueChange(count)),
        ],
      ),
    );
  }

  //构建底部筛选条件-按钮组件
  Widget buildFilterSheetButtonWidget() {
    return Container(
      padding: EdgeInsets.all(10.px),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ShoppingButton(
              title: "加入购物车",
              backgroundColor: Colors.redAccent,
              onPressed: (){
                debugPrint("加入购物车");
                debugPrint(widget.viewModel.filterItem);
                CartServices.addProduct(widget.viewModel.model);
                Navigator.pop(context);
              }
            ),
          ),
          Expanded(
            child: ShoppingButton(
              title: "立即购买",
              backgroundColor: Colors.orange,
              onPressed: (){
                debugPrint("立即购买");
                debugPrint(widget.viewModel.filterItem);
                Navigator.pop(context);
              }
            ),
          )
        ],
      ),
    );
  }
}
