import 'package:json_annotation/json_annotation.dart';

part 'coin_info_bean.g.dart';

@JsonSerializable()
class CoinInfoBean {
  int coinCount;
  int level;
  String nickname;
  String rank;
  int userId;
  String username;

  CoinInfoBean({
    required this.coinCount,
    required this.level,
    required this.nickname,
    required this.rank,
    required this.userId,
    required this.username,
  });

  factory CoinInfoBean.fromJson(Map<String, dynamic> json) =>
      _$CoinInfoBeanFromJson(json);

  Map<String, dynamic> toJson() => _$CoinInfoBeanToJson(this);
}
