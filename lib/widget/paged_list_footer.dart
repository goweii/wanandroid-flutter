import 'package:flutter/material.dart';
import 'package:wanandroid/env/dimen/app_dimens.dart';
import 'package:wanandroid/env/l10n/generated/l10n.dart';
import 'package:wanandroid/widget/opacity_button.dart';

class PagedListFooter extends StatelessWidget {
  const PagedListFooter({
    Key? key,
    required this.loading,
    required this.ended,
    required this.onLoadMoreTap,
  }) : super(key: key);

  final bool loading;
  final bool ended;
  final VoidCallback onLoadMoreTap;

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return SizedBox(
        height: AppDimens.buttonHeight,
        child: Center(
          child: Text(
            Strings.of(context).paged_list_footer_loading,
            style: Theme.of(context).textTheme.caption,
          ),
        ),
      );
    }
    if (ended) {
      return SizedBox(
        height: AppDimens.buttonHeight,
        child: Center(
          child: Text(
            Strings.of(context).paged_list_footer_ended,
            style: Theme.of(context).textTheme.caption,
          ),
        ),
      );
    }
    return SizedBox(
      height: AppDimens.buttonHeight,
      child: Center(
        child: OpacityButton(
          onPressed: onLoadMoreTap,
          child: Text(
            Strings.of(context).paged_list_footer_load_more,
            style: Theme.of(context).textTheme.caption,
          ),
        ),
      ),
    );
  }
}
