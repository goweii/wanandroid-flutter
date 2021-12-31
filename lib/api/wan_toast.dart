import 'package:flutter/material.dart';
import 'package:wanandroid/env/dimen/app_dimens.dart';
import 'package:wanandroid/env/toast/toast.dart';

enum WanToastType {
  tip,
  success,
  error,
}

class WanToast extends Toast {
  late final AnimationController _controller;
  late final Animation<double> _animation;
  WanToast(
    BuildContext context, {
    required String msg,
    WanToastType type = WanToastType.tip,
  }) : super(
          context,
          widget: _WanToastView(
            msg: msg,
            type: type,
          ),
        );

  @override
  Future<Widget> onCreate(OverlayState overlayState) async {
    Widget child = await super.onCreate(overlayState);
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: Overlay.of(context)!,
    );
    _animation = CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.easeOutQuad,
      parent: _controller,
    );
    _controller.forward();
    return _AnimatedWanToastView(
      child: child,
      animation: _animation,
    );
  }

  @override
  Future<void> onDispose(OverlayState overlayState) async {
    await super.onDispose(overlayState);
    await _controller.reverse();
    _controller.dispose();
  }
}

class _AnimatedWanToastView extends StatefulWidget {
  final Animation<double> animation;
  final Widget child;

  const _AnimatedWanToastView({
    Key? key,
    required this.animation,
    required this.child,
  }) : super(key: key);

  @override
  State<_AnimatedWanToastView> createState() => _AnimatedWanToastViewState();
}

class _AnimatedWanToastViewState extends State<_AnimatedWanToastView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: widget.animation,
        builder: (context, child) {
          return Opacity(
            opacity: widget.animation.value,
            child: Transform.scale(
              scale: 0.8 + (0.2 * widget.animation.value),
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

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface.withOpacity(0.9),
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
          if (type == WanToastType.success) ...[
            Icon(
              Icons.check_circle_rounded,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: AppDimens.marginHalf),
          ],
          if (type == WanToastType.error) ...[
            Icon(
              Icons.error_rounded,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(width: AppDimens.marginHalf),
          ],
          Text(
            msg,
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
        ],
      ),
    );
  }
}
