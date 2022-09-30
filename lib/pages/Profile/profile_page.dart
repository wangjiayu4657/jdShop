import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../tools/extension/int_extension.dart';
import '../../tools/extension/color_extension.dart';
import '../../pages/Login/models/user_model.dart';
import '../../pages/Login/pages/login_page.dart';
import '../../pages/Login/view_models/login_view_model.dart';
import '../../pages/Profile/setting_page.dart';


class ProfilePage extends StatefulWidget {
  static const String routeName = "/profile";
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => LoginViewModel(),
      child: Scaffold(
        body: Container(
          color: ColorExtension.bgColor,
          child: CustomScrollView(
            slivers: [
              buildAppBarSliver(),
              buildListViewSliver(),
            ],
          ),
        ),
      ),
    );
  }

  //构建tabBar组件
  Widget buildAppBarSliver() {
    return SliverAppBar(
      pinned: true,
      centerTitle: false,
      expandedHeight: 88.px,
      actions: [
        IconButton(
          onPressed: () => Navigator.pushNamed(context, SettingPage.routeName),
          icon:const Icon(Icons.settings)
        )
      ],
      flexibleSpace: FlexibleSpaceBar(
        title: Padding(
          padding: EdgeInsets.only(left: 12.px),
          child: Consumer<LoginViewModel>(
            builder: (context,viewModel,child){
            print("viewModel.isLogin == ${viewModel.isLogin}");
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  child!,
                  SizedBox(width: 8.px),
                  viewModel.isLogin ? buildUserInfoWidget(viewModel.loginModel) : buildLoginWidget(),
                ],
              );
            },
            child: const CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage("assets/images/user.png"),
            ),
          ),
        ),
        background: AspectRatio(
          aspectRatio: 16 / 9,
          child: Image.asset("assets/images/user_bg.jpg", fit: BoxFit.cover),
        ),
      ),
    );
  }

  //构建列表组件
  Widget buildListViewSliver() {
    return SliverList(
       delegate: SliverChildBuilderDelegate(
          (context,idx) => idx == 3 ? Container(color: ColorExtension.bgColor,height: 6.px) : buildListItemView(idx),
          childCount: 6
       )
    );
  }

  //构建列表item组件
  Widget buildListItemView(int idx) {
    List<String> titles = ["全部订单","待付款","待收货","","我的收藏","在线客服"];
    List<IconData?> icons = [Icons.receipt,Icons.payment_sharp,Icons.car_crash_sharp,null,Icons.favorite,Icons.people];
    List<Color?> colors = [Colors.redAccent,Colors.green,Colors.orangeAccent,null,Colors.redAccent,Colors.black87];
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          ListTile(
            title: Text(titles[idx],style: TextStyle(fontSize: 14.px,)),
            leading: Icon(icons[idx],color: colors[idx]),
            minLeadingWidth: 10,
            visualDensity: VisualDensity(vertical: -2.px,horizontal: -2.px),
          ),
          const Divider(height: 1)
        ],
      ),
    );
  }

  //构建登录组件
  Widget buildLoginWidget() {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, LoginPage.routeName),
      child: Text("登录/注册",style: TextStyle(fontSize: 12.px))
    );
  }

  //构建用户信息组件
  Widget buildUserInfoWidget(UserModel? model) {
    return Padding(
      padding: EdgeInsets.fromLTRB(4.px, 8.px, 0, 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("用户名: ${model?.username ?? ""}",style: TextStyle(fontSize: 12.px)),
          SizedBox(height: 2.px),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.abc,color: Colors.white),
              Text("普通会员",style: TextStyle(fontSize: 10.px))
            ],
          ),
        ],
      ),
    );
  }
}
