class UpdateInfo {
  final String androidUrl;
  final String iosUrl;
  final int versionCode;
  final String versionName;
  final String desc;
  final String date;
  final bool force;

  UpdateInfo({
    required this.androidUrl,
    required this.iosUrl,
    required this.versionCode,
    required this.versionName,
    required this.desc,
    required this.date,
    required this.force,
  });
}
