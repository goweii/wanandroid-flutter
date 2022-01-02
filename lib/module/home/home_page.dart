import 'package:flutter/material.dart';
import 'package:wanandroid/api/bean/article_bean.dart';
import 'package:wanandroid/bus/bus.dart';
import 'package:wanandroid/bus/events/collent_event.dart';
import 'package:wanandroid/env/l10n/generated/l10n.dart';
import 'package:wanandroid/env/provider/login.dart';
import 'package:wanandroid/module/home/bean/banner_bean.dart';
import 'package:wanandroid/module/home/home_repo.dart';
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
  final HomeRepo _repo = HomeRepo();

  List<BannerBean>? _banners;
  List<ArticleBean>? _topArticles;
  final List<ArticleBean> _homeArticles = [];
  bool _endedArticles = false;
  bool _loadingArticles = false;

  bool get _hasBanners => _banners != null && _banners!.isNotEmpty;
  bool get _hasTopArticles => _topArticles != null && _topArticles!.isNotEmpty;
  bool get _hasHomeArticles => _homeArticles.isNotEmpty;
  bool get _hasArticles => _hasTopArticles || _hasHomeArticles;

  ScrollController? _scrollController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController == null) return;
        if (_loadingArticles) return;
        if (_endedArticles) return;
        if (_scrollController!.position.pixels >=
            _scrollController!.position.maxScrollExtent) {
          setState(() {
            _loadingArticles = true;
          });
          _repo.getNextHomeArticles().then((value) {
            setState(() {
              _loadingArticles = false;
              _endedArticles = value.ended;
              _homeArticles.addAll(value.datas);
            });
          }, onError: (error) {
            setState(() {
              _loadingArticles = false;
            });
          });
        }
      });
    _refreshData();
    LoginState.stream().listen(_onLoginStateChanged);
    Bus().on<CollectEvent>().listen(_onCollectEvent);
  }

  @override
  void dispose() {
    _scrollController?.dispose();
    _scrollController = null;
    super.dispose();
  }

  _onLoginStateChanged(LoginState loginState) {
    if (loginState.isLogin) {
      _refreshData();
    } else {
      setState(() {
        _topArticles?.forEach((element) => element.collect = false);
        for (var element in _homeArticles) {
          element.collect = false;
        }
      });
    }
  }

  _onCollectEvent(CollectEvent event) {
    _topArticles
        ?.where((value) => value.id == event.articleId)
        .forEach((element) {
      setState(() {
        element.collect = event.collect;
      });
    });
    _homeArticles
        .where((value) => value.id == event.articleId)
        .forEach((element) {
      setState(() {
        element.collect = event.collect;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(Strings.of(context).home_title),
      ),
      body: OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
          if (!_hasBanners && !_hasTopArticles && !_hasHomeArticles) {
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
              slivers: _buildSlivers(true),
            );
          } else {
            return SizedBox.expand(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: !_hasBanners
                        ? Container()
                        : BannerView(
                            scrollDirection: Axis.vertical,
                            banners: _banners!,
                          ),
                  ),
                  Expanded(
                    child: CustomScrollView(
                      physics: const BouncingScrollPhysics(),
                      scrollBehavior: ScrollConfiguration.of(context).copyWith(
                        overscroll: false,
                        scrollbars: false,
                      ),
                      controller: _scrollController,
                      slivers: _buildSlivers(false),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  List<Widget> _buildSlivers(bool needBanner) {
    return [
      ShiciRefreshHeader(
        onRefresh: _refreshData,
      ),
      if (needBanner && _hasBanners)
        SliverToBoxAdapter(
          child: AspectRatio(
            aspectRatio: 16.0 / 9.0,
            child: BannerView(
              banners: _banners!,
            ),
          ),
        ),
      if (_hasTopArticles)
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return ArticleItem(
                article: _topArticles![index],
                top: true,
              );
            },
            childCount: _topArticles?.length ?? 0,
          ),
        ),
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return ArticleItem(article: _homeArticles[index]);
          },
          childCount: _homeArticles.length,
        ),
      ),
      if (_hasArticles)
        SliverToBoxAdapter(
          child: PagedListFooter(
            loading: _loadingArticles,
            ended: _endedArticles,
          ),
        ),
    ];
  }

  Future<bool> _refreshData() async {
    bool result = true;
    try {
      var value = await _repo.getBanners();
      setState(() {
        _banners = value;
      });
    } catch (_) {
      result = false;
    }
    try {
      var value = await _repo.getTopArticles();
      setState(() {
        _topArticles = value;
      });
    } catch (_) {
      result = false;
    }
    setState(() {
      _loadingArticles = true;
    });
    try {
      var value = await _repo.getInitialHomeArticles();
      setState(() {
        _endedArticles = value.ended;
        _homeArticles.clear();
        _homeArticles.addAll(value.datas);
      });
    } catch (_) {
      result = false;
    }
    setState(() {
      _loadingArticles = false;
    });
    return result;
  }
}
