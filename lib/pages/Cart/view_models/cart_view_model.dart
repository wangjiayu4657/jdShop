import 'dart:convert';

import '../../../pages/Category/models/product_detail_model.dart';

class CartViewModel {
  void addProduct(ProductDetailModel model) {
    var param = productDetailModelToJson(model);
    print("param === $param");
  }

  String categoryModelToJson(ProductDetailModel data) => json.encode(data.toJson());

  Map<String,dynamic> productDetailModelToJson(ProductDetailModel model) {
    final Map<String,dynamic> map = <String, dynamic>{};
    map['_id'] = model.id;
    map['title'] = model.title;
    map['price'] = model.price;
    map['filter'] = model.filter;
    map['count'] = model.count;
    map['pic'] = model.pic;
    map['checked'] = true;
    return map;
  }
}