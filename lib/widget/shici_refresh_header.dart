import 'package:flutter/cupertino.dart'
    show CupertinoSliverRefreshControl, RefreshIndicatorMode;
import 'package:flutter/material.dart';
import 'package:wanandroid/env/l10n/generated/l10n.dart';

typedef RefreshWithResultCallback = Future<bool> Function();

class ShiciRefreshHeader extends StatefulWidget {
  const ShiciRefreshHeader({
    Key? key,
    required this.onRefresh,
  }) : super(key: key);

  final RefreshWithResultCallback? onRefresh;

  @override
  _ShiciRefreshHeaderState createState() => _ShiciRefreshHeaderState();
}

class _ShiciRefreshHeaderState extends State<ShiciRefreshHeader> {
  bool _success = true;

  @override
  Widget build(BuildContext context) {
    return CupertinoSliverRefreshControl(
      onRefresh: () async {
        if (widget.onRefresh == null) return;
        var result = await widget.onRefresh!.call();
        _success = result;
      },
      builder: (context, refreshState, pulledExtent, refreshTriggerPullDistance,
          refreshIndicatorExtent) {
        final String text;
        switch (refreshState) {
          case RefreshIndicatorMode.inactive:
            return Container();
          case RefreshIndicatorMode.drag:
            text = Strings.of(context).refresh_header_state_pull_to_refresh;
            break;
          case RefreshIndicatorMode.armed:
          case RefreshIndicatorMode.refresh:
            text = Strings.of(context).refresh_header_state_refreshing;
            break;
          case RefreshIndicatorMode.done:
            if (_success) {
              text = Strings.of(context).refresh_header_state_refresh_success;
            } else {
              text = Strings.of(context).refresh_header_state_refresh_failed;
            }
            break;
        }
        return Center(
          child: Text(
            text,
            style: Theme.of(context).textTheme.caption,
          ),
        );
      },
    );
  }
}
