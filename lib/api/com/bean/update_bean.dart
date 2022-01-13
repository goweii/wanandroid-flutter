import 'package:json_annotation/json_annotation.dart';

part 'update_bean.g.dart';

@JsonSerializable()
class UpdateBean {
  @JsonKey(name: 'android_url')
  final String androidUrl;
  @JsonKey(name: 'ios_url')
  final String iosUrl;
  @JsonKey(name: 'version_code')
  final int versionCode;
  @JsonKey(name: 'version_name')
  final String versionName;
  final String desc;
  final String date;
  @JsonKey(name: 'force_version_code')
  final int forceVersionCode;
  @JsonKey(name: 'force_version_name')
  final String forceVersionName;

  UpdateBean({
    required this.androidUrl,
    required this.iosUrl,
    required this.versionCode,
    required this.versionName,
    required this.desc,
    required this.date,
    required this.forceVersionCode,
    required this.forceVersionName,
  });

  factory UpdateBean.fromJson(Map<String, dynamic> json) =>
      _$UpdateBeanFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateBeanToJson(this);
}
