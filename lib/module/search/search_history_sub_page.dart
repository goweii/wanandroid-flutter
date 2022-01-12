import 'package:flutter/material.dart';
import 'package:wanandroid/env/dimen/app_dimens.dart';
import 'package:wanandroid/env/l10n/generated/l10n.dart';
import 'package:wanandroid/env/mvvm/data_provider.dart';
import 'package:wanandroid/env/mvvm/view_model.dart';
import 'package:wanandroid/module/navigation/wrap_item.dart';
import 'package:wanandroid/module/search/search_history.dart';
import 'package:wanandroid/module/search/search_history_view_model.dart';

class SearchHistorySubPage extends StatefulWidget {
  const SearchHistorySubPage({
    Key? key,
    required this.onSearch,
  }) : super(key: key);

  final ValueChanged<String> onSearch;

  @override
  _SearchHistorySubPageState createState() => _SearchHistorySubPageState();
}

class _SearchHistorySubPageState extends State<SearchHistorySubPage> {
  final SearchHistoryViewModel _viewModel = SearchHistoryViewModel();

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<SearchHistoryViewModel>(
      create: (context) {
        _viewModel.getHotKey();
        _viewModel.getSearchHistory().then((value) {
          SearchHistory.of(context).value = value;
        });
        return _viewModel;
      },
      provide: (viewModel) => [
        DataProvider<HotKeyListData>(
            create: (context) => viewModel.hotKeyListData),
      ],
      builder: (context, viewModel) {
        return OrientationBuilder(
          builder: (context, orientation) {
            if (orientation == Orientation.portrait) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(AppDimens.marginNormal),
                    child: DataConsumer<HotKeyListData>(
                      builder: (context, data) {
                        if (data.value.isEmpty) {
                          return Container();
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Strings.of(context).search_hot_title,
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            const SizedBox(height: AppDimens.marginNormal),
                            Wrap(
                              alignment: WrapAlignment.start,
                              runAlignment: WrapAlignment.center,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              spacing: AppDimens.marginHalf,
                              runSpacing: AppDimens.marginHalf,
                              children: data.value
                                  .map((e) => WrapItem(
                                        data: e.name,
                                        onPressed: () {
                                          widget.onSearch(e.name);
                                        },
                                      ))
                                  .toList(),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(AppDimens.marginNormal),
                      child: SearchHistoryConsumer(
                        builder: (context, data) {
                          if (data.value.isEmpty) {
                            return Container();
                          }
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                Strings.of(context).search_history_title,
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              const SizedBox(height: AppDimens.marginNormal),
                              Wrap(
                                alignment: WrapAlignment.start,
                                runAlignment: WrapAlignment.center,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                spacing: AppDimens.marginHalf,
                                runSpacing: AppDimens.marginHalf,
                                children: data.value
                                    .map((e) => WrapItem(
                                          data: e,
                                          onPressed: () {
                                            widget.onSearch(e);
                                          },
                                        ))
                                    .toList(),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(AppDimens.marginNormal),
                      child: DataConsumer<HotKeyListData>(
                        builder: (context, data) {
                          if (data.value.isEmpty) {
                            return Container();
                          }
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                Strings.of(context).search_hot_title,
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              const SizedBox(height: AppDimens.marginNormal),
                              Wrap(
                                alignment: WrapAlignment.start,
                                runAlignment: WrapAlignment.center,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                spacing: AppDimens.marginHalf,
                                runSpacing: AppDimens.marginHalf,
                                children: data.value
                                    .map((e) => WrapItem(
                                          data: e.name,
                                          onPressed: () {
                                            widget.onSearch(e.name);
                                          },
                                        ))
                                    .toList(),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(AppDimens.marginNormal),
                      child: SearchHistoryConsumer(
                        builder: (context, data) {
                          if (data.value.isEmpty) {
                            return Container();
                          }
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                Strings.of(context).search_history_title,
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              const SizedBox(height: AppDimens.marginNormal),
                              Wrap(
                                alignment: WrapAlignment.start,
                                runAlignment: WrapAlignment.center,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                spacing: AppDimens.marginHalf,
                                runSpacing: AppDimens.marginHalf,
                                children: data.value
                                    .map((e) => WrapItem(
                                          data: e,
                                          onPressed: () {
                                            widget.onSearch(e);
                                          },
                                        ))
                                    .toList(),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        );
      },
    );
  }
}
