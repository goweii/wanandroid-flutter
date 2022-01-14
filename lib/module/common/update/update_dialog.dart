import 'dart:io';
import 'package:flutter/material.dart';
import 'package:ota_update/ota_update.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wanandroid/env/dimen/app_dimens.dart';
import 'package:wanandroid/env/l10n/generated/l10n.dart';
import 'package:wanandroid/module/common/update/update_info.dart';
import 'package:wanandroid/module/common/update/update_widget.dart';
import 'package:wanandroid/widget/opacity_button.dart';

class UpdateDialog extends StatefulWidget {
  static Future<void> show({
    required BuildContext context,
    required UpdateInfo updateInfo,
  }) {
    return showDialog<void>(
      context: context,
      barrierDismissible: !updateInfo.force,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => !updateInfo.force,
          child: UpdateDialog(
            updateInfo: updateInfo,
          ),
        );
      },
    );
  }

  const UpdateDialog({
    Key? key,
    required this.updateInfo,
  }) : super(key: key);

  final UpdateInfo updateInfo;

  @override
  _UpdateDialogState createState() => _UpdateDialogState();
}

class _UpdateDialogState extends State<UpdateDialog>
    with WidgetsBindingObserver {
  DownloadButtonState currState = DownloadButtonState.initial;
  String? errorReason;
  double downloadProgress = 0.0;

  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance?.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      if (currState == DownloadButtonState.installing) {
        setState(() {
          currState = DownloadButtonState.initial;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Center(
      child: Material(
        type: MaterialType.transparency,
        child: OrientationBuilder(
          builder: (context, orientation) {
            if (orientation == Orientation.portrait) {
              return Container(
                width: 300,
                decoration: BoxDecoration(
                  color: themeData.colorScheme.surface,
                  borderRadius: BorderRadius.circular(AppDimens.radiusNormal),
                ),
                padding: const EdgeInsets.only(
                  left: AppDimens.marginNormal,
                  right: AppDimens.marginNormal,
                  top: AppDimens.marginNormal,
                  bottom: AppDimens.marginNormal,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    UpdateHeader(updateInfo: widget.updateInfo),
                    const SizedBox(height: AppDimens.marginNormal),
                    Container(
                      constraints: const BoxConstraints(
                        minWidth: double.infinity,
                        maxWidth: double.infinity,
                        minHeight: 0,
                        maxHeight: 160,
                      ),
                      decoration: BoxDecoration(
                        color: themeData.hoverColor,
                        borderRadius:
                            BorderRadius.circular(AppDimens.radiusNormal * 0.8),
                      ),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppDimens.marginNormal,
                            vertical: AppDimens.marginHalf,
                          ),
                          child: Text(
                            widget.updateInfo.desc,
                            style: themeData.textTheme.bodyText1,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppDimens.marginNormal),
                    UpdateStateButton(
                      state: currState,
                      errorReason: errorReason,
                      downloadPercent: downloadProgress,
                      onUpdateNow: _onUpdateNow,
                    ),
                    const SizedBox(height: AppDimens.marginNormal),
                    if (!widget.updateInfo.force)
                      OpacityButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          Strings.of(context).update_later,
                          style: themeData.textTheme.caption,
                        ),
                      ),
                  ],
                ),
              );
            } else {
              return Container(
                decoration: BoxDecoration(
                  color: themeData.colorScheme.surface,
                  borderRadius: BorderRadius.circular(AppDimens.radiusNormal),
                ),
                padding: const EdgeInsets.all(AppDimens.marginNormal),
                width: 600,
                height: 300,
                child: Row(
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                UpdateHeader(updateInfo: widget.updateInfo),
                                const SizedBox(height: AppDimens.marginNormal),
                                UpdateStateButton(
                                  state: currState,
                                  errorReason: errorReason,
                                  downloadPercent: downloadProgress,
                                  onUpdateNow: _onUpdateNow,
                                ),
                              ],
                            ),
                          ),
                          if (!widget.updateInfo.force)
                            OpacityButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: themeData.hoverColor,
                                  borderRadius: BorderRadius.circular(99),
                                ),
                                padding: const EdgeInsets.all(4),
                                child: Icon(
                                  Icons.close_rounded,
                                  size: 18,
                                  color: themeData.textTheme.caption?.color,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(width: AppDimens.marginNormal),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: themeData.hoverColor,
                          borderRadius: BorderRadius.circular(
                              AppDimens.radiusNormal * 0.8),
                        ),
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppDimens.marginNormal,
                              vertical: AppDimens.marginHalf,
                            ),
                            child: Text(
                              widget.updateInfo.desc,
                              style: themeData.textTheme.bodyText1,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  _onUpdateNow() {
    if (Platform.isIOS) {
      _updateIOS();
    } else if (Platform.isIOS) {
      _updateAndroid();
    } else {
      setState(() {
        currState = DownloadButtonState.error;
        errorReason = Strings.of(context).update_error;
      });
    }
  }

  _updateIOS() async {
    try {
      if (await canLaunch(widget.updateInfo.url)) {
        setState(() {
          currState = DownloadButtonState.installing;
          errorReason = null;
        });
        await launch(widget.updateInfo.url);
      } else {
        setState(() {
          currState = DownloadButtonState.error;
          errorReason = Strings.of(context).update_error;
        });
      }
    } catch (_) {
      setState(() {
        currState = DownloadButtonState.error;
        errorReason = Strings.of(context).update_error;
      });
    }
  }

  _updateAndroid() {
    try {
      OtaUpdate().execute(widget.updateInfo.url).listen(
        (OtaEvent event) {
          switch (event.status) {
            case OtaStatus.DOWNLOADING:
              setState(() {
                currState = DownloadButtonState.downloading;
                errorReason = null;
                downloadProgress =
                    (int.tryParse(event.value ?? '0') ?? 0) / 100.0;
              });
              break;
            case OtaStatus.INSTALLING:
              setState(() {
                currState = DownloadButtonState.installing;
                errorReason = null;
              });
              break;
            case OtaStatus.ALREADY_RUNNING_ERROR:
              break;
            case OtaStatus.PERMISSION_NOT_GRANTED_ERROR:
              setState(() {
                currState = DownloadButtonState.error;
                errorReason = Strings.of(context).permission_not_granted;
              });
              break;
            case OtaStatus.INTERNAL_ERROR:
              setState(() {
                currState = DownloadButtonState.error;
                errorReason = Strings.of(context).install_error;
              });
              break;
            case OtaStatus.DOWNLOAD_ERROR:
              setState(() {
                currState = DownloadButtonState.error;
                errorReason = Strings.of(context).download_error;
              });
              break;
            case OtaStatus.CHECKSUM_ERROR:
              setState(() {
                currState = DownloadButtonState.error;
                errorReason = Strings.of(context).checksum_error;
              });
              break;
          }
          setState(() {});
        },
      );
    } catch (e) {
      setState(() {
        currState = DownloadButtonState.error;
        errorReason = Strings.of(context).update_error;
      });
    }
  }
}
