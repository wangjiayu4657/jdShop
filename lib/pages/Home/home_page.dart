import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_swiper_null_safety_flutter3/flutter_swiper_null_safety_flutter3.dart';

import '../CustomWidgets/placeholder_image.dart';
import '../../tools/share/const_config.dart';
import '../../pages/Home/models/product_model.dart';
import '../../tools/extension/int_extension.dart';
import '../../pages/Home/view_models/home_view_model.dart';

class HomePage extends StatefulWidget {
  static const String routeName = "/home";

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeViewModel viewModel = HomeViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.requestBannerData();
    viewModel.requestHotProductData();
    viewModel.requestLikeProductData();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      lazy: true,
      create: (context) => viewModel,
      child: Scaffold(
        appBar: AppBar(title: const Text("首页")),
        body: ListView(
          children: [
            buildSwiperWidget(),
            buildSectionTitleWidget(context, "猜你喜欢"),
            buildLikeListWidget(),
            buildSectionTitleWidget(context, "热门推荐"),
            buildHotProductListWidget()
          ],
        ),
      ),
    );
  }

  //构建banner图组件
  Widget buildSwiperWidget() {
    return AspectRatio(
      aspectRatio: 2.0,
      child: Consumer<HomeViewModel>(
        builder: (context, model, child) {
          // print("model.bannerItems[idx].imageUrl == ${model.bannerItems.first.imageUrl}");
          return model.bannerItems.isEmpty
            ? Image.asset("assets/images/placeholder.png", fit: BoxFit.cover)
            : Swiper(
                autoplay: true,
                pagination: const SwiperPagination(),
                control: const SwiperControl(),
                itemCount: model.bannerItems.length,
                itemBuilder: (context, idx) => PlaceholderImage(imageUrl:model.bannerItems[idx].imageUrl),
              );
        },
      ),
    );
  }

  //构建组头控件
  Widget buildSectionTitleWidget(BuildContext context, String sectionTitle) {
    return Row(
      children: [
        Container(
          width: 5.px,
          height: 20.px,
          color: Colors.redAccent,
          margin: EdgeInsets.fromLTRB(15.px, 10.px, 10.px, 10.px),
        ),
        Text(sectionTitle, style: Theme.of(context).textTheme.bodyText2),
      ],
    );
  }

  //构建猜你喜欢控件
  Widget buildLikeListWidget() {
    return SizedBox(
      height: 160.px,
      child: Consumer<HomeViewModel>(
        builder: (context, viewModel, child) {
          return ListView.builder(
            padding: EdgeInsets.all(6.px),
            scrollDirection: Axis.horizontal,
            itemCount: viewModel.likeItems.length,
            itemBuilder: (context, idx) =>
              buildLikeItem(context, viewModel.likeItems[idx]),
          );
        },
      ),
    );
  }

  //猜你喜欢item
  Widget buildLikeItem(BuildContext context, ProductItemModel model) {
    return Column(
      children: [
        Container(
          width: 100.px,
          height: 100.px,
          padding: EdgeInsets.all(6.px),
          child: PlaceholderImage(imageUrl: model.imageUrl),
        ),
        Container(
          width: 100.px,
          alignment: Alignment.center,
          padding: EdgeInsets.all(6.px),
          child: Text(
            model.title ?? "",
            maxLines: 2,
            overflow: TextOverflow.visible,
            style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 12.px)
          )
        )
      ],
    );
  }

  //热门推荐列表
  Widget buildHotProductListWidget() {
    return Padding(
      padding: EdgeInsets.all(10.px),
      child: Consumer<HomeViewModel>(
        builder: (context,viewModel,child){
          return Wrap(
            spacing: 10.px,
            runSpacing: 10.px,
            children: viewModel.hotItems.map((item) => buildProductItem(item)).toList()
          );
        },
      ),
    );
  }

  //热门推荐item
  Widget buildProductItem(ProductItemModel productItem) {
    double itemWidth = (width - 30.px) / 2;
    return Container(
      padding: EdgeInsets.all(8.px),
      width: itemWidth,
      decoration: BoxDecoration(border: Border.all(color: const Color.fromRGBO(233, 233, 233, 1))),
      child: Column(
        children: [
          SizedBox(
            height: 180.px,
            child: PlaceholderImage(imageUrl: productItem.imageUrl)
          ),
          Padding(
            padding: EdgeInsets.all(8.px),
            child: Text(
              productItem.title ?? "",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14.px,
                color: Colors.black54,
                fontWeight: FontWeight.normal
              ),
            ),
          ),
          buildProductItemBottomPriceWidget(productItem)
        ],
      ),
    );
  }

  //热门推荐item底部价格视图
  Widget buildProductItemBottomPriceWidget(ProductItemModel productItem) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.px),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        textBaseline: TextBaseline.ideographic,
        children: [
          Text("¥${productItem.price}",
            style: TextStyle(
              fontSize: 14.px,
              color: Colors.redAccent,
              fontWeight: FontWeight.normal
            )
          ),
          Text("¥${productItem.oldPrice}",
            style: TextStyle(
              fontSize: 14.px,
              color: Colors.redAccent,
              fontWeight: FontWeight.normal,
              decoration: TextDecoration.lineThrough
            )
          )
        ],
      ),
    );
  }
}
