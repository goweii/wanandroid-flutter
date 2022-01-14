class UpdateInfo {
  final String url;
  final int versionCode;
  final String versionName;
  final String desc;
  final String date;
  final bool force;

  UpdateInfo({
    required this.url,
    required this.versionCode,
    required this.versionName,
    required this.desc,
    required this.date,
    required this.force,
  });
}
