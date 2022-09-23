import 'dart:convert';

import '../../../pages/Category/models/product_detail_model.dart';
import '../../../tools/storage/storage.dart';


class CartServices {
  static const String kCartsKey = "kCartsKey";
  static List<ProductDetailModel> products = [];

  //加入购物车
  static void addProductToCart(ProductDetailModel? model) async {
    // Storage.remove(kCartsKey);
    if(model == null) return;

    List<String>? carts = await Storage.fetchList(kCartsKey);

    bool isContain = false;
    for(int i = 0; i < carts.length; i++){
       String jsonString = carts[i];
       Map<String,dynamic> map = json.decode(jsonString);
       int count = map["count"] ?? 0;
       if(map["_id"] == model.id && map["filter"] == model.filter) {
         isContain = true;
         map["count"] = count + model.count;
         carts[i] = json.encode(map);
         break;
       }
    }

    if(!isContain) {
      String product = productDetailModelToJson(model);
      carts.add(product);
    }

    products = carts.map((e) => json.decode(e) as Map<String,dynamic>)
          .map((e) => ProductDetailModel.fromJson(e))
          .toList();

    Storage.save<List<String>>(kCartsKey, carts);
    print("carts ==== $carts");
  }

  // static String productDetailModelToJson(ProductDetailModel model) {
  //   final Map<String,dynamic> map = <String, dynamic>{};
  //   map['id'] = model.id;
  //   map['title'] = model.title;
  //   map['price'] = model.price;
  //   map['filter'] = model.filter;
  //   map['count'] = model.count;
  //   map['pic'] = model.pic;
  //   map['checked'] = model.isChecked;
  //   return json.encode(map);
  // }
}