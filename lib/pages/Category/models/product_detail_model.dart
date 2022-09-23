// To parse this JSON data, do
//
//     final productDetailModel = productDetailModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';
import '../../../tools/Http/http_config.dart';
import '../../../tools/extension/color_extension.dart';

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
    int? count,
    String? filter,
    bool? isChecked
  }) : count = count ?? 1,
       filter = filter ?? "",
       isChecked = isChecked ?? false;

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

  //添加额外字段
  late int count = 1;
  late String filter = "";
  late bool isChecked = false;

  List<FilterModel> get filters => attr ?? [];
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
    count:json["count"],
    filter: json["filter"],
    isChecked: json["isChecked"]
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
    "count": count,
    "filter": filter,
    "isChecked": isChecked
  };
}

//筛选条件
class FilterModel {
  FilterModel({
    this.cate,
    this.list,
    this.items
  });

  String? cate;
  List<String>? list;

  //添加额外字段
  List<FilterItemModel>? items = [];

  factory FilterModel.fromJson(Map<String, dynamic> json) => FilterModel(
    cate: json["cate"],
    list: List<String>.from(json["list"].map((x) => x)),
    items: List<String>.from(json["list"]).map((e) => FilterItemModel(item: e)).toList()
  );

  Map<String, dynamic> toJson() => {
    "cate": cate,
    "list": List<dynamic>.from(list??[].map((x) => x)),
  };
}

class FilterItemModel extends ChangeNotifier {
  FilterItemModel({
    this.item,
  });

  String? item;

  bool _isSelected = false;
  Color? get textColor => isSelected ? Colors.white : Colors.black54;
  Color? get bgColor => isSelected ? Colors.redAccent :  ColorExtension.bgColor;

  bool get isSelected => _isSelected;

  set isSelected(bool value) {
    _isSelected = value;
    notifyListeners();
  }
}