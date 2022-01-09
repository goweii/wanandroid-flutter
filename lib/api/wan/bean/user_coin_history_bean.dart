import 'package:json_annotation/json_annotation.dart';

part 'user_coin_history_bean.g.dart';

@JsonSerializable()
class UserCoinHistoryBean {
  final int coinCount;
  final int date;
  final String desc;
  final int id;
  final String reason;
  final int type;
  final int userId;
  final String userName;

  UserCoinHistoryBean({
    required this.coinCount,
    required this.date,
    required this.desc,
    required this.id,
    required this.reason,
    required this.type,
    required this.userId,
    required this.userName,
  });

  factory UserCoinHistoryBean.fromJson(Map<String, dynamic> json) =>
      _$UserCoinHistoryBeanFromJson(json);

  Map<String, dynamic> toJson() => _$UserCoinHistoryBeanToJson(this);
}
