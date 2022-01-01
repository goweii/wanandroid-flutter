import 'package:flutter/material.dart';
import 'package:wanandroid/env/dimen/app_dimens.dart';
import 'package:wanandroid/env/toast/toast.dart';

enum WanToastType {
  tip,
  success,
  error,
}

class WanToast extends Toast {
  WanToast(
    BuildContext context, {
    required String msg,
    WanToastType type = WanToastType.tip,
  }) : super(
          context,
          builder: (context, animation) {
            return _AnimatedWanToastView(
              animation: animation,
              child: _WanToastView(
                msg: msg,
                type: type,
              ),
            );
          },
        );
}

class _AnimatedWanToastView extends StatefulWidget {
  final Widget child;
  final Animation<double> animation;

  const _AnimatedWanToastView({
    Key? key,
    required this.child,
    required this.animation,
  }) : super(key: key);

  @override
  State<_AnimatedWanToastView> createState() => _AnimatedWanToastViewState();
}

class _AnimatedWanToastViewState extends State<_AnimatedWanToastView> {
  late Animation<double> _animation;

  @override
  void initState() {
    _animation = CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.easeOutQuad,
      parent: widget.animation,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Opacity(
            opacity: _animation.value,
            child: Transform.scale(
              scale: 0.8 + (0.2 * _animation.value),
              child: widget.child,
            ),
          );
        },
      ),
    );
  }
}

class _WanToastView extends StatelessWidget {
  final String msg;
  final WanToastType type;
  const _WanToastView({
    Key? key,
    required this.msg,
    required this.type,
  }) : super(key: key);

  Color _backgroundColor(BuildContext context) {
    switch (type) {
      case WanToastType.tip:
        return Theme.of(context).colorScheme.background.withOpacity(0.96);
      case WanToastType.success:
        return Theme.of(context).colorScheme.secondary.withOpacity(0.96);
      case WanToastType.error:
        return Theme.of(context).colorScheme.error.withOpacity(0.96);
    }
  }

  Color _foregroundColor(BuildContext context) {
    switch (type) {
      case WanToastType.tip:
        return Theme.of(context).colorScheme.onBackground.withOpacity(0.96);
      case WanToastType.success:
        return Theme.of(context).colorScheme.onSecondary.withOpacity(0.96);
      case WanToastType.error:
        return Theme.of(context).colorScheme.onError.withOpacity(0.96);
    }
  }

  Icon? _icon(BuildContext context) {
    switch (type) {
      case WanToastType.tip:
        return null;
      case WanToastType.success:
        return Icon(
          Icons.check_circle_rounded,
          color: Theme.of(context).colorScheme.onSecondary.withOpacity(0.96),
        );
      case WanToastType.error:
        return Icon(
          Icons.error_rounded,
          color: Theme.of(context).colorScheme.onError.withOpacity(0.96),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    Icon? icon = _icon(context);
    return Container(
      decoration: BoxDecoration(
        color: _backgroundColor(context),
        borderRadius:
            const BorderRadius.all(Radius.circular(AppDimens.radiusNormal)),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimens.marginNormal,
        vertical: AppDimens.marginNormal,
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: AppDimens.marginLarge,
        vertical: AppDimens.marginLarge,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            icon,
            const SizedBox(width: AppDimens.marginHalf),
          ],
          Text(
            msg,
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: _foregroundColor(context),
                ),
          ),
        ],
      ),
    );
  }
}
