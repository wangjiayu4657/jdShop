import 'dart:convert';

import '../../../pages/Category/models/product_detail_model.dart';
import '../../../tools/storage/storage.dart';


class CartServices {
  static const String kCartsKey = "kCartsKey";
  static List<ProductDetailModel> products = [];

  //加入购物车
  static void addProductToCart(ProductDetailModel? model) async {
    if(model == null) return;

    List<String>? productList = await Storage.fetchList(kCartsKey);

    bool isContain = false;
    for(int i = 0; i < products.length; i++){
       String jsonString = productList[i];
       Map<String,dynamic> map = json.decode(jsonString);
       int count = map["count"] ?? 0;
       if(map["_id"] == model.id && map["filter"] == model.filter) {
         isContain = true;
         map["count"] = count + model.count;
         productList[i] = json.encode(map);
         break;
       }
    }

    if(!isContain) {
      String product = productDetailModelToJson(model);
      productList.add(product);
    }

    products = productList.map((e) => json.decode(e) as Map<String,dynamic>)
          .map((e) => ProductDetailModel.fromJson(e))
          .toList();

    saveProducts(productList);
  }

  //保存购物车商品
  static saveProducts(List<String> products) {
    Storage.save<List<String>>(kCartsKey, products);
  }

  //清空购物车
  static clearCart() {
    Storage.remove(kCartsKey);
  }
}