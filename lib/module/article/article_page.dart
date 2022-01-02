import 'package:flutter/material.dart';
import 'package:wanandroid/api/wan_toast.dart';
import 'package:wanandroid/entity/article_info.dart';
import 'package:wanandroid/env/l10n/generated/l10n.dart';
import 'package:wanandroid/env/route/router.dart';
import 'package:wanandroid/module/article/article_widget.dart';
import 'package:wanandroid/widget/expendable_fab.dart';

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
            actions: [
              Fab(
                icon: const Icon(Icons.power_settings_new_rounded),
                tip: Strings.of(context).article_fab_tip_close,
                onPressed: () {
                  AppRouter.of(context).pop();
                },
              ),
              Fab(
                icon: widget.articleInfo.collected
                    ? Icon(
                        Icons.favorite_rounded,
                        color: Theme.of(context).colorScheme.error,
                      )
                    : const Icon(
                        Icons.favorite_outline_rounded,
                        // color: Theme.of(context).colorScheme.primary,
                      ),
                tip: Strings.of(context).article_fab_tip_collect,
                onPressed: () {},
              ),
              Fab(
                icon: const Icon(Icons.share),
                tip: Strings.of(context).article_fab_tip_share,
                onPressed: () {
                  WanToast(
                    context,
                    msg: "Not supported!",
                    type: WanToastType.error,
                  ).show();
                },
              ),
            ],
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
    AppRouter.of(context).pop();
  }
}
