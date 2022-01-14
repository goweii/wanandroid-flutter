import 'package:flutter/material.dart';
import 'package:wanandroid/env/asset/app_images.dart';
import 'package:wanandroid/env/dimen/app_dimens.dart';
import 'package:wanandroid/env/l10n/generated/l10n.dart';
import 'package:wanandroid/module/update/update_info.dart';

class UpdateHeader extends StatelessWidget {
  const UpdateHeader({
    Key? key,
    required this.updateInfo,
  }) : super(key: key);

  final UpdateInfo updateInfo;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Column(
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
          Strings.of(context).version_perfix + updateInfo.versionName,
          style: themeData.textTheme.subtitle2,
        ),
        const SizedBox(height: AppDimens.marginHalf),
        Text(
          Strings.of(context).date_perfix + updateInfo.date,
          style: themeData.textTheme.caption,
        )
      ],
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


enum DownloadButtonState {
  initial,
  downloading,
  installing,
  error,
}

class UpdateStateButton extends StatelessWidget {
  const UpdateStateButton({
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