import 'package:json_annotation/json_annotation.dart';

part 'about_me_bean.g.dart';

@JsonSerializable()
class AboutMeBean {
  final String avatar;
  final String nickname;
  final String signature;
  final String github;
  @JsonKey(name: 'qq_group')
  final String qqGroup;
  @JsonKey(name: 'qq_group_key')
  final String qqGroupKey;
  @JsonKey(name: 'wx_qrcode')
  final String wxQrcode;
  @JsonKey(name: 'zfb_qrcode')
  final String zfbQrcode;

  AboutMeBean({
    required this.avatar,
    required this.nickname,
    required this.signature,
    required this.github,
    required this.qqGroup,
    required this.qqGroupKey,
    required this.wxQrcode,
    required this.zfbQrcode,
  });

  factory AboutMeBean.fromJson(Map<String, dynamic> json) =>
      _$AboutMeBeanFromJson(json);

  Map<String, dynamic> toJson() => _$AboutMeBeanToJson(this);
}
