// To parse this JSON data, do
//
//     final productDetailModel = productDetailModelFromJson(jsonString);

import 'dart:convert';

import 'package:jdShop/tools/Http/http_config.dart';

ProductDetailModel productDetailModelFromJson(String str) => ProductDetailModel.fromJson(json.decode(str));

String productDetailModelToJson(ProductDetailModel data) => json.encode(data.toJson());

class ProductDetailModel {
  ProductDetailModel({
    this.id,
    this.title,
    this.cid,
    this.price,
    this.oldPrice,
    this.isBest,
    this.isHot,
    this.isNew,
    this.status,
    this.pic,
    this.content,
    this.cname,
    this.attr,
    this.subTitle,
    this.salecount,
  });

  String? id;
  String? title;
  String? cid;
  dynamic price;
  dynamic oldPrice;
  dynamic isBest;
  dynamic isHot;
  dynamic isNew;
  dynamic status;
  String? pic;
  String? content;
  String? cname;
  List<FilterModel>? attr;
  String? subTitle;
  int? salecount;

  String get imgUrl => HttpConfig.baseUrl + (pic ?? "");

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) => ProductDetailModel(
    id: json["_id"],
    title: json["title"],
    cid: json["cid"],
    price: json["price"],
    oldPrice: json["old_price"],
    isBest: json["is_best"],
    isHot: json["is_hot"],
    isNew: json["is_new"],
    status: json["status"],
    pic: json["pic"].toString().replaceAll("\\", "/"),
    content: json["content"],
    cname: json["cname"],
    attr: List<FilterModel>.from(json["attr"].map((x) => FilterModel.fromJson(x))),
    subTitle: json["sub_title"],
    salecount: json["salecount"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "cid": cid,
    "price": price,
    "old_price": oldPrice,
    "is_best": isBest,
    "is_hot": isHot,
    "is_new": isNew,
    "status": status,
    "pic": pic,
    "content": content,
    "cname": cname,
    "attr": List<dynamic>.from(attr??[].map((x) => x.toJson())),
    "sub_title": subTitle,
    "salecount": salecount,
  };
}

//筛选条件
class FilterModel {
  FilterModel({
    this.cate,
    this.list,
  });

  String? cate;
  List<String>? list;

  factory FilterModel.fromJson(Map<String, dynamic> json) => FilterModel(
    cate: json["cate"],
    list: List<String>.from(json["list"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "cate": cate,
    "list": List<dynamic>.from(list??[].map((x) => x)),
  };
}
