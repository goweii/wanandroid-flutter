import 'package:wanandroid/api/wan/bean/article_bean.dart';
import 'package:wanandroid/api/wan/wan_apis.dart';
import 'package:wanandroid/env/http/paging.dart';
import 'package:wanandroid/env/mvvm/view_model.dart';

class SearchArticlesPagingData extends StatablePagingData<ArticleBean> {}

class SearchResultViewModel extends ViewModel {
  final SearchArticlesPagingData pagingData = SearchArticlesPagingData();

  late Paging<ArticleBean> _paging;

  String _key = '';

  SearchResultViewModel() {
    _paging = Paging(
      initialPage: 0,
      requester: (page) async {
        var resp = await WanApis.search(
          key: _key,
          page: page,
        );
        return PagingData(ended: resp.over, datas: resp.datas);
      },
    );
  }

  Future<bool> research() async {
    if (!_key.isNotEmpty) {
      await _paging.reset();
      return false;
    }
    return await getNextPage();
  }

  Future<bool> search(String key) async {
    _key = key;
    if (!_key.isNotEmpty) {
      await _paging.reset();
      return false;
    }
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
}
