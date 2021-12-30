import 'package:flutter/material.dart';
import 'package:wanandroid/env/dimen/app_dimens.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    Key? key,
    required this.child,
    required this.onPressed,
  }) : super(key: key);

  final Widget child;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Center(child: child),
      style: ButtonStyle(
        shape: MaterialStateProperty.all(const StadiumBorder()),
        minimumSize: MaterialStateProperty.all(
            const Size(double.infinity, AppDimens.buttonHeight)),
        maximumSize: MaterialStateProperty.all(
            const Size(double.infinity, AppDimens.buttonHeight)),
        textStyle:
            MaterialStateProperty.all(Theme.of(context).textTheme.button),
        foregroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return Theme.of(context).colorScheme.onPrimary.withAlpha(150);
          }
          return Theme.of(context).colorScheme.onPrimary;
        }),
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return Theme.of(context).colorScheme.primary.withAlpha(150);
          }
          return Theme.of(context).colorScheme.primary;
        }),
        overlayColor: MaterialStateProperty.all(
            Theme.of(context).colorScheme.surface.withAlpha(50)),
        padding: MaterialStateProperty.all(const EdgeInsets.symmetric(
          horizontal: AppDimens.marginNormal,
          vertical: AppDimens.marginSmall,
        )),
        side: MaterialStateProperty.all(
            const BorderSide(color: Colors.transparent, width: 0)),
      ),
    );
  }
}
