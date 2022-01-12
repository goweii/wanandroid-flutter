import 'package:wanandroid/api/wan/wan_apis.dart';
import 'package:wanandroid/env/mvvm/view_model.dart';
import 'package:wanandroid/env/provider/login.dart';
import 'package:wanandroid/env/provider/unread.dart';

class MainViewModel extends ViewModel {
  Future<void> updateUnreadMsgCount() async {
    if (!LoginState().isLogin) {
      UnreadModel().unreadMsgCount = 0;
      return;
    }
    try {
      var data = await WanApis.getUnreadMessageCount();
      UnreadModel().unreadMsgCount = data;
    } catch (_) {}
  }
}
