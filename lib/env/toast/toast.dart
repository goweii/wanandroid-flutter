import 'dart:async';
import 'package:flutter/material.dart';

typedef AnimatedWidgetBuilder = Widget Function(
  BuildContext context,
  Animation<double> animation,
);

class Toast {
  final BuildContext context;
  final AnimatedWidgetBuilder builder;
  final Duration animationDuration;

  Completer<bool>? _cancelable;

  Toast(
    this.context, {
    required this.builder,
    this.animationDuration = const Duration(milliseconds: 300),
  });

  Future<void> show([duration = const Duration(seconds: 2)]) async {
    await dismiss();

    _ToastQueue().prev?.dismiss();

    OverlayState? overlayState = Overlay.of(context);
    if (overlayState == null) return;

    final AnimationController controller = AnimationController(
      duration: animationDuration,
      vsync: overlayState,
    );

    Widget widget = builder(context, controller);

    final _ToastOverlay toastOverlay = _ToastOverlay(widget);

    overlayState.insert(toastOverlay);
    _ToastQueue().insert(this);

    await _wait(controller, duration);

    _ToastQueue().remove(this);
    toastOverlay.remove();
  }

  Future<void> _wait(AnimationController controller, Duration duration) async {
    try {
      _cancelable = Completer();
      controller.forward().then((_) {
        if (false == _cancelable?.isCompleted) {
          _cancelable!.complete(false);
        }
      });
      await _cancelable!.future;
      _cancelable = Completer();
      Future.delayed(duration).then((_) {
        if (false == _cancelable?.isCompleted) {
          _cancelable!.complete(false);
        }
      });
      await _cancelable!.future;
      await controller.reverse();
    } on bool catch (immediately) {
      if (!immediately) {
        await controller.reverse();
      }
    } catch (_) {
      await controller.reverse();
    } finally {
      _cancelable = null;
    }
  }

  Future<void> dismiss([bool immediately = true]) async {
    if (false == _cancelable?.isCompleted) {
      _cancelable?.completeError(immediately);
    }
  }
}

class _ToastOverlay extends OverlayEntry {
  _ToastOverlay(Widget widget) : super(builder: (context) => widget);
}

class _ToastQueue {
  static final _ToastQueue _instance = _ToastQueue._();
  factory _ToastQueue() => _instance;
  _ToastQueue._();

  final List<Toast> _queue = [];

  Toast? get prev {
    if (_queue.isEmpty) return null;
    return _queue[_queue.length - 1];
  }

  insert(Toast toast) {
    _queue.add(toast);
  }

  remove(Toast toast) {
    _queue.remove(toast);
  }
}
