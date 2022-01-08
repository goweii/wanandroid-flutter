import 'package:flutter/material.dart';
import 'package:wanandroid/env/dimen/app_dimens.dart';
import 'package:wanandroid/env/l10n/generated/l10n.dart';
import 'package:wanandroid/env/mvvm/data_provider.dart';
import 'package:wanandroid/env/mvvm/view_model.dart';
import 'package:wanandroid/env/route/route_map.dart';
import 'package:wanandroid/env/route/router.dart';
import 'package:wanandroid/module/coin/coin_view_model.dart';
import 'package:wanandroid/module/coin/coin_widget.dart';
import 'package:wanandroid/widget/app_bar_bottom_wrapper.dart';
import 'package:wanandroid/widget/paged_list_footer.dart';

class CoinPage extends StatefulWidget {
  const CoinPage({Key? key}) : super(key: key);

  @override
  _CoinPageState createState() => _CoinPageState();
}

class _CoinPageState extends State<CoinPage> {
  final CoinViewModel _viewModel = CoinViewModel();

  ScrollController? _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController == null) return;
        if (_scrollController!.position.pixels >=
            _scrollController!.position.maxScrollExtent) {
          _viewModel.getNextPageUserCoinHistory();
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<CoinViewModel>(
      create: (context) {
        _viewModel.getUserCoin();
        _viewModel.getInitialPageUserCoinHistory();
        return _viewModel;
      },
      provide: (viewModel) => [
        DataProvider<UserCoinStatableData>(
            create: (_) => viewModel.userCoinStatableData),
        DataProvider<UserCoinHistoryPagingData>(
            create: (_) => viewModel.userCoinHistoryPagingData),
      ],
      builder: (context, viewModel) {
        return OrientationBuilder(builder: (context, orientation) {
          bool isPortrait = orientation == Orientation.portrait;
          return Scaffold(
            appBar: !isPortrait
                ? null
                : AppBar(
                    title: Text(Strings.of(context).coin_title),
                    actions: [
                      IconButton(
                        onPressed: () => {
                          AppRouter.of(context).pushNamed(RouteMap.coinRankPage)
                        },
                        icon: const Icon(Icons.bar_chart_rounded),
                      )
                    ],
                    bottom: !isPortrait
                        ? null
                        : const AppBarBottomWrapper(
                            height: AppDimens.appBarHeaderHeight,
                            child: CoinWidget(
                              height: AppDimens.appBarHeaderHeight,
                            ),
                          ),
                  ),
            body: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                if (!isPortrait)
                  Expanded(
                    child: Container(
                      color: Theme.of(context).appBarTheme.backgroundColor,
                      child: Column(
                        children: [
                          AppBar(
                            title: Text(Strings.of(context).coin_title),
                            actions: [
                              IconButton(
                                onPressed: () => {
                                  AppRouter.of(context)
                                      .pushNamed(RouteMap.coinRankPage)
                                },
                                icon: const Icon(Icons.bar_chart_rounded),
                              )
                            ],
                          ),
                          const Expanded(
                            child: CoinWidget(
                              height: double.infinity,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                Expanded(
                  child: Column(
                    children: [
                      if (!isPortrait)
                        Container(
                          color: Theme.of(context).appBarTheme.backgroundColor,
                          child: SafeArea(
                            child: Container(),
                          ),
                        ),
                      Expanded(
                        child: DataConsumer<UserCoinHistoryPagingData>(
                          builder: (context, data) {
                            if (data.datas.isEmpty) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return CustomScrollView(
                              physics: const BouncingScrollPhysics(),
                              scrollBehavior:
                                  ScrollConfiguration.of(context).copyWith(
                                overscroll: false,
                                scrollbars: false,
                              ),
                              controller: _scrollController,
                              slivers: _buildSlivers(data),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
      },
    );
  }

  List<Widget> _buildSlivers(UserCoinHistoryPagingData pagingData) {
    return [
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return CoinHistoryItem(coinHistoryVO: pagingData.datas[index]);
          },
          childCount: pagingData.datas.length,
        ),
      ),
      if (pagingData.datas.isNotEmpty)
        SliverToBoxAdapter(
          child: PagedListFooter(
            loading: pagingData.isLoading,
            ended: pagingData.ended,
          ),
        ),
    ];
  }
}
