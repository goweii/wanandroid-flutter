import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wanandroid/env/dimen/app_dimens.dart';
import 'package:wanandroid/env/route/router.dart';
import 'package:wanandroid/module/search/search_history.dart';
import 'package:wanandroid/module/search/search_history_sub_page.dart';
import 'package:wanandroid/module/search/search_key.dart';
import 'package:wanandroid/module/search/search_result_sub_page.dart';
import 'package:wanandroid/module/search/search_view_model.dart';

enum SearchPageState {
  history,
  result,
}

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  SearchPageState _pageState = SearchPageState.history;
  final SearchViewModel _viewModel = SearchViewModel();
  late TextEditingController _textEditingController;
  late FocusNode _textEditingFocusNode;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _textEditingFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _textEditingFocusNode.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return MultiProvider(
      providers: [
        SearchKeyProvider(),
        SearchHistoryProvider(),
      ],
      builder: (context, child) => Scaffold(
        appBar: AppBar(
          title: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimens.marginHalf,
                vertical: 0,
              ),
              decoration: BoxDecoration(
                color: themeData.hoverColor,
                borderRadius: BorderRadius.circular(AppDimens.radiusNormal),
              ),
              child: TextField(
                controller: _textEditingController,
                focusNode: _textEditingFocusNode,
                decoration: const InputDecoration(
                  constraints: BoxConstraints(
                    maxHeight:
                        AppDimens.appBarHeight - AppDimens.marginHalf * 2,
                  ),
                  contentPadding: EdgeInsets.all(0),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent)),
                ),
                cursorColor: themeData.appBarTheme.iconTheme?.color,
                style: themeData.textTheme.bodyText1?.copyWith(
                  color: themeData.appBarTheme.titleTextStyle?.color,
                ),
              ),
            ),
          ),
          leadingWidth: themeData.appBarTheme.toolbarHeight,
          titleSpacing: 0,
          leading: BackButton(
            onPressed: () {
              if (_pageState == SearchPageState.result) {
                setState(() {
                  _pageState = SearchPageState.history;
                  _textEditingController.text = '';
                });
              } else {
                AppRouter.of(context).pop();
              }
            },
          ),
          actions: [
            Center(
              child: SizedBox(
                width: themeData.appBarTheme.toolbarHeight,
                height: themeData.appBarTheme.toolbarHeight,
                child: IconButton(
                  icon: const Icon(CupertinoIcons.search),
                  onPressed: () async {
                    String key = _textEditingController.text;
                    _textEditingFocusNode.unfocus();
                    SearchKey.of(context).value = key;
                    setState(() {
                      _pageState = SearchPageState.result;
                    });
                    List<String> keys = await _viewModel.saveSearchKey(key);
                    SearchHistory.of(context).value = keys;
                  },
                ),
              ),
            ),
          ],
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            switch (_pageState) {
              case SearchPageState.history:
                return SearchHistorySubPage(
                  onSearch: (value) async {
                    _textEditingController.text = value;
                    _textEditingFocusNode.unfocus();
                    SearchKey.of(context).value = value;
                    setState(() {
                      _pageState = SearchPageState.result;
                    });
                    List<String> keys = await _viewModel.saveSearchKey(value);
                    SearchHistory.of(context).value = keys;
                  },
                );
              case SearchPageState.result:
                return const SearchResultSubPage();
            }
          },
        ),
      ),
    );
  }
}
