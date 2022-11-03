import 'package:flutter/material.dart';

import '../../tools/widgets/normal_button.dart';
import '../../tools/extension/int_extension.dart';
import '../../pages/Cart/models/address_model.dart';
import '../../pages/Cart/view_models/address_view_model.dart';
import 'address_add_page.dart';

class AddressListPage extends StatefulWidget {
  static const String routeName = "/addressList";
  const AddressListPage({Key? key}) : super(key: key);

  @override
  State<AddressListPage> createState() => _AddressListPageState();
}

class _AddressListPageState extends State<AddressListPage> {

  late List<AddressModel> addressList = [];

  @override
  void initState() {
    super.initState();

    getAddressList();
  }

  //获取地址列表
  void getAddressList() async{
    addressList = await AddressViewModel.addressList;
    setState(() {});
  }

  //跳转目标页
  void gotoTargetWidget() {
    Navigator.pushNamed(context, AddressAddPage.routeName).then((value) => refreshAddressList());
  }

  //刷新地址列表
  void refreshAddressList() {
    getAddressList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("地址选择"),
        leading: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(Icons.arrow_back_ios)
        ),
      ),
      body: buildContentWidget(),
    );
  }

  Widget buildContentWidget() {
    return Column(
      children: [
        Expanded(child: buildAddressListViewWidget()),
        SizedBox(height: 30.px),
        buildAddAddressButtonWidget()
      ],
    );
  }

  Widget buildAddressListViewWidget() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 8.px,horizontal: 10.px),
      itemCount: addressList.length,
      itemBuilder: (ctx,idx){
        AddressModel model = addressList[idx];
        return buildListViewItemWidget(model);
      },
    );
  }

  Widget buildListViewItemWidget(AddressModel model) {
    return Column(
      children: [
        InkWell(
          onTap: (){
            Navigator.of(context).pop(model);
          },
          child: SizedBox(
            height: 44.px,
            child: Row(
              children: [
                model.isDefault ? Icon(model.iconData, color: Colors.redAccent) : const Text(""),
                SizedBox(width: 10.px),
                Text(model.address ?? "", style: TextStyle(fontSize: 16.px))
              ]
            ),
          ),
        ),
        const Divider(height: 1)
      ],
    );
  }

  Widget buildAddAddressButtonWidget() {
    return Container(
      height: 88.px,
      padding: EdgeInsets.symmetric(horizontal: 15.px),
      alignment: Alignment.center,
      child: NormalButton(
        height: 44.px,
        title: "添加地址",
        textColor: Colors.white,
        backgroundColor: Colors.redAccent,
        onPressed: gotoTargetWidget,
      ),
    );
  }
}
