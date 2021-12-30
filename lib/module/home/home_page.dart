import 'package:flutter/material.dart';
import 'package:wanandroid/api/bean/article_bean.dart';
import 'package:wanandroid/env/l10n/generated/l10n.dart';
import 'package:wanandroid/module/home/bean/banner_bean.dart';
import 'package:wanandroid/module/home/home_repo.dart';
import 'package:wanandroid/module/home/home_widget.dart';
import 'package:wanandroid/widget/article_item.dart';
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
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(Strings.of(context).home_title),
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        scrollBehavior: ScrollConfiguration.of(context).copyWith(
          overscroll: false,
          scrollbars: false,
        ),
        controller: _scrollController,
        slivers: [
          ..._buildSlivers(),
        ],
      ),
    );
  }

  List<Widget> _buildSlivers() {
    if (!_hasBanners && !_hasTopArticles && !_hasHomeArticles) {
      return [
        const SliverFillRemaining(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        )
      ];
    }
    return [
      ShiciRefreshHeader(
        onRefresh: _refreshData,
      ),
      if (_banners != null)
        SliverToBoxAdapter(
          child: BannerView(
            banners: _banners!,
          ),
        ),
      if (_topArticles != null)
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
