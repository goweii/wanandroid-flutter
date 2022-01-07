import 'package:flutter/material.dart';
import 'package:wanandroid/api/bean/message_bean.dart';
import 'package:wanandroid/entity/article_info.dart';
import 'package:wanandroid/env/dimen/app_dimens.dart';
import 'package:wanandroid/env/route/route_map.dart';
import 'package:wanandroid/env/route/router.dart';
import 'package:wanandroid/utils/string_utils.dart';

class MessageItem extends StatefulWidget {
  const MessageItem({
    Key? key,
    required this.message,
  }) : super(key: key);

  final MessageBean message;

  @override
  State<MessageItem> createState() => _MessageItemState();
}

class _MessageItemState extends State<MessageItem> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.surface,
      child: InkWell(
        onTap: _onPressed,
        child: _MessageCard(
          message: widget.message,
        ),
      ),
    );
  }

  _onPressed() {
    AppRouter.of(context).pushNamed(
      RouteMap.articlePage,
      arguments: ArticleInfo(
        id: null,
        title: null,
        author: null,
        cover: null,
        link: widget.message.fullLink,
      ),
    );
  }
}

class _MessageCard extends StatelessWidget {
  const _MessageCard({
    Key? key,
    required this.message,
  }) : super(key: key);

  final MessageBean message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimens.marginNormal),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _ItemTopBar(message: message),
          const SizedBox(height: AppDimens.marginHalf),
          _ItemContentBar(message: message),
        ],
      ),
    );
  }
}

class _ItemTopBar extends StatelessWidget {
  const _ItemTopBar({
    Key? key,
    required this.message,
  }) : super(key: key);

  final MessageBean message;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (message.isRead == 0) ...[
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.error,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: AppDimens.marginHalf),
        ],
        Text(
          message.fromUser,
          style: Theme.of(context).textTheme.caption,
        ),
        if (message.tag.isNotEmpty) ...[
          const SizedBox(width: AppDimens.marginHalf),
          Container(
            padding: const EdgeInsets.fromLTRB(2, 2, 2, 1),
            child: Center(
              child: Text(
                message.tag,
                style: Theme.of(context).textTheme.overline?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      height: 1.1,
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
          message.niceDate,
          style: Theme.of(context).textTheme.caption,
        ),
      ],
    );
  }
}

class _ItemContentBar extends StatelessWidget {
  const _ItemContentBar({
    Key? key,
    required this.message,
  }) : super(key: key);

  final MessageBean message;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Title(title: message.title),
        if (message.message.isNotEmpty) ...[
          const SizedBox(height: AppDimens.marginHalf),
          _Subtitle(subtitle: message.message),
        ],
      ],
    );
  }
}

class _Title extends StatelessWidget {
  _Title({
    Key? key,
    required String title,
  })  : title = StringUtils.simplifyToSingleLine(title),
        super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
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
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimens.marginHalf),
      decoration: BoxDecoration(
        color: Theme.of(context).hoverColor,
        borderRadius: BorderRadius.circular(AppDimens.radiusSmall),
      ),
      child: Text(
        subtitle,
        style: Theme.of(context).textTheme.subtitle2,
      ),
    );
  }
}
