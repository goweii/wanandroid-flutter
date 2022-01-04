import 'package:flutter/material.dart';
import 'package:wanandroid/bus/bus.dart';
import 'package:wanandroid/bus/events/collent_event.dart';
import 'package:wanandroid/env/l10n/generated/l10n.dart';
import 'package:wanandroid/env/mvvm/observable_data.dart';
import 'package:wanandroid/env/mvvm/view_model.dart';
import 'package:wanandroid/env/provider/login.dart';
import 'package:wanandroid/module/home/home_view_model.dart';
import 'package:wanandroid/module/home/home_widget.dart';
import 'package:wanandroid/module/article/article_item.dart';
import 'package:wanandroid/widget/paged_list_footer.dart';
import 'package:wanandroid/widget/shici_refresh_header.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  final HomeViewModel _viewModel = HomeViewModel();

  ScrollController? _scrollController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController == null) return;
        if (_scrollController!.position.pixels >=
            _scrollController!.position.maxScrollExtent) {
          _viewModel.getNextHomeArticles();
        }
      });
    LoginState.stream().listen(_onLoginStateChanged);
    Bus().on<CollectEvent>().listen(_onCollectEvent);
  }

  @override
  void dispose() {
    _scrollController?.dispose();
    _scrollController = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ViewModelProvider<HomeViewModel>(
      create: (context) {
        _refreshData();
        return _viewModel;
      },
      builder: (context, viewModel) {
        return Scaffold(
          appBar: AppBar(
            title: Text(Strings.of(context).home_title)
          ),
          body: DataProvider3<BannerPagingData, TopArticlePagingData,
              HomeArticlePagingData>(
            create1: (context) => viewModel.banners,
            create2: (context) => viewModel.topArticles,
            create3: (context) => viewModel.homeArticles,
            builder: (context, banners, topArticles, homeArticles) {
              return OrientationBuilder(
                builder: (BuildContext context, Orientation orientation) {
                  if (banners.datas.isEmpty &&
                      topArticles.datas.isEmpty &&
                      homeArticles.datas.isEmpty) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (orientation == Orientation.portrait) {
                    return CustomScrollView(
                      physics: const BouncingScrollPhysics(),
                      scrollBehavior: ScrollConfiguration.of(context).copyWith(
                        overscroll: false,
                        scrollbars: false,
                      ),
                      controller: _scrollController,
                      slivers:
                          _buildSlivers(banners, topArticles, homeArticles),
                    );
                  } else {
                    return SizedBox.expand(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: banners.datas.isEmpty
                                ? Container()
                                : BannerView(
                                    scrollDirection: Axis.vertical,
                                    banners: banners.datas,
                                  ),
                          ),
                          Expanded(
                            child: CustomScrollView(
                              physics: const BouncingScrollPhysics(),
                              scrollBehavior:
                                  ScrollConfiguration.of(context).copyWith(
                                overscroll: false,
                                scrollbars: false,
                              ),
                              controller: _scrollController,
                              slivers: _buildSlivers(
                                  null, topArticles, homeArticles),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
              );
            },
          ),
        );
      },
    );
  }

  List<Widget> _buildSlivers(
    BannerPagingData? banners,
    TopArticlePagingData topArticles,
    HomeArticlePagingData homeArticles,
  ) {
    return [
      ShiciRefreshHeader(
        onRefresh: _refreshData,
      ),
      if (banners != null && banners.datas.isNotEmpty)
        SliverToBoxAdapter(
          child: AspectRatio(
            aspectRatio: 16.0 / 9.0,
            child: BannerView(
              banners: banners.datas,
            ),
          ),
        ),
      if (topArticles.datas.isNotEmpty)
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return ArticleItem(
                article: topArticles.datas[index],
                top: true,
              );
            },
            childCount: topArticles.datas.length,
          ),
        ),
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return ArticleItem(article: homeArticles.datas[index]);
          },
          childCount: homeArticles.datas.length,
        ),
      ),
      if (topArticles.datas.isNotEmpty || homeArticles.datas.isNotEmpty)
        SliverToBoxAdapter(
          child: PagedListFooter(
            loading: homeArticles.isLoading,
            ended: homeArticles.ended,
          ),
        ),
    ];
  }

  Future<bool> _refreshData() async {
    bool getBannersSuccess = await _viewModel.getBanners();
    bool getTopArticlesSuccess = await _viewModel.getTopArticles();
    bool getHomeArticlesSuccess = await _viewModel.getInitialHomeArticles();
    return getBannersSuccess && getTopArticlesSuccess && getHomeArticlesSuccess;
  }

  _onLoginStateChanged(LoginState loginState) {
    if (loginState.isLogin) {
      _refreshData();
    } else {
      _viewModel.topArticles
        // ignore: avoid_function_literals_in_foreach_calls
        ..datas.forEach((element) => element.collect = false)
        ..notify();
      _viewModel.homeArticles
        // ignore: avoid_function_literals_in_foreach_calls
        ..datas.forEach((element) => element.collect = false)
        ..notify();
    }
  }

  _onCollectEvent(CollectEvent event) {
    _viewModel.topArticles
      ..datas
          .where((value) => value.id == event.articleId)
          .forEach((element) => element.collect = event.collect)
      ..notify();
    _viewModel.homeArticles
      ..datas
          .where((value) => value.id == event.articleId)
          .forEach((element) => element.collect = event.collect)
      ..notify();
  }
}
