import 'package:json_annotation/json_annotation.dart';

part 'user_coin_bean.g.dart';

@JsonSerializable()
class UserCoinBean {
  final int coinCount;
  final int level;
  final String nickname;
  final String rank;
  final int userId;
  final String username;

  UserCoinBean({
    required this.coinCount,
    required this.level,
    required this.nickname,
    required this.rank,
    required this.userId,
    required this.username,
  });

  String get nameToShow {
    if (nickname.isNotEmpty) {
      return nickname;
    }
    if (username.isNotEmpty) {
      return username;
    }
    return '$userId';
  }

  factory UserCoinBean.fromJson(Map<String, dynamic> json) =>
      _$UserCoinBeanFromJson(json);

  Map<String, dynamic> toJson() => _$UserCoinBeanToJson(this);
}
