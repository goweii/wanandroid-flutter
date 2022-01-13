import 'package:flutter/material.dart';
import 'package:ota_update/ota_update.dart';
import 'package:wanandroid/env/asset/app_images.dart';
import 'package:wanandroid/env/dimen/app_dimens.dart';
import 'package:wanandroid/env/l10n/generated/l10n.dart';
import 'package:wanandroid/module/update/update_info.dart';

class UpdateDialog extends Dialog {
  UpdateDialog({
    Key? key,
    required UpdateInfo updateInfo,
  }) : super(
            key: key,
            child: UpdateDialog(
              updateInfo: updateInfo,
            ));
}

class UpdateDialogWidget extends StatefulWidget {
  const UpdateDialogWidget({
    Key? key,
    required this.updateInfo,
  }) : super(key: key);

  final UpdateInfo updateInfo;

  @override
  _UpdateDialogWidgetState createState() => _UpdateDialogWidgetState();
}

class _UpdateDialogWidgetState extends State<UpdateDialogWidget>
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
                    Logo(
                      size: 120,
                      color: themeData.colorScheme.primary,
                    ),
                    Text(
                      Strings.of(context).update_title,
                      style: themeData.textTheme.subtitle1,
                    ),
                    const SizedBox(height: AppDimens.marginHalf),
                    Text(
                      Strings.of(context).version_perfix +
                          widget.updateInfo.versionName,
                      style: themeData.textTheme.subtitle2,
                    ),
                    const SizedBox(height: AppDimens.marginHalf),
                    Text(
                      Strings.of(context).date_perfix + widget.updateInfo.date,
                      style: themeData.textTheme.caption,
                    ),
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
                    DownloadButton(
                      state: currState,
                      errorReason: errorReason,
                      downloadPercent: downloadProgress,
                      onUpdateNow: _onUpdateNow,
                    ),
                    const SizedBox(height: AppDimens.marginNormal),
                  ],
                ),
              );
            } else {
              return Container(
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
                width: 600,
                height: 300,
                child: Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Logo(
                              size: 120,
                              color: themeData.colorScheme.primary,
                            ),
                            Text(
                              Strings.of(context).update_title,
                              style: themeData.textTheme.subtitle1,
                            ),
                            const SizedBox(height: AppDimens.marginHalf),
                            Text(
                              Strings.of(context).version_perfix +
                                  widget.updateInfo.versionName,
                              style: themeData.textTheme.subtitle2,
                            ),
                            const SizedBox(height: AppDimens.marginHalf),
                            Text(
                              Strings.of(context).date_perfix +
                                  widget.updateInfo.date,
                              style: themeData.textTheme.caption,
                            ),
                            const SizedBox(height: AppDimens.marginNormal),
                            DownloadButton(
                              state: currState,
                              errorReason: errorReason,
                              downloadPercent: downloadProgress,
                              onUpdateNow: _onUpdateNow,
                            ),
                          ],
                        ),
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

enum DownloadButtonState {
  initial,
  downloading,
  installing,
  error,
}

class DownloadButton extends StatelessWidget {
  const DownloadButton({
    Key? key,
    required this.state,
    required this.onUpdateNow,
    this.downloadPercent = 0.2,
    this.errorReason,
  }) : super(key: key);

  final DownloadButtonState state;
  final double downloadPercent;
  final String? errorReason;
  final VoidCallback onUpdateNow;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final Strings strings = Strings.of(context);
    Widget widget;
    switch (state) {
      case DownloadButtonState.initial:
        widget = Material(
          color: themeData.colorScheme.primary,
          borderRadius: BorderRadius.circular(99),
          clipBehavior: Clip.hardEdge,
          child: InkWell(
            onTap: onUpdateNow,
            child: Center(
              child: Text(
                strings.update_now,
                style: themeData.textTheme.button?.copyWith(
                  color: themeData.colorScheme.onPrimary,
                ),
              ),
            ),
          ),
        );
        break;
      case DownloadButtonState.downloading:
        widget = Stack(
          children: [
            ClipRect(
              child: AnimatedAlign(
                alignment: Alignment.centerLeft,
                duration: const Duration(milliseconds: 100),
                widthFactor: downloadPercent.clamp(0.0, 1.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: themeData.colorScheme.primary,
                    borderRadius: BorderRadius.circular(99),
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: themeData.colorScheme.primary.withOpacity(0.3),
                borderRadius: BorderRadius.circular(99),
              ),
              child: Center(
                child: Text(
                  '${strings.downloading}(${(downloadPercent * 100).round()}%)',
                  style: themeData.textTheme.button?.copyWith(
                    color: themeData.colorScheme.onPrimary,
                  ),
                ),
              ),
            ),
          ],
        );
        break;
      case DownloadButtonState.installing:
        widget = Container(
          decoration: BoxDecoration(
            color: themeData.colorScheme.primary.withOpacity(0.3),
            borderRadius: BorderRadius.circular(99),
          ),
          child: Center(
            child: Text(
              strings.installing,
              style: themeData.textTheme.button?.copyWith(
                color: themeData.colorScheme.onPrimary,
              ),
            ),
          ),
        );
        break;
      case DownloadButtonState.error:
        widget = Material(
          color: themeData.colorScheme.error,
          borderRadius: BorderRadius.circular(99),
          clipBehavior: Clip.hardEdge,
          child: InkWell(
            onTap: onUpdateNow,
            child: Center(
              child: Text(
                errorReason ?? Strings.of(context).unknown_error,
                style: themeData.textTheme.button?.copyWith(
                  color: themeData.colorScheme.onError,
                ),
              ),
            ),
          ),
        );
        break;
    }
    return SizedBox(
      width: double.infinity,
      height: AppDimens.buttonHeight,
      child: widget,
    );
  }
}

class Logo extends StatelessWidget {
  const Logo({
    Key? key,
    this.size,
    this.color,
  }) : super(key: key);

  final double? size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppImages.logo,
      color: color,
      width: size,
      height: size,
      fit: BoxFit.contain,
    );
  }
}
