import 'package:wanandroid/api/bean/user_bean.dart';
import 'package:wanandroid/api/wan_apis.dart';
import 'package:wanandroid/env/mvvm/statable_data.dart';
import 'package:wanandroid/env/mvvm/view_model.dart';

class UserBeanStatableData extends StatableData<UserBean?> {
  UserBeanStatableData() : super(null);
}

class UnreadMessageCountStatableData extends StatableData<int> {
  UnreadMessageCountStatableData() : super(0);
}

class MineViewModel extends ViewModel {
  final UserBeanStatableData userBean = UserBeanStatableData();
  final UnreadMessageCountStatableData unreadMessageCount = UnreadMessageCountStatableData();

  void clearUserInfo() {
    userBean.value = null;
  }

  Future<bool> getUserInfo() async {
    userBean.toLoading();
    try {
      var data = await WanApis.getUserInfo();
      userBean.value = data;
      return true;
    } catch (_) {
      userBean.toError();
      return false;
    }
  }

  void clearUnreadMessageCount() {
    unreadMessageCount.value = 0;
  }

  Future<bool> getUnreadMessageCount() async {
    unreadMessageCount.toLoading();
    try {
      var data = await WanApis.getUnreadMessageCount();
      unreadMessageCount.value = data;
      return true;
    } catch (_) {
      unreadMessageCount.toError();
      return false;
    }
  }
}
