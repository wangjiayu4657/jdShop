import 'package:flutter/material.dart';

import '../../pages/Home/home_page.dart';
import '../../pages/Main/main_page.dart';
import '../../pages/Cart/cart_page.dart';
import '../../pages/Category/category_page.dart';
import '../../pages/Profile/profile_page.dart';
import '../../pages/Other/unknown_page.dart';

class RouterConfig {
  static Map<String, WidgetBuilder> routes = {
    MainPage.routeName: (ctx) => const MainPage(),
    HomePage.routeName: (ctx) => const HomePage(),
    CategoryPage.routeName: (ctx) => const CategoryPage(),
    CartPage.routeName: (ctx) => const CartPage(),
    ProfilePage.routeName: (ctx) => const ProfilePage(),
  };

  //统一处理
  static RouteFactory onGenerateRoute = (RouteSettings setting) {
    final String? name = setting.name;
    final Function? pageContentBuilder = routes[name];
    if (pageContentBuilder == null) return null;
    if (setting.arguments != null) {
      return MaterialPageRoute(builder: (context) => pageContentBuilder(context, arguments: setting.arguments));
    } else {
      return MaterialPageRoute(builder: (context) => pageContentBuilder(context));
    }
  };

  static RouteFactory onUnknownRoute = (setting){
    return MaterialPageRoute(builder: (ctx) => const UnknownPage());
  };
}

