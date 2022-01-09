import 'package:wanandroid/api/wan/wan_apis.dart';
import 'package:wanandroid/api/wan/wan_store.dart';

class SettingsRepo {
  Future<dynamic> logout() async {
    try {
      await WanApis.logout();
    } catch (_) {
      await WanStore().logout();
    }
  }
}
