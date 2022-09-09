import 'package:flutter/material.dart';

import '../../tools/widgets/search_bar.dart';

class SearchPage extends StatelessWidget {
  static const String routeName = "/search";
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchBar(
        placeholder: "请输入需要搜索的内容",
        isHiddenSearchText: false,
        searchClick: (search){
          print("search === $search");
        },
      ),
      body: const Center(child: Text("搜索内容")),
    );
  }
}
