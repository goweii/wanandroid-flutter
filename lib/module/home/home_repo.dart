import 'package:wanandroid/api/bean/article_bean.dart';
import 'package:wanandroid/api/wan_apis.dart';
import 'package:wanandroid/env/http/paging.dart';
import 'package:wanandroid/module/home/bean/banner_bean.dart';

class HomeRepo {
  Future<List<BannerBean>> getBanners() {
    return WanApis.getBanners();
  }

  Future<List<ArticleBean>> getTopArticles() {
    return WanApis.getTopArticles();
  }

  final Paging<ArticleBean> _homeArticleRepo = Paging<ArticleBean>(
    initialPage: 0,
    requester: (page) async {
      var resp = await WanApis.getHomeArticles(page);
      return PagingData(ended: resp.over, datas: resp.datas);
    },
  );

  Future<PagingData<ArticleBean>> getInitialHomeArticles() async {
    await _homeArticleRepo.reset();
    return _homeArticleRepo.next();
  }

  Future<PagingData<ArticleBean>> getNextHomeArticles() async {
    return _homeArticleRepo.next();
  }
}
