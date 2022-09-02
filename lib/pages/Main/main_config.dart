import 'package:flutter/material.dart';

import '../Cart/cart_page.dart';
import '../home/home_page.dart';
import '../category/category_page.dart';
import '../profile/profile_page.dart';

class MainConfig {
  static List<Widget> pages = const [
    HomePage(),
    CategoryPage(),
    CartPage(),
    ProfilePage()
  ];

  static List<BottomNavigationBarItem> items = const [
    BottomNavigationBarItem(icon: Icon(Icons.home),label: "首页"),
    BottomNavigationBarItem(icon: Icon(Icons.category),label: "分类"),
    BottomNavigationBarItem(icon: Icon(Icons.shopping_cart),label: "购物车"),
    BottomNavigationBarItem(icon: Icon(Icons.person),label: "我的"),
  ];
}