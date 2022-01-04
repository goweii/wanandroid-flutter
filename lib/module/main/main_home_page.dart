import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid/env/dimen/app_dimens.dart';
import 'package:wanandroid/env/l10n/generated/l10n.dart';
import 'package:wanandroid/module/home/home_page.dart';
import 'package:wanandroid/module/mine/mine_page.dart';
import 'package:wanandroid/module/navigation/navigation_page.dart';
import 'package:wanandroid/module/question/question_page.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({
    Key? key,
    required this.onPageChanged,
  }) : super(key: key);

  final ValueChanged<int>? onPageChanged;

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController? _tabController;

  int _index = -1;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this)
      ..addListener(() {
        if (_tabController != null && _index != _tabController?.index) {
          _index = _tabController!.index;
          widget.onPageChanged?.call(_index);
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Material(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: TabBarView(
              controller: _tabController,
              dragStartBehavior: DragStartBehavior.start,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                HomePage(),
                QuestionPage(),
                NavigationPage(),
                MinePage(),
              ],
            ),
          ),
          Container(
            height: AppDimens.bottomBarHeight,
            color: Theme.of(context).colorScheme.surface,
            child: Column(
              children: [
                SizedBox(
                  height: AppDimens.lineThin,
                  child: Container(
                    color: Theme.of(context).dividerColor,
                  ),
                ),
                Expanded(
                  child: TabBar(
                    padding: EdgeInsets.zero,
                    unselectedLabelColor:
                        Theme.of(context).colorScheme.onSurface.withAlpha(100),
                    labelColor: Theme.of(context).colorScheme.primary,
                    labelPadding: EdgeInsets.zero,
                    labelStyle: Theme.of(context).textTheme.caption?.copyWith(
                          fontSize: 12.0,
                        ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorColor: Colors.transparent,
                    indicatorWeight: 0.00001,
                    controller: _tabController,
                    tabs: [
                      Tab(
                        height: AppDimens.bottomBarHeight,
                        icon: const Icon(Icons.home_rounded),
                        iconMargin: const EdgeInsets.only(bottom: 0),
                        text: Strings.of(context).home_title,
                      ),
                      Tab(
                        icon: const Icon(Icons.question_answer_rounded),
                        iconMargin: const EdgeInsets.only(bottom: 0),
                        text: Strings.of(context).question_title,
                      ),
                      Tab(
                        icon: const Icon(Icons.navigation_rounded),
                        iconMargin: const EdgeInsets.only(bottom: 0),
                        text: Strings.of(context).navigation_title,
                      ),
                      Tab(
                        icon: const Icon(Icons.person_rounded),
                        iconMargin: const EdgeInsets.only(bottom: 0),
                        text: Strings.of(context).mine_title,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
