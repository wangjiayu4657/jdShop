// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

import '../../../tools/Http/http_config.dart';

ProductModel productModelFromJson(String str) => ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel({ this.items });

  List<ProductItemModel>? items;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    items: List<ProductItemModel>.from(json["result"].map((x) => ProductItemModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "result": List<dynamic>.from(items??[].map((x) => x.toJson())),
  };
}

class ProductItemModel {
  ProductItemModel({
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
  int? price;
  String? oldPrice;
  String? pic;
  String? sPic;

  String get imageUrl => HttpConfig.baseUrl + (pic ?? ""); //正常图
  String get sImageUrl => HttpConfig.baseUrl + (pic ?? ""); //缩略图

  factory ProductItemModel.fromJson(Map<String, dynamic> json) => ProductItemModel(
    id: json["_id"],
    title: json["title"],
    cid: json["cid"],
    price: json["price"],
    oldPrice: json["old_price"],
    pic: json["pic"].toString().replaceAll("\\", "/"),
    sPic: json["s_pic"].toString().replaceAll("\\", "/"),
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
