import 'package:package_info_plus/package_info_plus.dart';
import 'package:wanandroid/api/com/com_apis.dart';
import 'package:wanandroid/env/l10n/generated/l10n.dart';
import 'package:wanandroid/env/mvvm/statable_data.dart';
import 'package:wanandroid/env/mvvm/view_model.dart';
import 'package:wanandroid/module/common/update/update_info.dart';
import 'package:wanandroid/module/common/update/update_utils.dart';

class AppInfo {
  final String appName;
  final String versionName;
  final int buildNumber;

  AppInfo({
    required this.appName,
    required this.versionName,
    required this.buildNumber,
  });
}

class AppInfoStatableData extends StatableData<AppInfo?> {
  AppInfoStatableData() : super(null);
}

class UpdateInfoStatableData extends StatableData<UpdateInfo?> {
  UpdateInfoStatableData() : super(null);
}

class AboutViewModel extends ViewModel {
  final AppInfoStatableData appInfoStatableData = AppInfoStatableData();
  final UpdateInfoStatableData updateInfoStatableData =
      UpdateInfoStatableData();

  Future<void> getAppInfo() async {
    appInfoStatableData.toLoading();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appInfoStatableData.value = AppInfo(
      appName: packageInfo.appName,
      versionName: packageInfo.version,
      buildNumber: int.tryParse(packageInfo.buildNumber) ?? 0,
    );
  }

  Future<void> checkUpdate() async {
    updateInfoStatableData.toLoading();
    try {
      var updateBean = await ComApis.getUpdateInfo();
      var updateInfo = await UpdateUtils.parseUpdateInfo(updateBean);
      if (updateInfo == null) {
        throw Strings.current.already_the_latest_version;
      }
      updateInfoStatableData.value = updateInfo;
    } catch (e) {
      updateInfoStatableData.toError();
    }
  }
}
