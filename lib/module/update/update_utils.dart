import 'package:package_info_plus/package_info_plus.dart';
import 'package:wanandroid/api/com/bean/update_bean.dart';
import 'package:wanandroid/module/update/update_info.dart';

class UpdateUtils {
  /// 检查是否需要更新
  /// null: 不需要更新
  static Future<UpdateInfo?> parseUpdateInfo(UpdateBean updateBean) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    int buildNumber = int.tryParse(packageInfo.buildNumber) ?? 0;
    if (updateBean.versionCode <= buildNumber) {
      return null;
    }
    return UpdateInfo(
      androidUrl: updateBean.androidUrl,
      iosUrl: updateBean.iosUrl,
      versionCode: updateBean.versionCode,
      versionName: updateBean.versionName,
      desc: updateBean.desc,
      date: updateBean.date,
      force: updateBean.forceVersionCode > buildNumber,
    );
  }
}
