import 'package:flutter/material.dart';
import 'package:jdShop/tools/extension/int_extension.dart';
import 'package:jdShop/tools/widgets/after_layout.dart';

import '../../tools/extension/color_extension.dart';
import '../../tools/share/const_config.dart';

class ProfilePage extends StatefulWidget {
  static const String routeName = "/profile";
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final List<String> _hotItems = ["超级秒杀","办公用品","儿童小汽车","超级秒杀","办公用品","儿童小汽车","唇彩唇蜜","装修专用耗材","地板","超级秒杀","办公用品","儿童小汽车","唇彩唇蜜","装修专用耗材","地板"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("我的")),
      body: buildTestStackWidget(),
    );
  }

  Widget buildTestStackWidget() {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: 200.px,
          child: Container(
            color: Colors.red,
          ),
        ),
        AfterLayout(callback: (ral){
          print("size == ${ral.size}, offset === ${ral.offset}");
        },
          child: Positioned(
            top: 0,
            height: 10.px,
            child: Container(color: Colors.blue),
          ),
        ),
        Positioned(
          top: 80.px,
          left: 0,
          right: 0,
          height: 200.px,
          child: Container(
            color: Colors.green,
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          // height: 200.px,
          child: Container(
            height: 300.px,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }

  Widget buildTestContainerWidget() {
    return Container(
      width: width,
      height: 88.px,
      color: Colors.red,
      alignment: Alignment.center,
      padding: EdgeInsets.only(bottom: 15.px),
      child: InkWell(
        onTap: (){},
        child: Container(
          width: width - 40.px,
          height: 48.px,
          decoration: BoxDecoration(
            color: Colors.green,
            border: Border.all(color: ColorExtension.lineColor),
            borderRadius: BorderRadius.circular(4.px),
          ),
          // alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.delete),
              Text("清空历史记录")
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTestWidget() {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: 250.px,
      ),
      child: Container(
        color: Colors.white,
        child: ListView(
          shrinkWrap: true,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10.px),
                ),
                Wrap(
                    alignment: WrapAlignment.start,
                    runAlignment: WrapAlignment.start,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    runSpacing: 10.px,
                    spacing: 7.px,
                    children: List.generate(_hotItems.length,(index) => Text(_hotItems[index]))
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
