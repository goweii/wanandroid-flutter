import 'package:wanandroid/api/bean/article_bean.dart';
import 'package:wanandroid/api/wan_apis.dart';
import 'package:wanandroid/env/http/paging.dart';
import 'package:wanandroid/env/mvvm/view_model.dart';

class SquareViewModel extends ViewModel {
  final StatablePagingData<ArticleBean> pagingData = StatablePagingData();

  final Paging<ArticleBean> _paging = Paging<ArticleBean>(
    initialPage: 1,
    requester: (page) async {
      var resp = await WanApis.getSquareArticles(page);
      return PagingData(ended: resp.over, datas: resp.datas);
    },
  );

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
      pagingData.append(data);
      return true;
    } catch (_) {
      pagingData.toError();
      return false;
    }
  }

}