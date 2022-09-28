import 'package:flutter/material.dart';

class SettingModel {

  SettingModel({
    this.icon,
    this.title,
    this.height
  });

  final String? icon;
  final String? title;
  final double? height;

  IconData? get iconData {
    if(icon == null) return null;
    return IconData(int.parse(icon!),fontFamily: "MaterialIcons");
  }

  factory SettingModel.fromJson(Map<String,dynamic>map) => SettingModel(
    icon: map["icon"],
    title: map["title"],
    height: map["height"]
  );

  Map<String,dynamic> toJson() => {
    "icon": icon,
    "title": title,
    "height": height
  };
}