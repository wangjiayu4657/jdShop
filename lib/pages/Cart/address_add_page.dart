import 'package:flutter/material.dart';
import 'package:city_pickers/city_pickers.dart';
import 'package:jdShop/pages/Cart/view_models/addressViewModel.dart';

import '../../../tools/widgets/input.dart';
import '../../../tools/widgets/normal_button.dart';
import '../../../tools/extension/int_extension.dart';
import '../../../tools/extension/object_extension.dart';
import '../../../pages/Cart/models/address_model.dart';

class AddressAddPage extends StatefulWidget {
  static const String routeName = "/addressAdd";
  const AddressAddPage({Key? key}) : super(key: key);

  @override
  State<AddressAddPage> createState() => _AddressAddPageState();
}

class _AddressAddPageState extends State<AddressAddPage> {

  late String addressDetail = "";
  late AddressModel model = AddressModel();


  // 通过钩子事件, 主动唤起浮层.
  void getResult () async {
    Result? result = await CityPickers.showCityPicker(context: context);
    setState(() {
      model.address = "${result?.provinceName} ${result?.cityName} ${result?.areaName}";
    });
  }

  //判空处理
  bool checkInfoIsEmpty() {
    if(model.name == null){
      print("name ==  ${model.name}");
      showToast("请先输入收件人名称");
      return false;
    } else if(model.tel == null) {
      print("tel ==  ${model.tel}");
      showToast("请先输入收件人电话");
      return false;
    } else if(model.address == null || model.address == "省/市/区"){
      print("address ==  ${model.address}");
      showToast("请先选择省市区");
      return false;
    }

    if(addressDetail.isNotEmpty){
      model.address = "${model.address} $addressDetail";
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("添加地址")),
      body: buildListViewWidget(),
    );
  }

  Widget buildListViewWidget() {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 15.px,vertical: 8.px),
      children: [
        buildNameOrTelItemWidget("姓名"),
        const Divider(height: 1),
        buildNameOrTelItemWidget("电话"),
        const Divider(height: 1),
        buildAddressItemWidget(),
        const Divider(height: 1),
        buildDetailAddressWidget(),
        const Divider(height: 1),
        SizedBox(height: 60.px),
        buildAddButtonWidget()
      ],
    );
  }

  //收件人姓名
  Widget buildNameOrTelItemWidget(String text) {
    return Row(
      textBaseline: TextBaseline.ideographic,
      children: [
        Text("收件人$text: ",style: TextStyle(fontSize: 16.px)),
        SizedBox(width: 5.px),
        Expanded(child: Input(
          placeholder: "请输入收件人$text",
          textOffset: 0.06,
          valueCallBack: (val) {
            if(text == "姓名"){
              model.name = val;
            } else {
              model.tel = val;
            }
          })
        )
      ],
    );
  }


  Widget buildAddressItemWidget() {
    return SizedBox(
      height: 44.px,
      child: Row(
        children: [
          const Icon(Icons.location_on_outlined),
          InkWell(
            onTap: getResult,
            child: Text(model.address ?? "省/市/区",style: TextStyle(fontSize: 16.px)),
          )
        ],
      ),
    );
  }

  Widget buildDetailAddressWidget() {
    return SizedBox(
      height: 80.px,
      child: Input(
        placeholder: "详细地址",
        maxLines: null,
        valueCallBack: (detail){
          addressDetail = detail;
        },
      ),
    );
  }

  Widget buildAddButtonWidget() {
    return NormalButton(
      title: "增加",
      textColor: Colors.white,
      backgroundColor: Colors.redAccent,
      onPressed: (){
        if(checkInfoIsEmpty()) {
          AddressViewModel.save(model);
          Navigator.pop(context);
        }
      },
    );
  }
}
