import 'package:flutter/material.dart';
import 'package:wanandroid/env/l10n/generated/l10n.dart';

class PagedListFooter extends StatelessWidget {
  const PagedListFooter({
    Key? key,
    required this.loading,
    required this.ended,
  }) : super(key: key);

  final bool loading;
  final bool ended;

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return SizedBox(
        height: 40.0,
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
        height: 40.0,
        child: Center(
          child: Text(
            Strings.of(context).paged_list_footer_ended,
            style: Theme.of(context).textTheme.caption,
          ),
        ),
      );
    }
    return SizedBox(
      height: 40.0,
      child: Center(
        child: Text(
          Strings.of(context).paged_list_footer_load_more,
          style: Theme.of(context).textTheme.caption,
        ),
      ),
    );
  }
}
