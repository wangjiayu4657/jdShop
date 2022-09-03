import 'package:flutter/material.dart';

import '../models/category_model.dart';
import '../../../tools/Http/http_client.dart';

class CategoryViewModel extends ChangeNotifier {
  late List<CategoryItemModel> categories = [];
  late List<CategoryItemModel> categoryItems = [];
  late final Map<String,List<CategoryItemModel>> _items = {};

  //请求分类导航列表
  Future<List<CategoryItemModel>> requestCategoryData() async {
    var response = await HttpClient.request(url: "api/pcate", method: "get");
    List result = response["result"];
    categories = result.map((e) => CategoryItemModel.fromJson(e)).toList();
    notifyListeners();
    return categories;
  }

  //请求分类商品列表
  Future<List<CategoryItemModel>> requestCategoryDetailData(String? pid) async {
    var response = await HttpClient.request(url: "api/pcate?pid=$pid", method: "get");
    List result = response["result"];
    categoryItems = result.map((e) => CategoryItemModel.fromJson(e)).toList();
    notifyListeners();
    return categoryItems;
  }

  //请求并缓存分类商品列表
  void cacheRequestCategoryDetailData(String? id) async {
    if(id == null) return;
    List<CategoryItemModel>? list = _items[id];
    categoryItems = list ?? await requestCategoryDetailData(id);
    list == null ? _items[id] = categoryItems : notifyListeners();
  }
}