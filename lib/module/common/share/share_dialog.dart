import 'package:flutter/material.dart';
import 'package:wanandroid/module/common/share/share_info.dart';

class ShareDialog extends StatefulWidget {
  static Future<void> show({
    required BuildContext context,
    required ShareInfo shareInfo,
  }) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return ShareDialog(
          shareInfo: shareInfo,
        );
      },
    );
  }

  const ShareDialog({
    Key? key,
    required this.shareInfo,
  }) : super(key: key);

  final ShareInfo shareInfo;

  @override
  _ShareDialogState createState() => _ShareDialogState();
}

class _ShareDialogState extends State<ShareDialog> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
