import 'package:flutter/material.dart';
import 'package:wanandroid/api/bean/article_bean.dart';
import 'package:wanandroid/api/wan_store.dart';
import 'package:wanandroid/bus/bus.dart';
import 'package:wanandroid/bus/events/collent_event.dart';
import 'package:wanandroid/entity/article_info.dart';
import 'package:wanandroid/env/dimen/app_dimens.dart';
import 'package:wanandroid/env/l10n/generated/l10n.dart';
import 'package:wanandroid/env/route/route_map.dart';
import 'package:wanandroid/env/route/router.dart';
import 'package:wanandroid/module/article/article_repo.dart';
import 'package:wanandroid/utils/string_utils.dart';

class ArticleItem extends StatefulWidget {
  const ArticleItem({
    Key? key,
    required this.article,
    this.top = false,
    this.onPressed,
  }) : super(key: key);

  final ArticleBean article;
  final bool top;
  final ValueChanged<ArticleBean>? onPressed;

  @override
  State<ArticleItem> createState() => _ArticleItemState();
}

class _ArticleItemState extends State<ArticleItem> {
  final ArticleRepo _articleRepo = ArticleRepo();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.surface,
      child: InkWell(
        onTap: widget.onPressed != null
            ? () => widget.onPressed?.call(widget.article)
            : _onPressed,
        child: _ArticleCard(
          article: widget.article,
          top: widget.top,
          onCollectPressed: _onCollectPressed,
        ),
      ),
    );
  }

  _onPressed() {
    AppRouter.of(context).pushNamed(
      RouteMap.articlePage,
      arguments: ArticleInfo.fromArticleBean(widget.article),
    );
  }

  /// originId == null 说明是在文章列表
  /// originId != null 说明是在收藏列表，这个时候id为收藏id
  _onCollectPressed() async {
    var isLogin = await WanStore().isLogin;
    if (!isLogin) {
      AppRouter.of(context).pushNamed(RouteMap.loginPage);
      return;
    }
    var article = widget.article;
    try {
      if (!article.collect) {
        if (article.originId == null) {
          await _articleRepo.collectArticle(
            articleId: article.id,
          );
          Bus().send(CollectEvent(
            collect: true,
            articleId: article.id,
          ));
        } else {
          await _articleRepo.collectArticle(
            articleId: article.originId!,
          );
          Bus().send(CollectEvent(
            collect: true,
            articleId: article.originId!,
            collectId: article.id,
          ));
        }
      } else {
        if (article.originId == null) {
          await _articleRepo.uncollectByArticleId(
            articleId: article.id,
          );
          Bus().send(CollectEvent(
            collect: false,
            articleId: article.id,
          ));
        } else {
          await _articleRepo.uncollectByCollectId(
            collectId: article.id,
          );
          Bus().send(CollectEvent(
            collect: false,
            articleId: article.originId!,
            collectId: article.id,
          ));
        }
      }
      setState(() {
        article.collect = !article.collect;
      });
    } catch (_) {}
  }
}

class _ArticleCard extends StatelessWidget {
  const _ArticleCard({
    Key? key,
    required this.article,
    required this.top,
    required this.onCollectPressed,
  }) : super(key: key);

  final ArticleBean article;
  final bool top;
  final VoidCallback onCollectPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimens.marginNormal),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ItemTopBar(article: article),
          const SizedBox(height: AppDimens.marginHalf),
          _ItemContentBar(article: article),
          const SizedBox(height: AppDimens.marginHalf),
          _ItemBottomBar(
            article: article,
            top: top,
            onCollectPressed: onCollectPressed,
          ),
        ],
      ),
    );
  }
}

class _ItemTopBar extends StatelessWidget {
  const _ItemTopBar({
    Key? key,
    required this.article,
  }) : super(key: key);

