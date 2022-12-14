
import 'package:flutter/material.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../tools/share/const_config.dart';
import '../CustomWidgets/placeholder_image.dart';
import '../../tools/Http/http_client.dart';
import '../../pages/Category/models/category_product_item_model.dart';
import '../../tools/extension/int_extension.dart';
import '../../pages/Category/models/tab_item_model.dart';
import '../../tools/json_parse/json_parse.dart';
import '../../tools/extension/color_extension.dart';
import '../../pages/Category/product_filter_page.dart';

class CategoryProductPage extends StatefulWidget {
  static const String routeName = "/categoryProduct";
  const CategoryProductPage({Key? key, this.argument}) : super(key: key);

  final Map<String,dynamic>? argument;

  @override
  State<CategoryProductPage> createState() => _CategoryProductPageState();
}

class _CategoryProductPageState extends State<CategoryProductPage> {

  late int _page = 1;
  late String? _sort = "";
  late bool _enablePullUp = true;
  late List<TabItemModel> _tabItems = [];
  late List<CategoryProductItemModel> _productItems = [];
  late final RefreshController _controller = RefreshController(initialRefresh: true);

  late final double _topWidgetHeight = 50.px;
  late final double tempWidth = (width - 8.px * 2 - 8.px * 6) / 4;

  late final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  late String? id = widget.argument?["id"];
  late String? search = widget.argument?["search"];

  void requestProductListData() async {
    String query = search == null ? "cid=$id" : "search=$search";
    String url = "api/plist?$query&sort=$_sort&page=$_page&pageSize=10";
    var result = await HttpClient.request(url: url, method: "get");
    CategoryProductModel model = CategoryProductModel.fromJson(result);
    List<CategoryProductItemModel> items = model.items ?? [];

    setState(() {
      _enablePullUp = items.length == 10;
      if (items.length < 10) {
        _controller.loadNoData();
      }

      if (_page == 1) {
        _productItems = items;
        _controller.refreshCompleted();
      } else {
        _productItems.addAll(items);
        _controller.loadComplete();
      }
    });
  }

  //????????????
  void _onRefresh() async {
    _page = 1;
    requestProductListData();
  }

  //??????????????????
  void _onLoading() async {
    if(_enablePullUp) {
      _page += 1;
      requestProductListData();
    } else {
      setState(() => _controller.loadComplete() );
    }
  }

  //????????????json???????????????????????????????????????
  void _loadTabItemFromJson() async {
    var result = await JsonParse.mapToTabItemModelFromLocalJson("assets/jsons/tab_item.json");
    setState(() => _tabItems = result);
  }

  //?????? "??????","??????","??????","??????" ???????????????
  void _selectedTabItem(TabItemModel model) {
    for (var element in _tabItems) {
      if (element.id != model.id) element.isSelected = false;
    }
    model.isSelected = !model.isSelected;

    if(model.id == 4) {
      _sort = "";
      _scaffoldKey.currentState?.openEndDrawer();
    } else {
      _sort = model.tempSort;
      _onRefresh();
    }
  }

  @override
  void initState() {
    super.initState();
    _loadTabItemFromJson();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text("????????????"),
        actions: const [Text("")]
      ),
      endDrawer: const ProductFilterPage(),
      body: Stack(
        children: [
          Positioned(top: 0, child:buildTopTabViewWidget()),
          Positioned(top: _topWidgetHeight, child: buildListViewWidget())
        ],
      )
    );
  }

  //????????????tab??????
  Widget buildTopTabViewWidget() {
    return Container(
      width: width,
      height: _topWidgetHeight,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: ColorExtension.lineColor))
      ),
      child: ListView.builder(
        itemCount: _tabItems.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context,idx) => buildTopTabViewItemWidget(idx),
      ),
    );
  }

  //"??????","??????","??????","??????"
  Widget buildTopTabViewItemWidget(int idx) {
    TabItemModel model = _tabItems[idx];
    return Container(
      width: tempWidth,
      margin: EdgeInsets.all(8.px),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: ColorExtension.lineColor,
        borderRadius: BorderRadius.circular(4.px)
      ),
      child: InkWell(
        onTap: () => _selectedTabItem(model),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(model.title ?? "", style: TextStyle(color: model.textColor)),
            (idx == 1 || idx == 2) ? Icon(model.icon,color: model.textColor) : const Text("")
          ],
        ),
      ),
    );
  }

  //??????????????????
  Widget buildListViewWidget() {
    return Container(
      width: width,
      height: height - 68.px,
      padding: EdgeInsets.only(bottom: 80.px),
      child: SmartRefresher(
        enablePullUp: true,
        enablePullDown: true,
        controller: _controller,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        header: const WaterDropHeader(),
        footer: _enablePullUp ? const ClassicFooter() : buildCustomListFooterWidget(),
        child: _productItems.isEmpty ?
          const Center(child: Text("????????????")) :
          ListView.builder(
            shrinkWrap: true,
            itemCount: _productItems.length,
            itemBuilder: (context,idx) => buildListItemWidget(_productItems[idx]),
          ),
      ),
    );
  }

  //????????????item??????
  Widget buildListItemWidget(CategoryProductItemModel model) {
    return Container(
      height: 140.px,
      margin: EdgeInsets.symmetric(horizontal: 10.px),
      padding: EdgeInsets.symmetric(vertical: 10.px),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: ColorExtension.lineColor))
      ),
      child: Row(
        children: [
          Container(
            width: 120.px,
            height: 120.px,
            padding: EdgeInsets.all(10.px),
            child: PlaceholderImage(url: model.imgUrl),
          ),
          SizedBox(width: 5.px),
          Expanded(child: buildListItemContentWidget(model)),
        ],
      ),
    );
  }

  //????????????item ????????????
  Widget buildListItemContentWidget(CategoryProductItemModel model) {
    return SizedBox(
      height: 120.px,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 2,child:buildItemContentTopWidget(model.title)),
          Expanded(child: buildItemContentMiddleWidget()),
          Expanded(child: buildItemContentBottomWidget(model.price))
        ],
      ),
    );
  }

  //????????????item ?????? ???????????????
  Widget buildItemContentTopWidget(String? text) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(text ?? "")
    );
  }

  //????????????item ?????? ???????????????
  Widget buildItemContentMiddleWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        buildTagItemWidget("12g"),
        SizedBox(width: 15.px),
        buildTagItemWidget("126g")
      ],
    );
  }

  Widget buildTagItemWidget(String text) {
    return Chip(
      label: Text(text,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.black54,
          fontWeight: FontWeight.normal
        )
      ),
      backgroundColor: ColorExtension.lineColor,
      visualDensity: VisualDensity(horizontal: 2.px,vertical: -4),
    );
  }

  //????????????item ?????? ???????????????
  Widget buildItemContentBottomWidget(dynamic price) {
    return Container(
      padding: EdgeInsets.only(top: 5.px),
      alignment: Alignment.centerLeft,
      child: Text("??$price",
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.redAccent)
      )
    );
  }

  //????????????????????????
  Widget buildCustomListFooterWidget() {
    return CustomFooter(
     builder: (context,status){
       return SizedBox(
         height: 56.px,
         child: Center(child: Text(_productItems.isEmpty ? "????????????" : "?????????????????????!")),
       );
     },
    );
  }
}
