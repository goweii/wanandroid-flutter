import 'package:wanandroid/api/com/bean/about_me_bean.dart';
import 'package:wanandroid/api/com/bean/update_bean.dart';
import 'package:wanandroid/api/com/com_api.dart';
import 'package:wanandroid/env/http/api.dart';

class ComApis {
  static Future<AboutMeBean> getAboutMeInfo() async {
    return await ComApi(
      method: HttpMethod.get,
      path: '/aboutme/about_me.json',
      fromJsonT: (json) => AboutMeBean.fromJson(json),
    ).request();
  }

  static Future<UpdateBean> getUpdateInfo() async {
    return await ComApi(
      method: HttpMethod.get,
      path: '/update/update.json',
      fromJsonT: (json) => UpdateBean.fromJson(json),
    ).request();
  }
}
