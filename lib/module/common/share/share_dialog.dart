import 'package:flutter/material.dart';
import 'package:share_files_and_screenshot_widgets_plus/share_files_and_screenshot_widgets_plus.dart';
import 'package:wanandroid/env/dimen/app_dimens.dart';
import 'package:wanandroid/env/l10n/generated/l10n.dart';
import 'package:wanandroid/module/common/share/share_info.dart';
import 'package:wanandroid/module/common/share/share_widget.dart';
import 'package:wanandroid/widget/main_button.dart';

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
  int _coverIndex = 1;
  final GlobalKey _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
            left: 0,
            top: 0,
            right: 0,
            bottom: 0,
            child: Center(
              child: Container(
                margin: const EdgeInsets.only(
                  left: AppDimens.marginLarge,
                  right: AppDimens.marginLarge,
                ),
                constraints: const BoxConstraints(
                  maxWidth: AppDimens.shareCardMaxWidth,
                ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      RepaintBoundary(
                        key: _globalKey,
                        child: ShareCard(
                          cover: _coverIndex >= 0 &&
                                  _coverIndex < widget.shareInfo.imgs.length
                              ? widget.shareInfo.imgs[_coverIndex]
                              : null,
                          title: widget.shareInfo.title,
                          desc: widget.shareInfo.desc,
                          link: widget.shareInfo.url,
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: TextButton(
                          style: ButtonStyle(
                            overlayColor:
                                MaterialStateProperty.all(Colors.transparent),
                          ),
                          onPressed: () => Navigator.pop(context),
                          child: const SizedBox(height: 168),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black26,
                    Colors.transparent,
                  ],
                ),
              ),
              height: 168,
              width: double.infinity,
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.shareInfo.imgs.isNotEmpty)
                    ShareCoverSelector(
                      height: 60,
                      imgs: widget.shareInfo.imgs,
                      index: _coverIndex,
                      onTap: (value) {
                        setState(() {
                          _coverIndex = value;
                        });
                      },
                    ),
                  Container(
                    margin: const EdgeInsets.only(
                      left: AppDimens.marginNormal,
                      right: AppDimens.marginNormal,
                      top: AppDimens.marginNormal,
                      bottom: AppDimens.marginNormal,
                    ),
                    constraints: const BoxConstraints(
                      maxWidth: AppDimens.gridMaxCrossAxisExtent,
                    ),
                    child: MainButton(
                      child: Text(Strings.of(context).share_now),
                      onPressed: () async {
                        ShareFilesAndScreenshotWidgets().shareScreenshot(
                          _globalKey,
                          720,
                          Strings.of(context).share_now,
                          widget.shareInfo.title,
                          "image/jpg",
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
