import 'package:flutter/material.dart';
import 'main_config.dart';

class MainPage extends StatefulWidget {
  static const String routeName = "/";
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIdx = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIdx,
        children: MainConfig.pages,
      ),
      bottomNavigationBar: buildSystemBottomNavigationBar(),
    );
  }

  Widget buildSystemBottomNavigationBar() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(8),
      child: BottomNavigationBar(
        elevation: 0.0,
        fixedColor: Colors.blue,
        items: MainConfig.items,
        currentIndex: _currentIdx,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        onTap: (idx){
          setState(() => _currentIdx = idx);
        },
      ),
    );
  }
}
