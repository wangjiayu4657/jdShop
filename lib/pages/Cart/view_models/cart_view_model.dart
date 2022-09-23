import 'dart:convert';
import 'package:flutter/material.dart';


import '../../../tools/storage/storage.dart';
import '../../../tools/extension/object_extension.dart';
import '../../../pages/Cart/view_models/cart_services.dart';
import '../../../pages/Category/models/product_detail_model.dart';


class CartViewModel extends ChangeNotifier {
  late String totalPrice = "0.0";
  late List<ProductDetailModel> products = [];
  late bool isAllChecked = false;

  CartViewModel(){
    cartProductDataFromStorage();
  }

  //获取购物车数据
  void cartProductDataFromStorage() async {
    if(CartServices.products.isNotEmpty) {
      products = CartServices.products;
    } else {
      List<String>? carts = await Storage.fetchList(CartServices.kCartsKey);
      List<Map<String, dynamic>>? tempCarts = carts.map((e) => json.decode(e) as Map<String,dynamic>).toList();
      products = tempCarts.map((e) => ProductDetailModel.fromJson(e)).toList();
    }

    notifyListeners();
  }

  //改变商品数量
  void changeProductCount(int count,ProductDetailModel model) {
    model.count = count;
    calculatorTotalPrice();
    notifyListeners();
  }

  //单选
  void selectedProduct(){
    isAllChecked = products.where((element) => !element.isChecked).isEmpty;
    calculatorTotalPrice();
    notifyListeners();
  }

  //全选
  void allSelected(bool isChecked) {
    products.forEach((element) => element.isChecked = isChecked);
    calculatorTotalPrice();
    notifyListeners();
  }

  //删除购物车商品
  void deleteProduct() {
    products.retainWhere((element) => !element.isChecked);
    calculatorTotalPrice();
    saveProducts();
    notifyListeners();
  }

  //购买保存商品
  void saveProducts() {
    var productList = products.map((e) => productDetailModelToJson(e)).toList();
    CartServices.saveProducts(productList);
  }

  //计算选中商品的总价
  void calculatorTotalPrice() {
    double total = 0.0;
    total = products.where((element) => element.isChecked)
           .fold<double>(0, (previousValue, element) => previousValue + mapToDouble(element.price) * element.count);
    totalPrice = "$total";
  }
}