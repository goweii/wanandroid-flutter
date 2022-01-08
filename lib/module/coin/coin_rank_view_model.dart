import 'package:wanandroid/api/bean/coin_info_bean.dart';
import 'package:wanandroid/api/wan_apis.dart';
import 'package:wanandroid/env/http/paging.dart';
import 'package:wanandroid/env/mvvm/view_model.dart';

class CoinRankPagingData extends StatablePagingData<CoinInfoBean> {
  CoinRankPagingData() : super();
}

class CoinRankViewModel extends ViewModel {
  final CoinRankPagingData coinRankPagingData = CoinRankPagingData();

  final Paging<CoinInfoBean> _coinRankPaging = Paging<CoinInfoBean>(
    initialPage: 1,
    requester: (page) async {
      var resp = await WanApis.getCoinRank(page);
      return PagingData(ended: resp.over, datas: resp.datas);
    },
  );

  Future<bool> getInitialPage() async {
    await _coinRankPaging.reset();
    return await getNextPage();
  }

  Future<bool> getNextPage() async {
    if (coinRankPagingData.ended) return true;
    if (coinRankPagingData.isLoading) return true;
    coinRankPagingData.toLoading();
    try {
      var data = await _coinRankPaging.next();
      coinRankPagingData.append(data);
      return true;
    } catch (_) {
      coinRankPagingData.toError();
      return false;
    }
  }
}
