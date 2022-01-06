import 'package:wanandroid/api/bean/user_coin_bean.dart';
import 'package:wanandroid/api/bean/user_coin_history_bean.dart';
import 'package:wanandroid/api/wan_apis.dart';
import 'package:wanandroid/env/http/paging.dart';
import 'package:wanandroid/env/mvvm/statable_data.dart';
import 'package:wanandroid/env/mvvm/view_model.dart';

class UserCoinStatableData extends StatableData<UserCoinBean?> {
  UserCoinStatableData() : super(null);
}

class UserCoinHistoryVO {
  final String reasn;
  final String niceDate;
  final int coinChange;

  UserCoinHistoryVO({
    required this.reasn,
    required this.niceDate,
    required this.coinChange,
  });
}

class UserCoinHistoryPagingData extends StatablePagingData<UserCoinHistoryVO> {
  UserCoinHistoryPagingData() : super();
}

class CoinViewModel extends ViewModel {
  final UserCoinStatableData userCoinStatableData = UserCoinStatableData();
  final UserCoinHistoryPagingData userCoinHistoryPagingData =
      UserCoinHistoryPagingData();

  final Paging<UserCoinHistoryBean> _userCoinHistoryPaging =
      Paging<UserCoinHistoryBean>(
    initialPage: 1,
    requester: (page) async {
      var resp = await WanApis.getUserCoinHistory(page);
      return PagingData(ended: resp.over, datas: resp.datas);
    },
  );

  Future<bool> getUserCoin() async {
    userCoinStatableData.toLoading();
    try {
      var data = await WanApis.getUserCoin();
      userCoinStatableData.value = data;
      return true;
    } catch (e) {
      userCoinStatableData.toError();
      return false;
    }
  }

  Future<bool> getInitialPageUserCoinHistory() async {
    await _userCoinHistoryPaging.reset();
    return await getNextPageUserCoinHistory();
  }

  Future<bool> getNextPageUserCoinHistory() async {
    if (userCoinHistoryPagingData.ended) return true;
    if (userCoinHistoryPagingData.isLoading) return true;
    userCoinHistoryPagingData.toLoading();
    try {
      var data = await _userCoinHistoryPaging.next();
      var voList = data.datas.map((e) {
        return parseUserCoinHistoryBeanToVO(e);
      }).toList();
      userCoinHistoryPagingData.append(PagingData(
        ended: data.ended,
        datas: voList,
      ));
      return true;
    } catch (_) {
      userCoinHistoryPagingData.toError();
      return false;
    }
  }

  UserCoinHistoryVO parseUserCoinHistoryBeanToVO(UserCoinHistoryBean bean) {
    // 2022-01-04 10:23:28 签到 , 积分：38 + 29
    RegExp regExp = RegExp(
      '([0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}) .*? , 积分：([0-9]{1,}) [+] ([0-9]{1,})',
    );
    var match = regExp.firstMatch(bean.desc);
    var niceDate = '';
    var coin1 = 0;
    var coin2 = 0;
    if (match != null && match.groupCount == 3) {
    niceDate = match.group(1)!;
    coin1 = int.tryParse(match.group(2)!) ?? 0;
    coin2 = int.tryParse(match.group(3)!) ?? 0;
    }
    return UserCoinHistoryVO(
      reasn: '${bean.reason} $coin1+$coin2',
      niceDate: niceDate,
      coinChange: coin1 + coin2,
    );
  }
}
