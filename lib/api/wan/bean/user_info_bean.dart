import 'package:json_annotation/json_annotation.dart';

part 'user_info_bean.g.dart';

@JsonSerializable()
class UserInfoBean {
  bool admin;
  List<dynamic> chapterTops;
  int coinCount;
  List<int> collectIds;
  String email;
  String icon;
  int id;
  String nickname;
  String password;
  String publicName;
  String token;
  int type;
  String username;

  UserInfoBean({
    required this.admin,
    required this.chapterTops,
    required this.coinCount,
    required this.collectIds,
    required this.email,
    required this.icon,
    required this.id,
    required this.nickname,
    required this.password,
    required this.publicName,
    required this.token,
    required this.type,
    required this.username,
  });

  factory UserInfoBean.fromJson(Map<String, dynamic> json) =>
      _$UserInfoBeanFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoBeanToJson(this);
}
