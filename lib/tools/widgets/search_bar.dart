import 'package:flutter/material.dart';

import '../../tools/storage/storage.dart';
import '../../tools/extension/color_extension.dart';
import '../../tools/extension/int_extension.dart';


typedef SearchClick = void Function(String? text);
const String kSearchKey = "kSearchKey";

//搜索导航栏
class SearchBar extends AppBar {
  SearchBar({
    Key? key,
    Widget? leading,
    Widget? title,
    Widget? clearIcon,
    List<Widget>? actions,
    String? placeholder,
    String? searchText,
    bool isEdit = true,
    bool isHiddenSearchText = true,
    VoidCallback? onTap,
    SearchClick? searchClick
  }) : assert(
        (title == null && actions == null) || (title != null && actions != null),
        'title 和 actions 必须同时提供或两者都不提供'
      ),
      super(
        key: key,
        leading: leading,
        title: title ?? SearchTitleWidget(
          isEdit: isEdit,
          placeholder: placeholder,
          clearIcon: clearIcon,
          onTap: onTap
        ),
        actions: actions ?? (isHiddenSearchText ? [] : [
          TextButton(
              onPressed: () async {
                if (searchClick != null) {
                  var search = await Storage.fetch<String>(kSearchKey);
                  searchClick("$search");
                }
              },
              child: isHiddenSearchText ? const Text("") : Text(searchText ?? "搜索",style: TextStyle(fontSize: 14.px, color: Colors.white))
          )
        ])
      );
}

class SearchTitleWidget extends StatefulWidget {
  const SearchTitleWidget({
    Key? key,
    this.isEdit = true,
    this.placeholder,
    this.clearIcon,
    this.onTap
  }) : super(key: key);

  final bool? isEdit;
  final Widget? clearIcon;
  final String? placeholder;
  final VoidCallback? onTap;

  @override
  State<SearchTitleWidget> createState() => _SearchTitleWidgetState();
}

class _SearchTitleWidgetState extends State<SearchTitleWidget> {

  GlobalKey<_SearchBarClearWidgetState> kSearchClearKey = GlobalKey();
  late final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    Storage.remove(kSearchKey);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 34.px,
      decoration: BoxDecoration(
        color: ColorExtension.lineColor,
        borderRadius: BorderRadius.circular(34.px)
      ),
      alignment: Alignment.center,
      child: widget.isEdit ?? true ? buildInputWidget() : buildStackWidget(),
    );
  }

  Widget buildInputWidget() {
    return Padding(
      padding: EdgeInsets.only(top: 2.px),
      child: TextField(
        controller: _controller,
        cursorColor: Colors.white,
        textAlignVertical: TextAlignVertical.center,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: widget.placeholder ?? "请输入需要搜索的内容",
          hintStyle: const TextStyle(color: Colors.white),
          prefixIcon: const Icon(Icons.search,color: Colors.white),
          suffixIcon: buildClearWidget(),
          suffixIconConstraints: BoxConstraints.expand(width: 34.px,height: 34.px),
          border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
          focusedBorder:const OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
          disabledBorder:const OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
          enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
          contentPadding:const EdgeInsets.symmetric(vertical: 0),
        ),
        onChanged: (text) {
          Storage.save<String>(kSearchKey, text);
          kSearchClearKey.currentState?.updateState(text.isEmpty);
        },
      ),
    );
  }

  Widget buildClearWidget() {
    return SearchBarClearWidget(
      key: kSearchClearKey,
      onTap: (){
        _controller.text = "";
        Storage.remove(kSearchKey);
        kSearchClearKey.currentState?.updateState(true);
      }
    );
  }

  Widget buildStackWidget() {
    return InkWell(
      onTap: widget.onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(left: 10.px, child: const Icon(Icons.search) ),
          Positioned(
            left: 34.px,
            child: Text(widget.placeholder ?? "请输入需要搜索的内容",style: TextStyle(fontSize: 14.px))
          ),
          // Positioned(right: 10.px, child: widget.clearIcon ?? const Icon(Icons.clear))
        ],
      ),
    );
  }
}

//清除按钮
class SearchBarClearWidget extends StatefulWidget {
 const SearchBarClearWidget({Key? key,this.isHidden,this.onTap}) : super(key: key);

  //是否需要隐藏
  final bool? isHidden;
  final VoidCallback? onTap;

  @override
  State<SearchBarClearWidget> createState() => _SearchBarClearWidgetState();
}

class _SearchBarClearWidgetState extends State<SearchBarClearWidget> {

  //是否需要隐藏clear btn,默认隐藏
  bool _isHidden = true;

  @override
  void initState() {
    super.initState();
    _isHidden = widget.isHidden ?? true;
  }

  void updateState(bool isNeedHidden) {
    setState(() => _isHidden = isNeedHidden);
  }

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: widget.onTap,
      child: _isHidden ? const Text("") : Padding(
        padding: EdgeInsets.only(bottom: 2.px),
        child: const Icon(Icons.clear, color: Colors.white),
      )
    );
  }
}

