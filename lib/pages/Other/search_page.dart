import 'package:flutter/material.dart';

import '../../tools/extension/int_extension.dart';
import '../../tools/share/const_config.dart';
import '../../tools/widgets/search_bar.dart';
import '../../tools/extension/color_extension.dart';

class SearchPage extends StatefulWidget {
  static const String routeName = "/search";
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final List<String> _hotItems = ["超级秒杀","办公用品","儿童小汽车","唇彩唇蜜","装修专用耗材","地板"];
  final List<String> _historyItems = ["超级秒杀","办公用品","儿童小汽车","唇彩唇蜜","装修专用耗材","地板","超级秒杀","办公用品","儿童小汽车","唇彩唇蜜","装修专用耗材","地板"];

  GlobalKey wrapHeightKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    wrapHeightKey.currentContext?.size?.height;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchBar(
        placeholder: "请输入需要搜索的内容",
        isHiddenSearchText: false,
        searchClick: (search){

        },
      ),
      body: Stack(
        children: [
          Positioned(
            top: 5.px,
            width: width,
            height: height - 115.px,
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
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: _historyItems.length,
        itemBuilder: (context,idx){
          return Column(
            children: [
              ListTile(
                onTap: (){},
                contentPadding: EdgeInsets.zero,
                title: Text(_historyItems[idx]),
              ),
              const Divider(height: 1),
            ],
          );
        },
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
        onTap: (){
          print("清空历史记录");
        },
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

}