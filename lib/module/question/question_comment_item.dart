import 'package:flutter/material.dart';
import 'package:wanandroid/api/wan/bean/question_commen_bean.dart';
import 'package:wanandroid/env/dimen/app_dimens.dart';
import 'package:wanandroid/widget/html_view.dart';

class QuestionCommentItem extends StatefulWidget {
  const QuestionCommentItem({
    Key? key,
    required this.comment,
  }) : super(key: key);

  final QuestionCommentBean comment;

  @override
  State<QuestionCommentItem> createState() => _QuestionCommentItemState();
}

class _QuestionCommentItemState extends State<QuestionCommentItem> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.surface,
      child: InkWell(
        onTap: () {},
        child: _ItemCard(
          comment: widget.comment,
        ),
      ),
    );
  }
}

class _ItemCard extends StatelessWidget {
  const _ItemCard({
    Key? key,
    required this.comment,
  }) : super(key: key);

  final QuestionCommentBean comment;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppDimens.marginNormal,
            AppDimens.marginNormal,
            AppDimens.marginNormal,
            AppDimens.marginSmall,
          ),
          child: _ItemTopBar(comment: comment),
        ),
        Container(
          //color: Colors.amber,
          padding: const EdgeInsets.fromLTRB(
            AppDimens.marginSmall,
            AppDimens.marginSmall,
            AppDimens.marginSmall,
            AppDimens.marginSmall,
          ),
          child: _ItemContentBar(comment: comment),
        ),
        Container(
          color: Theme.of(context).backgroundColor,
          height: AppDimens.line,
        )
      ],
    );
  }
}

class _ItemTopBar extends StatelessWidget {
  const _ItemTopBar({
    Key? key,
    required this.comment,
  }) : super(key: key);

  final QuestionCommentBean comment;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.thumb_up_alt_rounded,
          size: 18,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(width: AppDimens.marginSmall),
        Text(
          '${comment.zan}',
          style: Theme.of(context).textTheme.caption?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
        const SizedBox(width: AppDimens.marginHalf),
        Text(
          comment.userName,
          style: Theme.of(context).textTheme.caption,
        ),
        if (comment.toUserId > 0)
          Text(
            ' @ ${comment.toUserName}',
            style: Theme.of(context).textTheme.caption,
          ),
        const Spacer(),
        Text(
          comment.niceDate,
          style: Theme.of(context).textTheme.caption,
        ),
      ],
    );
  }
}

class _ItemContentBar extends StatelessWidget {
  const _ItemContentBar({
    Key? key,
    required this.comment,
  }) : super(key: key);

  final QuestionCommentBean comment;

  @override
  Widget build(BuildContext context) {
    return HtmlView(data: comment.content);
  }
}
