// To parse this JSON data, do
//
//     final categoryProductItemModel = categoryProductItemModelFromJson(jsonString);

import 'dart:convert';

import 'package:jdShop/tools/Http/http_config.dart';

CategoryProductModel categoryProductItemModelFromJson(String str) => CategoryProductModel.fromJson(json.decode(str));

String categoryProductItemModelToJson(CategoryProductModel data) => json.encode(data.toJson());

class CategoryProductModel {
  CategoryProductModel({ this.items });

  List<CategoryProductItemModel>? items;

  factory CategoryProductModel.fromJson(Map<String, dynamic> json) => CategoryProductModel(
    items: List<CategoryProductItemModel>.from(json["result"].map((x) => CategoryProductItemModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "result": List<dynamic>.from(items??[].map((x) => x.toJson())),
  };
}

class CategoryProductItemModel {
  CategoryProductItemModel({
    this.id,
    this.title,
    this.cid,
    this.price,
    this.oldPrice,
    this.pic,
    this.sPic,
  });

  String? id;
  String? title;
  String? cid;
  dynamic price;
  String? oldPrice;
  String? pic;
  String? sPic;

  String get imgUrl => HttpConfig.baseUrl + (pic ?? "");
  String get sImgUrl => HttpConfig.baseUrl + (sPic ?? "");

  factory CategoryProductItemModel.fromJson(Map<String, dynamic> json) => CategoryProductItemModel(
    id: json["_id"],
    title: json["title"],
    cid: json["cid"],
    price: json["price"],
    oldPrice: json["old_price"],
    pic: json["pic"].toString().replaceAll('\\', '/'),
    sPic: json["s_pic"].toString().replaceAll('\\', '/'),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "cid": cid,
    "price": price,
    "old_price": oldPrice,
    "pic": pic,
    "s_pic": sPic,
  };
}
