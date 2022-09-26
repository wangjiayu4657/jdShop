import 'package:flutter/material.dart';

import '../../pages/Home/home_page.dart';
import '../../pages/Main/main_page.dart';
import '../../pages/Cart/cart_page.dart';
import '../../pages/Login/pages/login_page.dart';
import '../../pages/Category/category_page.dart';
import '../../pages/Profile/profile_page.dart';
import '../../pages/Other/unknown_page.dart';
import '../../pages/Other/search_page.dart';
import '../../pages/Category/product_detail_page.dart';
import '../../pages/Category/category_product_page.dart';
import '../../pages/Login/pages/register_first_page.dart';
import '../../pages/Login/pages/register_second_page.dart';

class RouterConfig {
  static Map<String, WidgetBuilder> routes = {
    MainPage.routeName: (ctx) => const MainPage(),
    HomePage.routeName: (ctx) => const HomePage(),
    CategoryPage.routeName: (ctx) => const CategoryPage(),
    CartPage.routeName: (ctx) => const CartPage(),
    ProfilePage.routeName: (ctx) => const ProfilePage(),
    SearchPage.routeName: (ctx) => const SearchPage(),
    LoginPage.routeName: (ctx) => const LoginPage(),
    RegisterFirstPage.routeName: (ctx) => const RegisterFirstPage(),
    RegisterSecondPage.routeName: (ctx) => const RegisterSecondPage(),
    CategoryProductPage.routeName : (ctx,{ arguments }) => CategoryProductPage(argument: arguments),
    ProductDetailPage.routeName : (ctx,{ arguments }) => ProductDetailPage(id: arguments)

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

