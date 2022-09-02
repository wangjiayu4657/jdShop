// To parse this JSON data, do
//
//     final bannerModel = bannerModelFromJson(jsonString);

import 'dart:convert';

import 'package:jdshop/tools/Http/http_config.dart';

BannerModel bannerModelFromJson(String str) => BannerModel.fromJson(json.decode(str));
String bannerModelToJson(BannerModel data) => json.encode(data.toJson());

class BannerModel {
  BannerModel({ this.items });
  List<BannerItemModel>? items;

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
    items: List<BannerItemModel>.from(json["result"].map((x) => BannerItemModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "result": List<dynamic>.from(items??[].map((x) => x.toJson())),
  };
}

class BannerItemModel {
  BannerItemModel({
    this.id,
    this.title,
    this.status,
    this.pic,
    this.url,
  });

  String? id;
  String? title;
  String? status;
  String? pic;
  String? url;

  String get imageUrl => HttpConfig.baseUrl + (pic ?? "");

  factory BannerItemModel.fromJson(Map<String, dynamic> json) => BannerItemModel(
    id: json["_id"],
    title: json["title"],
    status: json["status"],
    pic: json["pic"].toString().replaceAll("\\", "/"),
    url: json["url"]
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "status": status,
    "pic": pic,
    "url": url,
  };
}
