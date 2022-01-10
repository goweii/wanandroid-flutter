import 'package:wanandroid/api/wan/bean/article_bean.dart';
import 'package:wanandroid/api/wan/bean/user_coin_bean.dart';
import 'package:wanandroid/api/wan/wan_apis.dart';
import 'package:wanandroid/env/http/paging.dart';
import 'package:wanandroid/env/mvvm/statable_data.dart';
import 'package:wanandroid/env/mvvm/view_model.dart';

class SharedArticlesPagingData extends StatablePagingData<ArticleBean> {}

class CoinInfoStatableData extends StatableData<UserCoinBean?> {
  CoinInfoStatableData() : super(null);
}

class MyShareViewModel extends ViewModel {
  final SharedArticlesPagingData pagingData = SharedArticlesPagingData();
  late Paging<ArticleBean> _paging;

  MyShareViewModel() {
    _paging = Paging<ArticleBean>(
      initialPage: 1,
      requester: _request,
    );
  }

  Future<PagingData<ArticleBean>> _request(page) async {
    var resp = await WanApis.getSharedArticles(page);
    return PagingData(
      ended: resp.shareArticles.over,
      datas: resp.shareArticles.datas,
    );
  }

  Future<bool> getInitialPage() async {
    await _paging.reset();
    return await getNextPage();
  }

  Future<bool> getNextPage() async {
    if (pagingData.ended) return true;
    if (pagingData.isLoading) return false;
    pagingData.toLoading();
    try {
      var data = await _paging.next();
      if (_paging.isInitialPage) {
        pagingData.replace(data);
      } else {
        pagingData.append(data);
      }
      return true;
    } catch (_) {
      pagingData.toError();
      return false;
    }
  }

  Future<bool> deleteSharedArticle(int id) async {
    try {
      WanApis.deleteSharedArticle(id);
      return true;
    } catch (_) {
      pagingData.toError();
      return false;
    }
  }
}
