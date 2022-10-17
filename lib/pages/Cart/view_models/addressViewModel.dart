import 'dart:convert';

import '../../../tools/storage/storage.dart';
import '../../../pages/Cart/models/address_model.dart';


class AddressViewModel {
  static const String kAddressKey = "kAddressKey";

  static clear() {
    Storage.remove(kAddressKey);
  }

  //改变
  static changeDefaultState(AddressModel model) async{
    var list = await AddressViewModel.addressList;
    for(AddressModel addressModel in list) {
      addressModel.isDefault = model.address == addressModel.address;
    }

    //将模型数组映射成字符串数组
    List<String> tempList = list.map((e) => jsonEncode(e.toJson())).toList();

    if(tempList.isNotEmpty){
      Storage.save<List<String>>(kAddressKey, tempList);
    }
  }

  //保存地址
  static save(AddressModel model) async {
    var temp = await AddressViewModel.addressList;
    if (temp.any((element) => element.address != model.address)) {
       temp.forEach((element) => element.isDefault = false);
       model.isDefault = true;
       temp.add(model);
    }

    //将模型数组映射成字符串数组
    List<String> tempList = temp.map((e) => jsonEncode(e.toJson())).toList();

    if(tempList.isNotEmpty){
      Storage.save<List<String>>(kAddressKey, tempList);
    }
  }

  //获取地址列表
  static Future<List<AddressModel>> get addressList async {
    List<String> temp = await Storage.fetchList(kAddressKey);
    var tempList = temp.map((e) => jsonDecode(e)).toList();
    var address = tempList.map((e) => AddressModel.fromJson(e)).toList();
    print("address === $address");
    return address;
  }

  static Future<AddressModel> get defaultModel async {
    var list = await AddressViewModel.addressList;
    return list.where((element) => element.isDefault).last;
  }
}