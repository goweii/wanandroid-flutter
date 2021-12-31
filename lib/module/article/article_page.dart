import 'package:flutter/material.dart';
import 'package:wanandroid/entity/article_info.dart';
import 'package:wanandroid/module/article/article_widget.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({
    Key? key,
    required this.articleInfo,
  }) : super(key: key);

  final ArticleInfo articleInfo;

  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage>
    with SingleTickerProviderStateMixin {
  final WebController controller = WebController();

  double? _pageProgress;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var statusBarBrightness = ThemeData.estimateBrightnessForColor(
        Theme.of(context).colorScheme.surface);
    var statusBarIconBrightness = statusBarBrightness == Brightness.light
        ? Brightness.dark
        : Brightness.light;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        systemOverlayStyle:
            Theme.of(context).appBarTheme.systemOverlayStyle?.copyWith(
                  statusBarBrightness: statusBarBrightness,
                  statusBarIconBrightness: statusBarIconBrightness,
                ),
        toolbarHeight: 0,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          SizedBox.expand(
            child: Web(
              url: widget.articleInfo.link,
              onProgress: (value) => setState(() => _pageProgress = value),
              controller: controller,
            ),
          ),
          FabMenu(
            progress: _pageProgress,
            onBackPress: _handleBackPress,
          ),
        ],
      ),
    );
  }

  _handleBackPress() async {
    if (await controller.canGoBack()) {
      await controller.goBack();
      return;
    }
    Navigator.of(context).pop();
  }
}
