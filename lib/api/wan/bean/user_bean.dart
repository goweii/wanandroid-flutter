import 'package:json_annotation/json_annotation.dart';
import 'package:wanandroid/api/wan/bean/user_coin_bean.dart';
import 'package:wanandroid/api/wan/bean/user_info_bean.dart';

part 'user_bean.g.dart';

@JsonSerializable()
class UserBean {
  UserCoinBean coinInfo;
  UserInfoBean userInfo;

  UserBean({
    required this.coinInfo,
    required this.userInfo,
  });

  factory UserBean.fromJson(Map<String, dynamic> json) =>
      _$UserBeanFromJson(json);

  Map<String, dynamic> toJson() => _$UserBeanToJson(this);
}
