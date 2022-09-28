import 'package:flutter/material.dart';
import 'package:jdShop/tools/widgets/normal_button.dart';

import 'models/setting_model.dart';
import '../../tools/json_parse/json_parse.dart';
import '../../tools/extension/int_extension.dart';
import '../../tools/extension/color_extension.dart';

class SettingPage extends StatefulWidget {
  static const String routeName = "/setting";
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {

  late List<SettingModel> items = [];

  @override
  void initState() {
    super.initState();
    loadSettingData();
  }

  void loadSettingData() async {
    var result = await JsonParse.loadSettingItemFromFile("assets/jsons/setting_item.json");
    setState(() => items = result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("设置")),
      body: Container(
        color: ColorExtension.bgColor,
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context,idx){
            return idx == 7 ? buildLogoutButtonWidget(items[idx]) : buildListViewItem(items[idx]);
          }
        ),
      ),
    );
  }

  Widget buildListViewItem(SettingModel model) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          ListTile(
            leading: Icon(model.iconData,color: Colors.redAccent),
            title: Text(model.title ?? ""),
            trailing: Icon(Icons.arrow_forward_ios,size: 16.px),
            minLeadingWidth: 10.px,
            visualDensity: const VisualDensity(horizontal: -4),
            onTap: (){
              print("model.title == ${model.title}");
            },
          ),
          Container(height: model.height,color: ColorExtension.bgColor),
        ],
      ),
    );
  }

  Widget buildLogoutButtonWidget(SettingModel model) {
    return Padding(
      padding: EdgeInsets.all(15.px),
      child: NormalButton(
        title: model.title,
        height: model.height,
        backgroundColor: Colors.redAccent,
        style: TextStyle(color: Colors.white,fontSize: 16.px,fontWeight: FontWeight.bold),
        onPressed: (){
          print("退出登录");
        },
      ),
    );
  }
}
