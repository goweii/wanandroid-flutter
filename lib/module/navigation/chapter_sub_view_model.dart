import 'package:wanandroid/api/bean/article_bean.dart';
import 'package:wanandroid/api/wan_apis.dart';
import 'package:wanandroid/env/http/paging.dart';
import 'package:wanandroid/env/mvvm/view_model.dart';

class ChapterSubViewModel extends ViewModel {
  final StatablePagingData<ArticleBean> pagingData = StatablePagingData();

  final Paging<ArticleBean> _paging;

  ChapterSubViewModel(int chapterId)
      : _paging = Paging<ArticleBean>(
          initialPage: 0,
          requester: (page) async {
            var resp = await WanApis.getChapterArticles(
              chapterId: chapterId,
              page: page,
            );
            return PagingData(ended: resp.over, datas: resp.datas);
          },
        );

  Future<void> getInitialPage() async {
    await _paging.reset();
    await getNextPage();
  }

  Future<void> getNextPage() async {
    if (pagingData.ended) return;
    if (pagingData.isLoading) return;
    pagingData.toLoading();
    try {
      var data = await _paging.next();
      if (_paging.isInitialPage) {
        pagingData.replace(data);
      } else {
        pagingData.append(data);
      }
    } catch (_) {
      pagingData.toError();
    }
  }
}
