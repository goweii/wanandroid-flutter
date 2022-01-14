import 'dart:io';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:wanandroid/api/com/bean/update_bean.dart';
import 'package:wanandroid/module/common/update/update_info.dart';

class UpdateUtils {
  /// 检查是否需要更新
  /// null: 不需要更新
  static Future<UpdateInfo?> parseUpdateInfo(UpdateBean updateBean) async {
    String platformUrl = _getPlatformUrl(updateBean);
    if (platformUrl.isEmpty) {
      return null;
    }
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    int buildNumber = int.tryParse(packageInfo.buildNumber) ?? 0;
    if (updateBean.versionCode <= buildNumber) {
      return null;
    }
    return UpdateInfo(
      url: platformUrl,
      versionCode: updateBean.versionCode,
      versionName: updateBean.versionName,
      desc: updateBean.desc,
      date: updateBean.date,
      force: updateBean.forceVersionCode > buildNumber,
    );
  }

  static String _getPlatformUrl(UpdateBean updateBean) {
    if (Platform.isAndroid) {
      return updateBean.androidUrl;
    }
    if (Platform.isIOS) {
      return updateBean.iosUrl;
    }
    return '';
  }
}
