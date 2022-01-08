import 'package:flutter/material.dart';
import 'package:wanandroid/env/l10n/generated/l10n.dart';
import 'package:wanandroid/env/mvvm/data_provider.dart';
import 'package:wanandroid/env/mvvm/view_model.dart';
import 'package:wanandroid/module/coin/coin_rank_view_model.dart';
import 'package:wanandroid/module/coin/coin_rank_widget.dart';
import 'package:wanandroid/widget/paged_list_footer.dart';

class CoinRankPage extends StatefulWidget {
  const CoinRankPage({Key? key}) : super(key: key);

  @override
  _CoinRankPageState createState() => _CoinRankPageState();
}

class _CoinRankPageState extends State<CoinRankPage> {
  final CoinRankViewModel _viewModel = CoinRankViewModel();

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
    return ViewModelProvider<CoinRankViewModel>(
      create: (context) => _viewModel..getInitialPage(),
      provide: (viewModel) => [
        DataProvider<CoinRankPagingData>(
            create: (context) => viewModel.coinRankPagingData),
      ],
      builder: (context, viewModel) {
        return Scaffold(
          appBar: AppBar(
            title: Text(Strings.of(context).coin_rank_title),
          ),
          body: DataConsumer<CoinRankPagingData>(
            builder: (context, pagingData) {
              if (pagingData.datas.isEmpty) {
                return const Center(
                  child: CircularProgressIndicator(),
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

  List<Widget> _buildSlivers(CoinRankPagingData pagingData) {
    return [
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return CoinRankItem(
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
          ),
        ),
    ];
  }
}
