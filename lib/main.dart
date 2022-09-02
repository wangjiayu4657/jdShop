import 'package:flutter/material.dart';

import 'pages/Main/main_page.dart';
import '../../tools/theme/theme_config.dart';
import '../../tools/Router/router_config.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeConfig.normalTheme,
      darkTheme: ThemeConfig.darkTheme,
      initialRoute: MainPage.routeName,
      onGenerateRoute: RouterConfig.onGenerateRoute,
    );
  }
}

