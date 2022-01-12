import 'package:shared_preferences/shared_preferences.dart';
import 'package:wanandroid/api/wan/bean/hot_key_bean.dart';
import 'package:wanandroid/api/wan/wan_apis.dart';
import 'package:wanandroid/env/mvvm/statable_data.dart';
import 'package:wanandroid/env/mvvm/view_model.dart';
import 'package:wanandroid/module/search/search_view_model.dart';

class HotKeyListData extends StatableData<List<HotKeyBean>> {
  HotKeyListData() : super([]);
}

class SearchHistoryViewModel extends ViewModel {
  final HotKeyListData hotKeyListData = HotKeyListData();

  Future<bool> getHotKey() async {
    if (hotKeyListData.isLoading) {
      return false;
    }
    hotKeyListData.toLoading();
    try {
      hotKeyListData.value = await WanApis.getHotKey();
      return true;
    } catch (_) {
      hotKeyListData.toError();
      return false;
    }
  }

  Future<List<String>> getSearchHistory() async {
    List<String> keys = [];
    SharedPreferences sp = await SharedPreferences.getInstance();
    var stringList = sp.getStringList(SearchViewModel.historySpKey);
    if (stringList != null) {
      keys.addAll(stringList);
    }
    return keys;
  }
}
