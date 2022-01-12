import 'package:wanandroid/api/wan/bean/user_bean.dart';
import 'package:wanandroid/api/wan/wan_apis.dart';
import 'package:wanandroid/env/mvvm/statable_data.dart';
import 'package:wanandroid/env/mvvm/view_model.dart';

class UserBeanStatableData extends StatableData<UserBean?> {
  UserBeanStatableData() : super(null);
}

class MineViewModel extends ViewModel {
  final UserBeanStatableData userBean = UserBeanStatableData();

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
}
