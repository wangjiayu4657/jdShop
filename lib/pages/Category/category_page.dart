import 'package:flutter/material.dart';

import '../../tools/share/const_config.dart';
import '../../tools/extension/int_extension.dart';
import '../CustomWidgets/placeholder_image.dart';

class CategoryPage extends StatefulWidget {
  static const String routeName = "/category";
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {

  int _selectedIdx = 0;

  late double leftListWidth = width / 4;
  late double rightListItemWidth = (width - leftListWidth - 20.px - 20.px) / 3;
  late double childAspectRatio = rightListItemWidth / (rightListItemWidth + 44.px);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("分类")),
      body: SizedBox(
        height: double.infinity,
        child: Row(
          children: [
            buildLeftListWidget(),
            buildRightListWidget()
          ],
        ),
      ),
    );
  }

  //左边分类列表
  Widget buildLeftListWidget() {
    return SizedBox(
      width: leftListWidth,
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context,idx){
          return buildLeftListItem(idx);
        },
      ),
    );
  }

  //左边分类列表item
  Widget buildLeftListItem(int idx) {
    return InkWell(
      onTap: () {
        setState(() => _selectedIdx = idx);
      },
      child: SizedBox(
        height: 60.px,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 58.px,
              alignment: Alignment.center,
              color: _selectedIdx == idx ? Colors.redAccent : Colors.white,
              child: const Text("item")
            ),
            const  Expanded(child:  Divider())
          ],
        ),
      ),
    );
  }

  //右边物品列表
  Widget buildRightListWidget() {
    return Expanded(
      child: Container(
        color: const Color.fromRGBO(240, 246, 246, 1),
        child: GridView.builder(
          padding: EdgeInsets.all(10.px),
          itemCount: 18,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 10.px,
            crossAxisSpacing: 10.px,
            childAspectRatio: childAspectRatio
          ),
          itemBuilder: (context,idx) => buildRightListItem(context),
        ),
      ),
    );
  }

  //右边物品列表item
  Widget buildRightListItem(BuildContext context) {
    return Column(
      children: [
        const Expanded(
          child:PlaceholderImage(imageUrl: "https://jdmall.itying.com/public/upload/RinsvExKu7Ed-ocs_7W1DxYO.png_200x200.png")
        ),
        Container(
          height: 30.px,
          padding: EdgeInsets.only(top: 10.px),
          alignment: Alignment.center,
          child: Text(
            "测试商品",
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
              fontSize: 14,
              color: Colors.black54,
              fontWeight: FontWeight.normal
            )
          ),
        ),
      ],
    );
  }
}
