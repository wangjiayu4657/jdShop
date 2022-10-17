import 'dart:convert';

import '../../../tools/storage/storage.dart';
import '../../../pages/Cart/models/address_model.dart';


class AddressViewModel {
  static const String kAddressKey = "kAddressKey";

  static final List<AddressModel> _addressList = [];

  //保存地址
  static save(AddressModel model) {
    if (!_addressList.any((element) => element.address != model.address)) {
       _addressList.forEach((element) => element.isDefault = false);
       model.isDefault = true;
       _addressList.add(model);
    }

    //将模型数组映射成字符串数组
    List<String> tempList = _addressList.map((e) => e.toJson().toString()).toList();
    
    if(tempList.isNotEmpty){
      Storage.save<List<String>>(kAddressKey, tempList);
    }
  }

  //获取地址列表
  static Future<List<AddressModel>> get addressList async {
    List<String> temp = await Storage.fetchList(kAddressKey);
    var tempList = temp.map((e) => jsonDecode(e)).toList();
    var address = tempList.map((e) => AddressModel.fromJson(e)).toList();
    return address;
  }
}