import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wanandroid/api/wan/bean/user_coin_bean.dart';
import 'package:wanandroid/bus/bus.dart';
import 'package:wanandroid/bus/events/collent_event.dart';
import 'package:wanandroid/env/dimen/app_dimens.dart';
import 'package:wanandroid/env/l10n/generated/l10n.dart';
import 'package:wanandroid/env/mvvm/data_provider.dart';
import 'package:wanandroid/env/mvvm/view_model.dart';
import 'package:wanandroid/env/provider/login.dart';
import 'package:wanandroid/module/article/article_item.dart';
import 'package:wanandroid/module/userpage/user_view_model.dart';
import 'package:wanandroid/widget/paged_list_footer.dart';
import 'package:wanandroid/widget/shici_refresh_header.dart';

class UserPage extends StatefulWidget {
  const UserPage({
    Key? key,
    required this.userid,
  }) : super(key: key);

  final int userid;

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  late UserViewModel _viewModel;

  ScrollController? _scrollController;

  double _expandedHeight = 0.0;
  bool _showTitle = false;

  @override
  void initState() {
    _viewModel = UserViewModel(userid: widget.userid);
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController == null) return;
        if (_scrollController!.position.pixels >=
            _scrollController!.position.maxScrollExtent) {
          _viewModel.getNextPage();
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
    return ViewModelProvider<UserViewModel>(
      create: (context) => _viewModel..getInitialPage(),
      builder: (context, viewModel) {
        return Scaffold(
          body: DataProvider2<UserCoinInfoStatableData, UserArticlesPagingData>(
            create1: (context) => _viewModel.coinInfoStatableData,
            create2: (context) => _viewModel.articlesPagingData,
            builder: (context, coinInfoStatableData, articlesPagingData) {
              return OrientationBuilder(
                builder: (context, orientation) {
                  if (orientation == Orientation.portrait) {
                    return CustomScrollView(
                      physics: const BouncingScrollPhysics(),
                      scrollBehavior: ScrollConfiguration.of(context).copyWith(
                        overscroll: false,
                        scrollbars: false,
                      ),
                      controller: _scrollController,
                      slivers: _buildSlivers(
                        coinInfoStatableData,
                        articlesPagingData,
                      ),
                    );
                  }
                  return Row(
                    children: [
                      Expanded(
                        child: Container(
                          color: Theme.of(context).appBarTheme.backgroundColor,
                          child: SafeArea(
                            child: Stack(
                              children: [
                                AppBar(),
                                Positioned(
                                  child: Center(
                                    child: UserHeader(
                                      userCoinBean: coinInfoStatableData.value,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              color:
                                  Theme.of(context).appBarTheme.backgroundColor,
                              child: SafeArea(
                                child: Container(),
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
                                  null,
                                  articlesPagingData,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        );
      },
    );
  }

  List<Widget> _buildSlivers(
    UserCoinInfoStatableData? coinInfoStatableData,
    UserArticlesPagingData articlesPagingData,
  ) {
    List<Widget> slivers = [
      if (coinInfoStatableData != null)
        SliverAppBar(
          floating: true,
          pinned: true,
          snap: true,
          elevation: 0,
          toolbarHeight: AppDimens.appBarHeight,
          expandedHeight: AppDimens.appBarHeight + AppDimens.appBarHeaderHeight,
          flexibleSpace: LayoutBuilder(
            builder: (context, constraints) {
              var max = AppDimens.appBarHeight + AppDimens.appBarHeaderHeight;
              if (constraints.maxHeight > _expandedHeight) {
                _expandedHeight = constraints.maxHeight;
              }
              if (_expandedHeight > max) {
                var changedHeight = _expandedHeight - constraints.maxHeight;
                if (changedHeight.roundToDouble() >=
                    AppDimens.appBarHeaderHeight.roundToDouble()) {
                  if (!_showTitle) {
                    _showTitle = true;
                  }
                } else {
                  if (_showTitle) {
                    _showTitle = false;
                  }
                }
              }
              return FlexibleSpaceBar(
                title: _showTitle
                    ? SafeArea(
                        child: Center(
                          child: Text(
                            coinInfoStatableData.value?.nameToShow ?? '',
                            style:
                                Theme.of(context).appBarTheme.titleTextStyle,
                          ),
                        ),
                      )
                    : null,
                centerTitle: true,
                titlePadding: EdgeInsets.zero,
                background: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SafeArea(
                        child: SizedBox(height: AppDimens.appBarHeight)),
                    SizedBox(
                      height: AppDimens.appBarHeaderHeight,
                      child: Center(
                        child: UserHeader(
                            userCoinBean: coinInfoStatableData.value),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
    ];
    if ((coinInfoStatableData != null &&
            coinInfoStatableData.value == null &&
            coinInfoStatableData.isLoading) ||
        (articlesPagingData.datas.isEmpty && articlesPagingData.isLoading)) {
      slivers.add(const SliverFillRemaining(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ));
      return slivers;
    }
    slivers.addAll([
      ShiciRefreshHeader(onRefresh: () => _viewModel.getInitialPage()),
      SliverMasonryGrid.extent(
        maxCrossAxisExtent: AppDimens.gridMaxCrossAxisExtent,
        childCount: articlesPagingData.datas.length,
        itemBuilder: (BuildContext context, int index) {
          return ArticleItem(article: articlesPagingData.datas[index]);
        },
      ),
      if (articlesPagingData.datas.isNotEmpty)
        SliverToBoxAdapter(
          child: PagedListFooter(
            loading: articlesPagingData.isLoading,
            ended: articlesPagingData.ended,
          ),
        ),
    ]);
    return slivers;
  }

  _onLoginStateChanged(LoginState loginState) {
    if (loginState.isLogin) {
      _viewModel.getInitialPage();
    } else {
      _viewModel.articlesPagingData
        // ignore: avoid_function_literals_in_foreach_calls
        ..datas.forEach((element) => element.collect = false)
        ..notify();
    }
  }

  _onCollectEvent(CollectEvent event) {
    _viewModel.articlesPagingData
      ..datas
          .where((value) => value.id == event.articleId)
          .forEach((element) => element.collect = event.collect)
      ..notify();
  }
}

class UserHeader extends StatelessWidget {
  const UserHeader({
    Key? key,
    required this.userCoinBean,
  }) : super(key: key);

  final UserCoinBean? userCoinBean;

  @override
  Widget build(BuildContext context) {
    final LoginState loginState = LoginState.listen(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          child: ClipOval(
            child: SizedBox(
              width: AppDimens.avatarSize,
              height: AppDimens.avatarSize,
              child: Container(
                color: Theme.of(context)
                    .appBarTheme
                    .iconTheme
                    ?.color
                    ?.withAlpha(60),
              ),
            ),
          ),
        ),
        const SizedBox(height: AppDimens.marginNormal),
        GestureDetector(
          child: Text(
            userCoinBean?.nameToShow ?? '',
            style: Theme.of(context).appBarTheme.titleTextStyle?.copyWith(
                  fontSize: Theme.of(context).textTheme.headline6?.fontSize,
                ),
          ),
        ),
        const SizedBox(height: AppDimens.marginHalf),
        if (loginState.isLogin)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                Strings.of(context).level_prefix +
                    '${userCoinBean?.level ?? 0}',
                style: Theme.of(context).appBarTheme.titleTextStyle?.copyWith(
                      fontSize: Theme.of(context).textTheme.bodyText2?.fontSize,
                    ),
              ),
              const SizedBox(width: AppDimens.marginNormal),
              Text(
                Strings.of(context).ranking_prefix +
                    (userCoinBean?.rank ?? '0'),
                style: Theme.of(context).appBarTheme.titleTextStyle?.copyWith(
                      fontSize: Theme.of(context).textTheme.bodyText2?.fontSize,
                    ),
              ),
            ],
          ),
      ],
    );
  }
}
