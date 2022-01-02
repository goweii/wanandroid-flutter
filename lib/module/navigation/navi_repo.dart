import 'package:wanandroid/api/bean/navi_bean.dart';
import 'package:wanandroid/api/wan_apis.dart';

class NaviRepo {
  Future<List<NaviBean>> getNavi() async {
    return await WanApis.getNavi();
  }
}
