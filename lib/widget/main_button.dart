import 'package:flutter/material.dart';
import 'package:wanandroid/env/dimen/app_dimens.dart';

enum BtnState {
  text,
  loading,
}

class MainButton extends StatelessWidget {
  const MainButton({
    Key? key,
    required this.child,
    required this.onPressed,
    this.state = BtnState.text,
  }) : super(key: key);

  final Widget child;
  final VoidCallback? onPressed;
  final BtnState state;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: _btnWidth,
      height: AppDimens.buttonHeight,
      child: _buildChild(context),
    );
  }

  double get _btnWidth {
    switch (state) {
      case BtnState.text:
        return 300;
      case BtnState.loading:
        return AppDimens.buttonHeight;
    }
  }

  Widget _buildChild(BuildContext context) {
    switch (state) {
      case BtnState.text:
        return _buildText(context);
      case BtnState.loading:
        return _buildLoading(context);
    }
  }

  Widget _buildLoading(BuildContext context) {
    return SizedBox.expand(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: const BorderRadius.all(
              Radius.circular(AppDimens.buttonHeight * 0.5)),
        ),
        child: Center(
          child: CircularProgressIndicator(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }

  Widget _buildText(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Center(child: child),
      style: ButtonStyle(
        shape: MaterialStateProperty.all(const StadiumBorder()),
        minimumSize: MaterialStateProperty.all(
            const Size(AppDimens.buttonHeight, AppDimens.buttonHeight)),
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
