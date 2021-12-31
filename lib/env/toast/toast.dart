import 'dart:async';

import 'package:flutter/material.dart';

class _ToastQueue {
  static final _ToastQueue _instance = _ToastQueue._();
  factory _ToastQueue() => _instance;
  _ToastQueue._();

  final List<Toast> _queue = [];

  Toast? get last {
    if (_queue.isEmpty) return null;
    return _queue[_queue.length - 1];
  }

  _add(Toast toast) {
    _queue.add(toast);
  }

  _remove(Toast toast) {
    _queue.remove(toast);
  }
}

class Toast {
  final BuildContext context;
  final Widget widget;

  Toast(
    this.context, {
    required this.widget,
  });

  Future<void> show({
    Duration duration = const Duration(seconds: 2),
  }) async {
    OverlayState? overlayState = Overlay.of(context);
    if (overlayState == null) return;
    Widget child = await onCreate(overlayState);
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (BuildContext context) {
        return ToastOverlay(child: child);
      },
    );
    overlayState.insert(overlayEntry);
    _ToastQueue()._add(this);
    await Future.delayed(duration);
    await onDispose(overlayState);
    _ToastQueue()._remove(this);
    overlayEntry.remove();
  }

  Future<Widget> onCreate(OverlayState overlayState) async {
    return widget;
  }

  Future<void> onDispose(OverlayState overlayState) async {}
}

class ToastOverlay extends StatelessWidget {
  final Widget child;

  const ToastOverlay({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: true,
      child: Material(
        textStyle: Theme.of(context).textTheme.bodyText1,
        color: Colors.white.withOpacity(0),
        child: child,
      ),
    );
  }
}
