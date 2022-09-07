import 'package:flutter/material.dart';

class TabItemModel {
  TabItemModel({
    this.id,
    this.title,
    this.fields,
    this.sort
  });

  int? id;
  String? title;
  String? fields;
  int? sort;

  //添加额外字段
  bool isSelected = false; //是否选中该项
  String get tempSort => "${fields}_${(sort ?? 0) * (isSelected ? 1 : -1)}"; //排序参数
  Color get textColor => isSelected ? Colors.redAccent : Colors.black54; //选中/未选中的字体
  IconData get icon => isSelected ? Icons.arrow_drop_down : Icons.arrow_drop_up; //选中/未选中的图标

  factory TabItemModel.fromJson(Map<String,dynamic> json) => TabItemModel(
    id: json["id"],
    title: json["title"],
    fields: json["fields"],
    sort: json["sort"]
  );
}