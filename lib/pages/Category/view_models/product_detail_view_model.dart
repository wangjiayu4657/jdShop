import 'package:flutter/material.dart';

import '../../../tools/http/http_client.dart';
import '../models/product_detail_model.dart';

class ProductDetailViewModel extends ChangeNotifier {
  ProductDetailViewModel({
    this.id
  });

  String? id;

  ProductDetailModel? _model;
  ProductDetailModel? get model => _model;

  late final List<String> _filterItems = [];
  String get filterItem => _filterItems.join(",");


  //获取详情数据
  Future<ProductDetailModel?> detailDataRequest() async {
    var result = await HttpClient.request(url: "api/pcontent?id=$id");
    var json = result["result"];
    if(json is Map<String,dynamic>){
      _model = ProductDetailModel.fromJson(json);
      _initSelectData();
    }
    notifyListeners();
    return _model;
  }

  //改变选中状态
  void changeFilterItemModelState(FilterItemModel filterItemModel){
    filterItemModel.isSelected = !filterItemModel.isSelected;
    _saveSelectedFilterItem(filterItemModel);
    notifyListeners();
  }

  //保存选中的数据
  void _saveSelectedFilterItem(FilterItemModel? itemModel) {
    _filterItems.retainWhere((element) => element != itemModel?.item);

    if(itemModel?.isSelected ?? false){
      _filterItems.add(itemModel?.item ?? "");
    }
  }

  //初始化默认选中的数据
  void _initSelectData() {
    List<FilterModel> filters = model?.filters ?? [];
    for(FilterModel filterModel in filters){
      FilterItemModel? itemModel = filterModel.items?.first;
      itemModel?.isSelected = true;
      _saveSelectedFilterItem(itemModel);
    }
  }
}