import 'package:flutter/material.dart';
import '../../../tools/storage/storage.dart';


class SearchViewModel extends ChangeNotifier {
  late List<String> _historyItems = [];
  static const String _searchKey = "searchKey";

  SearchViewModel() {
    getHistoryRecordItems();
  }

  List<String> get historyItems => _historyItems;

  void getHistoryRecordItems() async {
    _historyItems = await Storage.fetchList(_searchKey);
    notifyListeners();
  }

  //保存一条搜索内容
  void saveSearchContent(String? searchText) async{
    if(searchText == null) return;
    _historyItems = await Storage.fetchList(_searchKey);
    if (_historyItems.contains(searchText) == false) {
      _historyItems.add(searchText);
      notifyListeners();
    }
    Storage.save<List<String>>(_searchKey, _historyItems);
  }

  //删除一条历史记录
  void removeHistoryRecordItems(String searchRecord) async {
    _historyItems = await Storage.fetchList(_searchKey);
    _historyItems.remove(searchRecord);
    notifyListeners();
    Storage.save<List<String>>(_searchKey, _historyItems);
  }

  //清除历史记录
  void clearHistoryRecord() async {
    _historyItems = await Storage.fetchList(_searchKey);
    _historyItems.clear();
    notifyListeners();
    Storage.save<List<String>>(_searchKey, _historyItems);
  }
}