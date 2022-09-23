import 'package:flutter/material.dart';
import 'main_config.dart';

class MainPage extends StatefulWidget {
  static const String routeName = "/";
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>  {
  int _currentIdx = 3;
  late PageController controller = PageController(initialPage: _currentIdx);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        children: MainConfig.pages,
        onPageChanged: (idx) {
          setState(() => _currentIdx = idx);
        },
      ),
      bottomNavigationBar: buildSystemBottomNavigationBar(),
    );
  }

  Widget buildIndexedStack() {
    return IndexedStack(
      index: _currentIdx,
      children: MainConfig.pages,
    );
  }

  Widget buildSystemBottomNavigationBar() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(8),
      child: BottomNavigationBar(
        elevation: 0.0,
        fixedColor: Colors.redAccent,
        items: MainConfig.items,
        currentIndex: _currentIdx,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        onTap: (idx){
          setState(() => _currentIdx = idx);
          controller.jumpToPage(idx);
        },
      ),
    );
  }
}
