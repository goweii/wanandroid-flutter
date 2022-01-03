import 'package:wanandroid/api/bean/article_bean.dart';
import 'package:wanandroid/api/wan_apis.dart';
import 'package:wanandroid/env/http/paging.dart';
import 'package:wanandroid/env/mvvm/view_model.dart';
import 'package:wanandroid/module/home/bean/banner_bean.dart';

class BannerPagingData extends StatablePagingData<BannerBean> {}

class TopArticlePagingData extends StatablePagingData<ArticleBean> {}

class HomeArticlePagingData extends StatablePagingData<ArticleBean> {}

class HomeViewModel extends ViewModel {
  final BannerPagingData banners = BannerPagingData();
  final TopArticlePagingData topArticles = TopArticlePagingData();
  final HomeArticlePagingData homeArticles = HomeArticlePagingData();

  Future<bool> getBanners() async {
    banners.toLoading();
    try {
      var data = await WanApis.getBanners();
      banners.append(PagingData(ended: true, datas: data));
      return true;
    } catch (_) {
      banners.toError();
      return false;
    }
  }

  Future<bool> getTopArticles() async {
    topArticles.toLoading();
    try {
      var data = await WanApis.getTopArticles();
      topArticles.append(PagingData(ended: true, datas: data));
      return true;
    } catch (_) {
      topArticles.toError();
      return false;
    }
  }

  final Paging<ArticleBean> _homeArticlePaging = Paging<ArticleBean>(
    initialPage: 0,
    requester: (page) async {
      var resp = await WanApis.getHomeArticles(page);
      return PagingData(ended: resp.over, datas: resp.datas);
    },
  );

  Future<bool> getInitialHomeArticles() async {
    await _homeArticlePaging.reset();
    return await getNextHomeArticles();
  }

  Future<bool> getNextHomeArticles() async {
    if (homeArticles.ended) return true;
    if (homeArticles.isLoading) return true;
    homeArticles.toLoading();
    try {
      var data = await _homeArticlePaging.next();
      homeArticles.append(data);
      return true;
    } catch (_) {
      homeArticles.toError();
      return false;
    }
  }
}
