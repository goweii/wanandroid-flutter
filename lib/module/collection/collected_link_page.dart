import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wanandroid/api/wan/bean/link_bean.dart';
import 'package:wanandroid/api/wan/wan_toast.dart';
import 'package:wanandroid/bus/bus.dart';
import 'package:wanandroid/bus/events/collent_event.dart';
import 'package:wanandroid/env/dimen/app_dimens.dart';
import 'package:wanandroid/env/l10n/generated/l10n.dart';
import 'package:wanandroid/env/mvvm/data_provider.dart';
import 'package:wanandroid/env/mvvm/view_model.dart';
import 'package:wanandroid/module/collection/collected_link_view_model.dart';
import 'package:wanandroid/module/collection/collected_link_widget.dart';
import 'package:wanandroid/widget/paged_list_footer.dart';
import 'package:wanandroid/widget/shici_refresh_header.dart';

class CollectedLinkPage extends StatefulWidget {
  const CollectedLinkPage({Key? key}) : super(key: key);

  @override
  _CollectedLinkPageState createState() => _CollectedLinkPageState();
}

class _CollectedLinkPageState extends State<CollectedLinkPage>
    with AutomaticKeepAliveClientMixin {
  final CollectedLinkViewModel _viewModel = CollectedLinkViewModel();

  ScrollController? _scrollController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
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
    return ViewModelProvider<CollectedLinkViewModel>(
      create: (context) => _viewModel..getLinks(),
      builder: (context, viewModel) {
        return DataProvider<CollectedLinkStatableData>(
          create: (context) => _viewModel.statableData,
          builder: (context, data) {
            if (data.value.isEmpty && data.isLoading) {
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
              slivers: _buildSlivers(data),
            );
          },
        );
      },
    );
  }

  List<Widget> _buildSlivers(CollectedLinkStatableData data) {
    return [
      ShiciRefreshHeader(
        onRefresh: () {
          return _viewModel.getLinks();
        },
      ),
      SliverMasonryGrid.extent(
        maxCrossAxisExtent: AppDimens.gridMaxCrossAxisExtent,
        childCount: data.value.length,
        itemBuilder: (BuildContext context, int index) {
          return CollectedLinkItem(
            linkBean: data.value[index],
            onDelete: _deleteLink,
            onEdit: _editLink,
          );
        },
      ),
      if (data.value.isNotEmpty)
        const SliverToBoxAdapter(
          child: PagedListFooter(
            loading: false,
            ended: true,
          ),
        ),
    ];
  }

  _deleteLink(LinkBean linkBean) {
    _viewModel.deleteLink(linkBean.id).then((success) {
      if (success) {
        _viewModel.statableData
          ..value.removeWhere((e) => e.id == linkBean.id)
          ..notify();
      }
    });
  }

  _editLink(LinkBean linkBean) {
    WanToast(
      context,
      msg: Strings.of(context).not_support,
      type: WanToastType.error,
    ).show();
  }

  _onCollectEvent(CollectEvent event) {
    _viewModel.statableData
      ..value
          .where((value) => value.link == event.link)
          .forEach((element) => element.collect = event.collect)
      ..notify();
  }
}
