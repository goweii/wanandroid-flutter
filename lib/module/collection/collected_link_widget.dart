import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:wanandroid/api/bean/link_bean.dart';
import 'package:wanandroid/entity/article_info.dart';
import 'package:wanandroid/env/dimen/app_dimens.dart';
import 'package:wanandroid/env/l10n/generated/l10n.dart';
import 'package:wanandroid/env/route/route_map.dart';
import 'package:wanandroid/env/route/router.dart';
import 'package:wanandroid/utils/string_utils.dart';

class CollectedLinkItem extends StatelessWidget {
  CollectedLinkItem({
    required this.linkBean,
    required this.onDelete,
    required this.onEdit,
  }) : super(key: ValueKey(linkBean.id));

  final LinkBean linkBean;
  final ValueChanged<LinkBean> onDelete;
  final ValueChanged<LinkBean> onEdit;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return GestureDetector(
      behavior: HitTestBehavior.deferToChild,
      child: SwipeActionCell(
        key: ValueKey('swipe_action_cell-${linkBean.id}'),
        backgroundColor: Colors.transparent,
        fullSwipeFactor: 0.5,
        trailingActions: [
          SwipeAction(
            performsFirstActionWithFullSwipe: true,
            title: Strings.of(context).delete,
            nestedAction: SwipeNestedAction(
              title: Strings.of(context).confirm_deletion,
            ),
            onTap: (CompletionHandler handler) async {
              await handler.call(true);
              onDelete(linkBean);
            },
            color: themeData.colorScheme.error,
            style: themeData.textTheme.button!.copyWith(
              color: themeData.colorScheme.onError,
            ),
          ),
          SwipeAction(
            performsFirstActionWithFullSwipe: true,
            title: Strings.of(context).edit,
            onTap: (CompletionHandler handler) async {
              await handler.call(false);
              onEdit(linkBean);
            },
            color: themeData.colorScheme.secondary,
            style: themeData.textTheme.button!.copyWith(
              color: themeData.colorScheme.onSecondary,
            ),
          ),
        ],
        child: Material(
          color: themeData.colorScheme.surface,
          child: InkWell(
            onTap: () {
              AppRouter.of(context).pushNamed(
                RouteMap.articlePage,
                arguments: ArticleInfo.fromUrl(linkBean.link),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(AppDimens.marginNormal),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    StringUtils.simplifyToSingleLine(linkBean.name),
                    style: themeData.textTheme.subtitle1,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppDimens.marginHalf),
                  Text(
                    linkBean.link,
                    style: themeData.textTheme.caption,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
