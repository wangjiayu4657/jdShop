import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../tools/extension/int_extension.dart';
import '../../pages/CustomWidgets/placeholder_image.dart';
import '../../pages/Category/view_models/product_detail_view_model.dart';
import '../../tools/event_bus/event_bus.dart';
import 'widgets/product_filter.dart';



//商品详情 - 商品
class ProductDetailProductPage extends StatefulWidget {
  const ProductDetailProductPage({Key? key, required this.viewModel}) : super(key: key);

  final ProductDetailViewModel viewModel;

  @override
  State<ProductDetailProductPage> createState() => _ProductDetailProductPageState();
}

class _ProductDetailProductPageState extends State<ProductDetailProductPage> with AutomaticKeepAliveClientMixin {

  late StreamSubscription _sheetSubscription;  //event_bus

  @override
  bool get wantKeepAlive => true;

  //展示底部条件筛选组件
  void showFilterSheetWidget() {
    showBottomSheet(
      context: context,
      builder: (ctx) => ProductFilter(model: widget.viewModel.model)
    );
  }

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
        Text(
          "¥${widget.viewModel.model?.price ?? ""}",
          style: Theme.of(context).textTheme.headline2?.copyWith(color: Colors.redAccent)
        )
      ],
    );
  }

  //构建价格-原价组件
  Widget buildProductPriceOriginalPriceWidget() {
    return Row(
      children: [
        const Text("原价: "),
        Text(
          "¥${widget.viewModel.model?.oldPrice ?? ""}",
          style: Theme.of(context).textTheme.headline2?.copyWith(
            decoration: TextDecoration.lineThrough
          )
        )
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
          onTap: showFilterSheetWidget,
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
          leading: Text("运费: ",style: TextStyle(color: Colors.black54,fontWeight: FontWeight.bold)),
          title: Text("免运费",style: TextStyle(color: Colors.black54,fontWeight: FontWeight.normal),),
        ),
        Divider(height: 1)
      ],
    );
  }
}
