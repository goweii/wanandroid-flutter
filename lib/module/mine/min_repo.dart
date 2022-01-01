import 'package:wanandroid/api/bean/user_bean.dart';
import 'package:wanandroid/api/wan_apis.dart';

class MineRepo {
  Future<UserBean> userinfo() {
    return WanApis.userinfo();
  }
}
