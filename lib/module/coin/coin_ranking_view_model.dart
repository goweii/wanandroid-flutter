import 'package:wanandroid/api/bean/coin_info_bean.dart';
import 'package:wanandroid/api/wan_apis.dart';
import 'package:wanandroid/env/http/paging.dart';
import 'package:wanandroid/env/mvvm/view_model.dart';

class CoinRankingPagingData extends StatablePagingData<CoinInfoBean> {
  CoinRankingPagingData() : super();
}

class CoinRankingViewModel extends ViewModel {
  final CoinRankingPagingData coinRankPagingData = CoinRankingPagingData();

  final Paging<CoinInfoBean> _coinRankingPaging = Paging<CoinInfoBean>(
    initialPage: 1,
    requester: (page) async {
      var resp = await WanApis.getCoinRanking(page);
      return PagingData(ended: resp.over, datas: resp.datas);
    },
  );

  Future<bool> getInitialPage() async {
    await _coinRankingPaging.reset();
    return await getNextPage();
  }

  Future<bool> getNextPage() async {
    if (coinRankPagingData.ended) return true;
    if (coinRankPagingData.isLoading) return true;
    coinRankPagingData.toLoading();
    try {
      var data = await _coinRankingPaging.next();
      if (_coinRankingPaging.isInitialPage) {
        coinRankPagingData.replace(data);
      } else {
        coinRankPagingData.append(data);
      }
      return true;
    } catch (_) {
      coinRankPagingData.toError();
      return false;
    }
  }
}
