// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../tools/share/const_config.dart';
import '../../tools/extension/int_extension.dart';
import '../CustomWidgets/placeholder_image.dart';
import '../../pages/Category/models/category_model.dart';
import 'view_models/category_view_model.dart';

class CategoryPage extends StatefulWidget {
  static const String routeName = "/category";
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> with AutomaticKeepAliveClientMixin{

  int _selectedIdx = 0;

  late double leftListWidth = width / 4;
  late double rightListItemWidth = (width - leftListWidth - 20.px - 20.px) / 3;
  late double childAspectRatio = rightListItemWidth / (rightListItemWidth + 44.px);

  late CategoryViewModel categoryViewModel = CategoryViewModel();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    initCategoryData();
  }

  void initCategoryData() async {
    var items = await categoryViewModel.requestCategoryData();
    categoryViewModel.cacheRequestCategoryDetailData(items.first.id);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      create: (context) => categoryViewModel,
      child: Scaffold(
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
      ),
    );
  }

  //左边分类列表
  Widget buildLeftListWidget() {
    return SizedBox(
      width: leftListWidth,
      child: Consumer<CategoryViewModel>(
        builder: (context,viewModel,child){
          return ListView.builder(
            itemCount: viewModel.categories.length,
            itemBuilder: (context,idx) => buildLeftListItem(idx,viewModel.categories[idx]),
          );
        },  //builder
      ),
    );
  }

  //左边分类列表item
  Widget buildLeftListItem(int idx,CategoryItemModel model) {
    return InkWell(
      onTap: () {
        setState(() => _selectedIdx = idx);
        categoryViewModel.cacheRequestCategoryDetailData(model.id);
      },
      child: SizedBox(
        height: 60.px,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 59.px,
              alignment: Alignment.center,
              color: _selectedIdx == idx ? const Color.fromRGBO(240, 246, 246, 1) : Colors.white,
              child: Text(model.title ?? "",style: TextStyle(fontSize: 14.px))
            ),
            const Expanded(child: Divider())
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
        child: Consumer<CategoryViewModel>(
          builder: (context,viewModel,child){
            return viewModel.categoryItems.isNotEmpty ? GridView.builder(
              padding: EdgeInsets.all(10.px),
              itemCount: viewModel.categoryItems.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10.px,
                crossAxisSpacing: 10.px,
                childAspectRatio: childAspectRatio
              ),
              itemBuilder: (context,idx) => buildRightListItem(context,viewModel.categoryItems[idx]),
            ) : const Center(
              child: Text("loading..."),
            );
          },
        ),
      ),
    );
  }

  //右边物品列表item
  Widget buildRightListItem(BuildContext context, CategoryItemModel model) {
    return Column(
      children: [
        Expanded(child:PlaceholderImage(imageUrl: model.imgUrl)),
        Container(
          height: 30.px,
          padding: EdgeInsets.only(top: 10.px),
          alignment: Alignment.center,
          child: Text(
            model.title ?? "",
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
