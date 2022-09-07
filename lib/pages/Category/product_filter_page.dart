import 'package:flutter/material.dart';
import 'package:jdShop/tools/extension/color_extension.dart';
import 'package:jdShop/tools/extension/double_extension.dart';

import '../../pages/CustomWidgets/placeholder_image.dart';
import '../../tools/extension/int_extension.dart';
import '../../tools/share/const_config.dart';

class ProductFilterPage extends StatefulWidget {
  const ProductFilterPage({Key? key}) : super(key: key);

  @override
  State<ProductFilterPage> createState() => _ProductFilterPageState();
}

class _ProductFilterPageState extends State<ProductFilterPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width - 80.px,
      color: Colors.white,
      child: CustomScrollView(
        slivers: [
          const SliverAppBar(
            pinned: true,
            expandedHeight: 200.0,
            actions: [Text("")],
            flexibleSpace: FlexibleSpaceBar(
              title: Text("筛选"),
              background: PlaceholderImage(url:"https://t7.baidu.com/it/u=2763645735,2016465681&fm=193&f=GIF"),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 8.px,vertical: 16.px),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (ctx,idx) => Container(
                  height: 34.px,
                  decoration: BoxDecoration(
                    color: ColorExtension.lineColor,
                    borderRadius: BorderRadius.circular(17.px)
                  ),
                  alignment: Alignment.center,
                  child: Text("筛选条件",style: Theme.of(context).textTheme.headline3)
                ),
                childCount: 12
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10.px,
                crossAxisSpacing: 10.px,
                childAspectRatio: 3
              ),
            ),
          )
        ],
      ) ,
    );
  }
}
