import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../tools/extension/int_extension.dart';
import '../../../pages/Cart/widgets/stepper.dart' as step;
import '../../../tools/widgets/shopping_button.dart';
import '../../Cart/view_models/cart_services.dart';
import '../models/product_detail_model.dart';
import '../view_models/product_detail_view_model.dart';

// 加入购物车/购买时的商品条件筛选组件
class ProductFilter extends StatefulWidget {
  const ProductFilter({Key? key,this.model}) : super(key: key);

  final ProductDetailModel? model;

  @override
  State<ProductFilter> createState() => _ProductFilterState();
}

class _ProductFilterState extends State<ProductFilter> {

  //获取加入购物车时的数量
  void valueChange(int count){
    debugPrint("count == $count");
    widget.model?.count = count;
  }


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pop(),
      child: Container(
        color: Colors.black26,
        alignment: Alignment.bottomCenter,
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 20.px),
          child: SingleChildScrollView(
            child: Column(
              children: [
                buildFilterSheetContentWidget(),
                buildStepperWidget(),
                SizedBox(height: 50.px),
                buildFilterSheetButtonWidget()
              ],
            ),
          ),
        ),
      ),
    );
  }

  //构建底部筛选条件-标题组件
  Widget buildFilterSheetTitleWidget(String title) {
    return Container(
      width: 80.px,
      padding: EdgeInsets.symmetric(vertical: 8.px),
      alignment: Alignment.center,
      child: Text(title,textAlign: TextAlign.start,style: Theme.of(context).textTheme.bodyText1),
    );
  }

  //构建底部筛选条件内容组件
  Widget buildFilterSheetContentWidget() {
    List<FilterModel> items = widget.model?.filters ?? [];
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: items.map((model) => buildFilterSheetItemsWidget(model.cate, model.items)).toList(),
    );
  }

  //构建底部筛选条件-条件组件
  Widget buildFilterSheetItemsWidget(String? title,List<FilterItemModel>? itemModels) {
    List<FilterItemModel>? items = itemModels ?? [];
    return Wrap(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildFilterSheetTitleWidget(title ?? ""),
            Expanded(
              child: Wrap(
                  spacing: 10.px,
                  children: items.map((model) => buildFilterSheetItemWidget(model)).toList()
              ),
            )
          ],
        )
      ],
    );
  }

  //构建底部筛选条件-条件子(item)组件
  Widget buildFilterSheetItemWidget(FilterItemModel itemModel) {
    return Consumer<ProductDetailViewModel>(
      builder: (context,viewModel,child){
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => viewModel.changeFilterItemModelState(itemModel),
          child: Chip(
            backgroundColor: itemModel.bgColor,
            padding: EdgeInsets.symmetric(horizontal: 8.px),
            visualDensity: VisualDensity(vertical: -1.px),
            label: Text(itemModel.item ?? ""),
            labelStyle: TextStyle(color: itemModel.textColor,fontSize: 12.px,fontWeight: FontWeight.normal),
          ),
        );
      },
    );
  }

  Widget buildStepperWidget() {
    return Container(
      height: 50.px,
      padding: EdgeInsets.only(left: 25.px),
      child: Row(
        children: [
          Text("数量",textAlign: TextAlign.start,style: Theme.of(context).textTheme.bodyText1),
          SizedBox(width: 15.px),
          step.Stepper(callBack: (count) => valueChange(count)),
        ],
      ),
    );
  }

  //构建底部筛选条件-按钮组件
  Widget buildFilterSheetButtonWidget() {
    return Container(
      padding: EdgeInsets.all(10.px),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ShoppingButton(
                title: "加入购物车",
                backgroundColor: Colors.redAccent,
                onPressed: (){
                  debugPrint("加入购物车");
                  debugPrint(widget.model?.filter);
                  CartServices.addProduct(widget.model);
                  Navigator.pop(context);
                }
            ),
          ),
          Expanded(
            child: ShoppingButton(
                title: "立即购买",
                backgroundColor: Colors.orange,
                onPressed: (){
                  debugPrint("立即购买");
                  debugPrint(widget.model?.filter);
                  Navigator.pop(context);
                }
            ),
          )
        ],
      ),
    );
  }
}
