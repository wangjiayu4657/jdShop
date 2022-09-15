import 'package:flutter/material.dart';

import '../../../tools/http/http_client.dart';
import '../models/product_detail_model.dart';

class ProductDetailViewModel extends ChangeNotifier {

  ProductDetailViewModel({this.id});

  String? id;
  ProductDetailModel? _model;
  ProductDetailModel? get model => _model;

  Future<ProductDetailModel?> detailDataRequest() async {
    var result = await HttpClient.request(url: "api/pcontent?id=$id");
    var json = result["result"];
    if(json is Map<String,dynamic>){
      _model = ProductDetailModel.fromJson(json);
    }
    notifyListeners();
    return _model;
  }
  
}