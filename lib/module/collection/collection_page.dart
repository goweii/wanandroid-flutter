import 'package:flutter/material.dart';
import 'package:wanandroid/env/l10n/generated/l10n.dart';
import 'package:wanandroid/module/collection/collected_article_page.dart';
import 'package:wanandroid/module/collection/collected_link_page.dart';

class CollectionPage extends StatefulWidget {
  const CollectionPage({Key? key}) : super(key: key);

  @override
  _CollectionPageState createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TabBar(
          isScrollable: true,
          indicatorWeight: 0.0001,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorColor: Colors.transparent,
          controller: _tabController,
          labelStyle: Theme.of(context).appBarTheme.titleTextStyle,
          overlayColor: MaterialStateProperty.resolveWith((states) {
            return Colors.transparent;
          }),
          tabs: [
            Tab(text: Strings.of(context).collected_article),
            Tab(text: Strings.of(context).collected_link),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          CollectedArticlePage(),
          CollectedLinkPage(),
        ],
      ),
    );
  }
}
