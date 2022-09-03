import 'package:flutter/material.dart';

import '../CustomWidgets/placeholder_image.dart';
import '../../tools/Http/http_client.dart';
import '../../pages/Category/models/category_product_item_model.dart';
import '../../tools/extension/int_extension.dart';

class CategoryProductPage extends StatefulWidget {
  static const String routeName = "/categoryProduct";
  const CategoryProductPage({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  State<CategoryProductPage> createState() => _CategoryProductPageState();
}

class _CategoryProductPageState extends State<CategoryProductPage> {

  late List<CategoryProductItemModel> _items = [];
  
  @override
  void initState() {
    super.initState();
    requestProductListData();
  }
  
  void requestProductListData() async {
     var result = await HttpClient.request(url: "api/plist?cid=${widget.id}", method: "get");
     CategoryProductModel model = CategoryProductModel.fromJson(result);
     setState(() => _items = model.items ?? []);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("商品列表")),
      body: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (context,idx) => buildListItemWidget(_items[idx]),
      ),
    );
  }

  Widget buildListItemWidget(CategoryProductItemModel model) {
    return Container(
      height: 140.px,
      margin: EdgeInsets.symmetric(horizontal: 10.px),
      padding: EdgeInsets.symmetric(vertical: 10.px),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color.fromRGBO(233, 233, 233, 0.5)))
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
          Expanded(
            child: SizedBox(
              height: 120.px,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: Text(model.title ?? "")),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Chip(label:const Text("4g"),padding: EdgeInsets.all(5.px)),
                      SizedBox(width: 15.px),
                      const Chip(label: Text("126g")),
                    ],
                  ),
                  Container(
                    height: 32.px,
                    padding: EdgeInsets.symmetric(vertical: 4.px),
                    child: Text("¥${model.price}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.redAccent)
                    )
                  )
              ],
              ),
            )
          ),
        ],
      ),
    );
  }

  Widget buildProductListItemContentWidget() {
    return Column(
      
    );
  }
}
