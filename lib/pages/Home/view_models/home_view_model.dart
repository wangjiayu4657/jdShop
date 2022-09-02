import 'package:flutter/material.dart';

import '../models/banner_model.dart';
import '../models/product_model.dart';
import '../../../tools/Http/http_client.dart';


class HomeViewModel extends ChangeNotifier {
  late List<ProductItemModel> hotItems = [];
  late List<ProductItemModel> likeItems = [];
  late List<BannerItemModel> bannerItems = [];

  //请求banner图数据
  void requestBannerData() async{
    var result = await HttpClient.request(url: "api/focus/",method: "get");
    List list = result["result"];
    bannerItems = list.map((e) => BannerItemModel.fromJson(e)).toList();
    notifyListeners();
  }

  //请求猜你喜欢数据
  void requestLikeProductData() async {
    var result = await HttpClient.request(url: "api/plist?is_hot=1",method: "get");
    List list = result["result"];
    likeItems = list.map((e) => ProductItemModel.fromJson(e)).toList();
    notifyListeners();
  }

  //请求热门推荐数据
  void requestHotProductData() async {
    var result = await HttpClient.request(url: "api/plist?is_best=1",method: "get");
    List list = result["result"];
    hotItems = list.map((e) => ProductItemModel.fromJson(e)).toList();
    notifyListeners();
  }

}