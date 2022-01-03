import 'package:flutter/material.dart';
import 'package:wanandroid/env/dimen/app_dimens.dart';
import 'package:wanandroid/utils/string_utils.dart';

class WrapItem extends StatelessWidget {
  const WrapItem({
    Key? key,
    required this.data,
    required this.onPressed,
  }) : super(key: key);

  final String data;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Material(
      shape: const StadiumBorder(),
      color: themeData.hoverColor,
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              constraints: const BoxConstraints(
                minWidth: AppDimens.smallButtonHeight,
                minHeight: AppDimens.smallButtonHeight,
                maxHeight: AppDimens.smallButtonHeight,
                maxWidth: double.infinity,
              ),
              padding: const EdgeInsets.fromLTRB(
                AppDimens.marginNormal,
                AppDimens.marginSmall,
                AppDimens.marginNormal,
                AppDimens.marginSmall,
              ),
              child: Text(
                StringUtils.simplifyToSingleLine(data),
                style: themeData.textTheme.subtitle2?.copyWith(
                  height: 1.5,
                ),
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
