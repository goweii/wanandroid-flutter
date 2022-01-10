import 'package:flutter/material.dart';
import 'package:wanandroid/api/wan/wan_store.dart';
import 'package:wanandroid/api/wan/wan_toast.dart';
import 'package:wanandroid/bus/bus.dart';
import 'package:wanandroid/bus/events/collent_event.dart';
import 'package:wanandroid/entity/article_info.dart';
import 'package:wanandroid/env/http/api.dart';
import 'package:wanandroid/env/l10n/generated/l10n.dart';
import 'package:wanandroid/env/route/route_map.dart';
import 'package:wanandroid/env/route/router.dart';
import 'package:wanandroid/module/article/article_repo.dart';
import 'package:wanandroid/module/article/article_widget.dart';
import 'package:wanandroid/module/article/collected_info.dart';
import 'package:wanandroid/module/share/share_article_info.dart';
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
  final ArticleRepo _articleRepo = ArticleRepo();

  double? _pageProgress;

  final Map<String, CollectInfo> collectInfos = {};

  bool _collected = false;

  @override
  void initState() {
    collectInfos[widget.articleInfo.link] = CollectInfo(
      type: widget.articleInfo.id != null
          ? CollectedType.article
          : CollectedType.link,
      link: widget.articleInfo.link,
      articleId: widget.articleInfo.id,
      title: widget.articleInfo.title,
      collected: widget.articleInfo.collected,
      author: widget.articleInfo.author,
    );
    _collected = widget.articleInfo.collected;
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
              controller: controller,
              onProgress: (value) => setState(() => _pageProgress = value),
              onUpdateVisitedHistory: (value) {
                setState(() {
                  _collected = collectInfos[value]?.collected ?? false;
                });
              },
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
                icon: _collected
                    ? Icon(
                        Icons.favorite_rounded,
                        color: Theme.of(context).colorScheme.error,
                      )
                    : const Icon(
                        Icons.favorite_outline_rounded,
                      ),
                tip: Strings.of(context).article_fab_tip_collect,
                onPressed: _onCollectPressed,
              ),
              Fab(
                icon: const Icon(Icons.share),
                tip: Strings.of(context).article_fab_tip_share,
                onPressed: () async {
                  String? title = await controller.getTitle();
                  Uri? url = await controller.getUrl();
                  AppRouter.of(context).pushNamed(
                    RouteMap.shareArticlePage,
                    arguments: ShareArticleInfo(
                      title: title,
                      link: url?.toString(),
                    ),
                  );
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

  _onCollectPressed() async {
    // 检查登录状态
    var isLogin = await WanStore().isLogin;
    if (!isLogin) {
      AppRouter.of(context).pushNamed(RouteMap.loginPage);
      return;
    }
    // 获取当前页面url
    Uri? uri = await controller.getUrl();
    if (uri == null) return;
    String url = uri.toString();
    if (url.isEmpty) return;
    // 查找或者创建 CollectInfo 对象
    CollectInfo? collectInfo = collectInfos[url];
    if (collectInfo == null) {
      collectInfo = CollectInfo(type: CollectedType.link, link: url);
      collectInfos[url] = collectInfo;
    }
    // 补全 CollectInfo 属性
    if (collectInfo.title?.isNotEmpty != true) {
      collectInfo.title = await controller.getTitle();
    }
    // 调接口
    try {
      switch (collectInfo.type) {
        case CollectedType.article:
          if (!collectInfo.collected) {
            if (collectInfo.articleId != null) {
              await _articleRepo.collectInSiteArticle(
                articleId: collectInfo.articleId!,
              );
              Bus().send(CollectEvent(
                collect: true,
                articleId: collectInfo.articleId!,
                link: collectInfo.link,
              ));
            } else {
              var articleBean = await _articleRepo.collectOffSiteArticle(
                link: collectInfo.link,
                author: collectInfo.author ?? '',
                title: collectInfo.title ?? '',
              );
              Bus().send(CollectEvent(
                collect: true,
                articleId: articleBean.id,
                link: collectInfo.link,
              ));
            }
          } else {
            if (collectInfo.articleId != null) {
              await _articleRepo.uncollectArticleByArticleId(
                articleId: collectInfo.articleId!,
              );
              Bus().send(CollectEvent(
                collect: false,
                articleId: collectInfo.articleId!,
                link: collectInfo.link,
              ));
            } else if (collectInfo.collectId != null) {
              await _articleRepo.uncollectArticleByCollectId(
                collectId: collectInfo.collectId!,
                articleId: collectInfo.articleId,
              );
              Bus().send(CollectEvent(
                collect: false,
                collectId: collectInfo.collectId,
                link: collectInfo.link,
              ));
            } else {
              throw '无法取消收藏';
            }
          }
          break;
        case CollectedType.link:
          if (!collectInfo.collected) {
            var collectLinkBean = await _articleRepo.collectLink(
              link: collectInfo.link,
              name: collectInfo.title ?? '',
            );
            collectInfo.collectId = collectLinkBean.id;
            Bus().send(CollectEvent(
              collect: true,
              collectId: collectInfo.collectId,
              link: collectInfo.link,
            ));
          } else {
            if (collectInfo.collectId != null) {
              await _articleRepo.uncollectLink(
                id: collectInfo.collectId!,
              );
              Bus().send(CollectEvent(
                collect: false,
                collectId: collectInfo.collectId,
                link: collectInfo.link,
              ));
            } else {
              throw '无法取消收藏';
            }
          }
          break;
      }
      collectInfo.collected = !collectInfo.collected;
      setState(() {
        _collected = collectInfo?.collected ?? false;
      });
    } on String catch (e) {
      WanToast.error(context, msg: e).show();
    } on ApiException catch (e) {
      WanToast.error(
        context,
        msg: e.msg ?? Strings.of(context).unknown_error,
      ).show();
    } catch (_) {
      WanToast.error(
        context,
        msg: Strings.of(context).unknown_error,
      ).show();
    }
  }
}
