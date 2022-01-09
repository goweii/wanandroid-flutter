import 'package:json_annotation/json_annotation.dart';

part 'user_coin_bean.g.dart';

@JsonSerializable()
class UserCoinBean {
  final int coinCount;
  final int level;
  final String rank;
  final int userId;
  final String nickname;
  final String username;

  UserCoinBean({
    required this.coinCount,
    required this.level,
    required this.rank,
    required this.userId,
    required this.nickname,
    required this.username,
  });

  factory UserCoinBean.fromJson(Map<String, dynamic> json) =>
      _$UserCoinBeanFromJson(json);

  Map<String, dynamic> toJson() => _$UserCoinBeanToJson(this);
}
