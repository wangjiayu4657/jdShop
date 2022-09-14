import 'package:flutter/material.dart';
import 'package:jdShop/pages/Category/category_product_page.dart';
import 'package:provider/provider.dart';

import '../../tools/extension/int_extension.dart';
import '../../tools/share/const_config.dart';
import '../../tools/widgets/search_bar.dart';
import '../../tools/extension/color_extension.dart';
import 'view_models/search_view_model.dart';

class SearchPage extends StatefulWidget {
  static const String routeName = "/search";
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late final SearchViewModel _viewModel = SearchViewModel();
  final List<String> _hotItems = ["超级秒杀","办公用品","儿童小汽车","唇彩唇蜜","装修专用耗材","地板"];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SearchViewModel>(
      create: (BuildContext context) => _viewModel,
      child: Scaffold(
        appBar: SearchBar(
          placeholder: "请输入需要搜索的内容",
          isHiddenSearchText: false,
          searchClick: (search){
            Navigator.pushNamed(context, CategoryProductPage.routeName,arguments: {"search":search});
            _viewModel.saveSearchContent(search);
          },
        ),
        body: Stack(
          children: [
            Positioned(
              top: 5.px,
              width: width,
              height: height - 110.px,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  buildHotSearchWidget(),
                  buildHistoryWidget()
                ],
              ),
            ),
            Positioned(
              bottom: 0.px,
              width: width,
              height: 105.px,
              child: clearHistorySearchButtonWidget(),
            )
          ],
        )
      ),
    );
  }

  Widget buildHotSearchWidget() {
    return Container(
      width: width,
      height: 125.px,
      padding: EdgeInsets.symmetric(vertical:4.px,horizontal: 15.px),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildSectionTitleWidget(context, "热门搜索"),
          buildHotSearchContentWidget()
        ],
      ),
    );
  }

  //组头
  Widget buildSectionTitleWidget(BuildContext context,String title) {
    return Container(
      height: 44.px,
      padding: EdgeInsets.symmetric(vertical: 10.px),
      child: Text(title,
        style: Theme.of(context)
          .textTheme
          .headline1
          ?.copyWith(fontWeight: FontWeight.bold
        )
      ),
    );
  }

  //热搜内容
  Widget buildHotSearchContentWidget() {
    return Padding(
      padding: EdgeInsets.only(top: 5.px),
      child: Wrap(
        spacing: 10.px,
        runSpacing: 4.px,
        children: _hotItems.map((item) => buildHotSearchItemWidget(item)).toList()
      ),
    );
  }

  //热搜item
  Widget buildHotSearchItemWidget(String item) {
    return SizedBox(
      height: 32.px,
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, CategoryProductPage.routeName,arguments: {"search":item}),
        child: Chip(
          backgroundColor: ColorExtension.lineColor,
          padding: EdgeInsets.symmetric(horizontal: 10.px),
          label: Text( item,
            style: TextStyle(
              fontSize: 12.px,
              color: Colors.black54,
              fontWeight: FontWeight.normal
            )
          )
        ),
      ),
    );
  }

  //历史搜索
  Widget buildHistoryWidget() {
    return Container(
      width: width,
      // height: height - 225.px,
      padding: EdgeInsets.symmetric(vertical:4.px,horizontal: 15.px),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildSectionTitleWidget(context, "历史搜索"),
          buildHistoryListWidget()
        ],
      ),
    );
  }

  Widget buildHistoryListWidget() {
    return SizedBox(
      height: height - 225.px - 120.px,
      child: Consumer<SearchViewModel>(
        builder: (context,viewModel,child){
          return viewModel.historyItems.isEmpty ?
          const Center( child: Text("暂无历史记录")) :
          ListView.builder(
            shrinkWrap: true,
            itemCount: viewModel.historyItems.length,
            itemBuilder: (context,idx){
              String search = viewModel.historyItems[idx];
              return Column(
                children: [
                  ListTile(
                    title: Text(search),
                    contentPadding: EdgeInsets.zero,
                    onTap: () => Navigator.pushNamed(context, CategoryProductPage.routeName,arguments: {"search":search}),
                    onLongPress: () => showAlertDialog(record:search),
                  ),
                  child ?? const Divider(height: 1),
                ],
              );
            },
          );
        },
        child: const Divider(height: 1),
      ),
    );
  }

  Widget clearHistorySearchButtonWidget() {
    return Container(
      height: 88.px,
      color: ColorExtension.hex("#F7F7F7"),
      alignment: Alignment.center,
      padding: EdgeInsets.only(bottom: 15.px),
      child: InkWell(
        onTap: () => showAlertDialog(),
        child: Container(
          width: width - 40.px,
          height: 48.px,
          decoration: BoxDecoration(
            // color: Colors,
            border: Border.all(color: Colors.black12,width: 0.5),
            borderRadius: BorderRadius.circular(4.px),
          ),
          // alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.delete_outline_outlined),
              Text("清空历史记录")
            ],
          ),
        ),
      ),
    );
  }

  void showAlertDialog({String? record}) {
    String content = record == null ? "确定要清空历史记录吗?" : "确定要删除`$record`这条记录吗?";
    showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title: const Text("提示",textAlign: TextAlign.center),
          content: Text(content),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            ElevatedButton(child: const Text("取消"),onPressed: (){
              Navigator.pop(context);
            }),
            SizedBox(width: 20.px),
            ElevatedButton(child: const Text("确定"),onPressed: (){
              if (record == null) {
                _viewModel.clearHistoryRecord();
              } else {
                _viewModel.removeHistoryRecordItems(record);
              }
              Navigator.pop(context);
            }),
          ],
        );
      }
    );
  }

}