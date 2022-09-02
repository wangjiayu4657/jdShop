// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

import 'package:jdShop/tools/Http/http_config.dart';

CategoryModel categoryModelFromJson(String str) => CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  CategoryModel({ this.categoryItems });

  late List<CategoryItemModel>? categoryItems;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    categoryItems: List<CategoryItemModel>.from(json["result"].map((x) => CategoryItemModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "result": List<dynamic>.from(categoryItems??[].map((x) => x.toJson())),
  };
}

class CategoryItemModel {
  CategoryItemModel({
    this.id,
    this.title,
    this.status,
    this.pic,
    this.pid,
    this.sort,
  });

  String? id;
  String? title;
  dynamic status;
  String? pic;
  String? pid;
  String? sort;

  String get imgUrl => HttpConfig.baseUrl + (pic ?? "");

  factory CategoryItemModel.fromJson(Map<String, dynamic> json) => CategoryItemModel(
    id: json["_id"],
    title: json["title"],
    status: json["status"],
    pic: json["pic"].toString().replaceAll("\\", "/"),
    pid: json["pid"],
    sort: json["sort"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "status": status,
    "pic": pic,
    "pid": pid,
    "sort": sort,
  };
}