  final ArticleBean article;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (article.fresh) ...[
          Text(
            Strings.of(context).new_tag,
            style: Theme.of(context).textTheme.caption?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
          const SizedBox(width: AppDimens.marginHalf),
        ],
        Text(
          (article.author ?? "").isNotEmpty
              ? article.author!
              : (article.shareUser ?? "").isNotEmpty
                  ? article.shareUser!
                  : Strings.of(context).unknown_username,
          style: Theme.of(context).textTheme.caption,
        ),
        if (article.tags != null && article.tags!.isNotEmpty) ...[
          const SizedBox(width: AppDimens.marginHalf),
          Container(
            padding: const EdgeInsets.fromLTRB(2, 2, 2, 1),
            child: Center(
              child: Text(
                article.tags!.first.name,
                style: Theme.of(context).textTheme.overline?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      height: 1.0,
                      fontSize: 11.0,
                    ),
              ),
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).colorScheme.primary,
                width: 1.0,
                style: BorderStyle.solid,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(AppDimens.radiusSmall),
              ),
            ),
          ),
        ],
        const Spacer(),
        Text(
          article.niceDate ?? "",
          style: Theme.of(context).textTheme.caption,
        ),
      ],
    );
  }
}

class _ItemContentBar extends StatelessWidget {
  const _ItemContentBar({
    Key? key,
    required this.article,
  }) : super(key: key);

  final ArticleBean article;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (article.envelopePic?.isNotEmpty == true) ...[
          _Cover(url: article.envelopePic!),
          const SizedBox(width: AppDimens.marginHalf),
        ],
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Title(
                title: article.title ?? '',
                lines: article.desc?.isNotEmpty == true ? 1 : 3,
              ),
              if (article.desc?.isNotEmpty == true) ...[
                const SizedBox(height: AppDimens.marginSmall),
                _Subtitle(subtitle: article.desc!),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _ItemBottomBar extends StatelessWidget {
  const _ItemBottomBar({
    Key? key,
    required this.article,
    required this.top,
    required this.onCollectPressed,
  }) : super(key: key);

  final ArticleBean article;
  final bool top;
  final VoidCallback onCollectPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (top) ...[
          Text(
            Strings.of(context).top_tag,
            style: Theme.of(context).textTheme.caption?.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
          ),
          const SizedBox(width: AppDimens.marginHalf),
        ],
        Text(
          [article.superChapterName, article.chapterName]
              .skipWhile((value) => value == null || value.isEmpty)
              .join("･"),
          style: Theme.of(context).textTheme.caption,
        ),
        const Spacer(),
        IconButton(
          onPressed: onCollectPressed,
          constraints: const BoxConstraints.tightForFinite(),
          padding: EdgeInsets.zero,
          splashRadius: 12 + AppDimens.marginSmall,
          iconSize: 24,
          icon: Icon(
            article.collect ? Icons.favorite_rounded : Icons.favorite_rounded,
            color: !article.collect
                ? Theme.of(context).textTheme.caption?.color
                : Theme.of(context).colorScheme.error,
          ),
        )
      ],
    );
  }
}

class _Cover extends StatelessWidget {
  const _Cover({
    Key? key,
    required this.url,
  }) : super(key: key);

  final String url;
  final double height = 90.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: height * (4.0 / 3.0),
      height: height,
      child: ClipRRect(
        borderRadius:
            const BorderRadius.all(Radius.circular(AppDimens.radiusSmall)),
        child: Image.network(
          url,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  _Title({
    Key? key,
    required String title,
    required this.lines,
  })  : title = StringUtils.simplifyToSingleLine(title),
        super(key: key);

  final String title;
  final int lines;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      overflow: TextOverflow.ellipsis,
      maxLines: lines,
      style: Theme.of(context).textTheme.subtitle1,
    );
  }
}

class _Subtitle extends StatelessWidget {
  _Subtitle({
    Key? key,
    required String subtitle,
  })  : subtitle = StringUtils.simplifyToSingleLine(subtitle),
        super(key: key);

  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Text(
      subtitle,
      overflow: TextOverflow.ellipsis,
      maxLines: 3,
      style: Theme.of(context).textTheme.subtitle2,
    );
  }
}
