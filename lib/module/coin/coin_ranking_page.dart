import 'package:flutter/material.dart';
import 'package:wanandroid/env/l10n/generated/l10n.dart';
import 'package:wanandroid/env/mvvm/data_provider.dart';
import 'package:wanandroid/env/mvvm/view_model.dart';
import 'package:wanandroid/module/coin/coin_ranking_view_model.dart';
import 'package:wanandroid/module/coin/coin_ranking_widget.dart';
import 'package:wanandroid/widget/paged_list_footer.dart';

class CoinRankingPage extends StatefulWidget {
  const CoinRankingPage({Key? key}) : super(key: key);

  @override
  _CoinRankingPageState createState() => _CoinRankingPageState();
}

class _CoinRankingPageState extends State<CoinRankingPage> {
  final CoinRankingViewModel _viewModel = CoinRankingViewModel();

  ScrollController? _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController == null) return;
        if (_scrollController!.position.pixels >=
            _scrollController!.position.maxScrollExtent) {
          _viewModel.getNextPage();
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<CoinRankingViewModel>(
      create: (context) => _viewModel..getInitialPage(),
      provide: (viewModel) => [
        DataProvider<CoinRankingPagingData>(
            create: (context) => viewModel.coinRankPagingData),
      ],
      builder: (context, viewModel) {
        return Scaffold(
          appBar: AppBar(
            title: Text(Strings.of(context).coin_ranking_title),
          ),
          body: DataConsumer<CoinRankingPagingData>(
            builder: (context, pagingData) {
              if (pagingData.datas.isEmpty) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }
              return CustomScrollView(
                physics: const BouncingScrollPhysics(),
                scrollBehavior: ScrollConfiguration.of(context).copyWith(
                  overscroll: false,
                  scrollbars: false,
                ),
                controller: _scrollController,
                slivers: _buildSlivers(pagingData),
              );
            },
          ),
        );
      },
    );
  }

  List<Widget> _buildSlivers(CoinRankingPagingData pagingData) {
    return [
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return CoinRankingItem(
              coinInfoBean: pagingData.datas[index],
              maxCoinCount: pagingData.datas[0].coinCount,
            );
          },
          childCount: pagingData.datas.length,
        ),
      ),
      if (pagingData.datas.isNotEmpty)
        SliverToBoxAdapter(
          child: PagedListFooter(
            loading: pagingData.isLoading,
            ended: pagingData.ended,
            onLoadMoreTap: () => _viewModel.getNextPage(),
          ),
        ),
    ];
  }
}
