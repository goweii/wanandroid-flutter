import 'package:shared_preferences/shared_preferences.dart';

class SearchViewModel {
  static const historySpKey = 'search_history';
  static const historyMaxSize = 100;

  Future<List<String>> saveSearchKey(String key) async {
    List<String> keys = [];
    SharedPreferences sp = await SharedPreferences.getInstance();
    var stringList = sp.getStringList(historySpKey);
    if (stringList != null) {
      keys.addAll(stringList);
    }
    if (key.isNotEmpty) {
      keys.remove(key);
      keys.insert(0, key);
      if (keys.length > historyMaxSize) {
        keys.removeRange(historyMaxSize, keys.length);
      }
      await sp.setStringList(historySpKey, keys);
    }
    return keys;
  }
}
