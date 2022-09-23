import 'package:flutter/material.dart';
import 'package:jdShop/pages/CustomWidgets/placeholder_image.dart';
import 'package:jdShop/pages/Login/pages/login_page.dart';
import 'package:jdShop/tools/extension/color_extension.dart';
import 'package:jdShop/tools/extension/int_extension.dart';


class ProfilePage extends StatefulWidget {
  static const String routeName = "/profile";
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: ColorExtension.bgColor,
        child: CustomScrollView(
          slivers: [
            buildAppBarSliver(),
            buildListViewSliver(),
          ],
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
      flexibleSpace: FlexibleSpaceBar(
        title: Padding(
          padding: EdgeInsets.only(left: 12.px),
          child: Row(
            children: [
              const CircleAvatar(
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage("assets/images/user.png"),
              ),
              SizedBox(width: 8.px),
              InkWell(
                onTap: () => Navigator.pushNamed(context, LoginPage.routeName),
                child: Text("登录/注册",style: TextStyle(fontSize: 12.px))
              ),
            ],
          ),
        ),
        background: AspectRatio(
          aspectRatio: 16 / 9,
          child: Image.asset("assets/images/user_bg.jpg", fit: BoxFit.cover),
        ),
      ),
    );
  }

  Widget buildListViewSliver() {
    return SliverList(
       delegate: SliverChildBuilderDelegate(
          (context,idx) {
            return idx == 3 ? Container(color: ColorExtension.bgColor,height: 8.px) :  buildListItemView(idx);
          },
          childCount: 6
       )
    );
  }

  //
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
}
