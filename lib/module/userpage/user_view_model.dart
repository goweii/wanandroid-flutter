import 'package:wanandroid/api/wan/bean/article_bean.dart';
import 'package:wanandroid/api/wan/bean/user_coin_bean.dart';
import 'package:wanandroid/api/wan/wan_apis.dart';
import 'package:wanandroid/env/http/paging.dart';
import 'package:wanandroid/env/mvvm/statable_data.dart';
import 'package:wanandroid/env/mvvm/view_model.dart';

class UserArticlesPagingData extends StatablePagingData<ArticleBean> {}

class UserCoinInfoStatableData extends StatableData<UserCoinBean?> {
  UserCoinInfoStatableData() : super(null);
}

class UserViewModel extends ViewModel {
  final UserCoinInfoStatableData coinInfoStatableData =
      UserCoinInfoStatableData();
  final UserArticlesPagingData articlesPagingData = UserArticlesPagingData();
  late Paging<ArticleBean> _paging;

  final int userid;

  UserViewModel({required this.userid}) {
    _paging = Paging<ArticleBean>(
      initialPage: 1,
      requester: _request,
    );
  }

  Future<PagingData<ArticleBean>> _request(page) async {
    var resp = await WanApis.getUserSharedArticles(
      userid: userid,
      page: page,
    );
    if (!coinInfoStatableData.isSuccess) {
      coinInfoStatableData.value = resp.coinInfo;
    }
    return PagingData(
      ended: resp.shareArticles.over,
      datas: resp.shareArticles.datas,
    );
  }

  Future<bool> getInitialPage() async {
    await _paging.reset();
    coinInfoStatableData.toLoading();
    bool success = await getNextPage();
    if (!success) {
      coinInfoStatableData.toError();
    }
    return success;
  }

  Future<bool> getNextPage() async {
    if (articlesPagingData.ended) return true;
    if (articlesPagingData.isLoading) return false;
    articlesPagingData.toLoading();
    try {
      var data = await _paging.next();
      if (_paging.isInitialPage) {
        articlesPagingData.replace(data);
      } else {
        articlesPagingData.append(data);
      }
      return true;
    } catch (_) {
      articlesPagingData.toError();
      return false;
    }
  }
}
