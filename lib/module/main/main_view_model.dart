import 'package:wanandroid/api/com/com_apis.dart';
import 'package:wanandroid/api/wan/wan_apis.dart';
import 'package:wanandroid/env/l10n/generated/l10n.dart';
import 'package:wanandroid/env/mvvm/view_model.dart';
import 'package:wanandroid/env/provider/login.dart';
import 'package:wanandroid/env/provider/unread.dart';
import 'package:wanandroid/module/common/update/update_info.dart';
import 'package:wanandroid/module/common/update/update_utils.dart';

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

  Future<UpdateInfo> checkUpdate() async {
    try {
      var updateBean = await ComApis.getUpdateInfo();
      var updateInfo = await UpdateUtils.parseUpdateInfo(updateBean);
      if (updateInfo == null) {
        throw Strings.current.already_the_latest_version;
      }
      return updateInfo;
    } catch (e) {
      rethrow;
    }
  }
}
