import '../../../pages/Category/models/product_detail_model.dart';

class CartServices {
  static void addProduct(ProductDetailModel? model) {
    if(model == null) return;
    var param = productDetailModelToJson(model);
    print("param === $param");
  }

  static Map<String,dynamic> productDetailModelToJson(ProductDetailModel model) {
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