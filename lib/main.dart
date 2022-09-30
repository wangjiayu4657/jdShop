import 'package:flutter/material.dart';
import 'package:jdShop/tools/share/provider_service.dart';
import 'package:provider/provider.dart';

import 'pages/Main/main_page.dart';
import '../../tools/theme/theme_config.dart';
import '../../tools/Router/router_config.dart';

void main() {
  runApp(const MyApp());
  //  runApp(
  //   MultiProvider(
  //     providers: ProviderService.providers,
  //     child: const MyApp(),
  //   ),
  // );
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

