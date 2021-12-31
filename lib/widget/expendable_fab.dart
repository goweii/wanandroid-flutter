import 'package:flutter/material.dart';
import 'package:wanandroid/env/dimen/app_dimens.dart';

class Fab {
  Fab({
    required this.icon,
    required this.tip,
    required this.onPressed,
  });

  final Widget icon;
  final String tip;
  final VoidCallback onPressed;
}

typedef FabBuilder = Fab Function(BuildContext context, double f);

@immutable
class ExpendableFab extends StatefulWidget {
  const ExpendableFab({
    Key? key,
    this.mainFabBuilder,
    required this.actionFabs,
    this.duration = const Duration(milliseconds: 350),
    this.elevation = 8.0,
    this.padding = EdgeInsets.zero,
    this.idleOpacity = 0.8,
  }) : super(key: key);

  final FabBuilder? mainFabBuilder;
  final List<Fab> actionFabs;
  final Duration duration;
  final double elevation;
  final EdgeInsets padding;
  final double idleOpacity;

  @override
  _ExpendableFabState createState() => _ExpendableFabState();
}

class _ExpendableFabState extends State<ExpendableFab>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  final GlobalKey _mainKey = GlobalKey();
  final List<GlobalKey> _actionKeys = [];

  bool _open = false;

  int _downIndex = -1;
  int _touchIndex = -1;

  double get _f => _controller.value;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )
      ..addStatusListener(_onStatusListener)
      ..addListener(_onValueListener);
    _animation = CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.easeOutQuad,
      parent: _controller,
    );
  }

  @override
  void dispose() {
    _controller
      ..removeStatusListener(_onStatusListener)
      ..removeListener(_onValueListener)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: _handlePointerDown,
      onPointerMove: _handlePointerMove,
      onPointerUp: _handlePointerUp,
      onPointerCancel: _handlePointerCancel,
      child: AnimatedOpacity(
        duration: widget.duration,
        opacity: _downIndex >= 0 ? 1.0 : widget.idleOpacity,
        child: Container(
          constraints: const BoxConstraints.expand(),
          padding: widget.padding,
          child: Stack(
            alignment: Alignment.bottomLeft,
            clipBehavior: Clip.none,
            children: [
              ..._buildActionFabs(),
              _buildMainFab(),
            ],
          ),
        ),
      ),
    );
  }

  void _onValueListener() {
    setState(() {
      _f;
    });
  }

  void _onStatusListener(status) {}

  void toggle() {
    setState(() {
      _open = !_open;
      if (_open) {
        _controller.animateTo(1);
      } else {
        _controller.animateTo(0);
      }
    });
  }

  void open() {
    if (_open) return;
    setState(() {
      _open = true;
      _controller.animateTo(1);
    });
  }

  void close() {
    if (!_open) return;
    setState(() {
      _open = false;
      _controller.animateTo(0);
    });
  }

  void _handlePointerDown(PointerDownEvent event) {
    if (_isPointerInMainFab(event)) {
      setState(() {
        _downIndex = 0;
      });
      return;
    }
    for (var i = 0; i < _actionKeys.length; i++) {
      var key = _actionKeys[i];
      if (_pointerInWidget(event, key)) {
        setState(() {
          _downIndex = i;
        });
        return;
      }
    }
    if (_open) {
      close();
    }
  }

  void _handlePointerMove(PointerMoveEvent event) {
    if (_downIndex >= 0) {
      if (_isPointerInMainFab(event)) {
        if (_touchIndex != 0) {
          setState(() {
            _touchIndex = 0;
          });
        }
        return;
      }
      var index = _isPointerInActionFabs(event);
      if (index >= 0) {
        if (_touchIndex != index + 1) {
          setState(() {
            _touchIndex = index + 1;
          });
        }
        return;
      }
      if (_touchIndex != -1) {
        setState(() {
          _touchIndex = -1;
        });
      }
    } else {
      if (_open) {
        close();
      }
    }
  }

  void _handlePointerUp(PointerUpEvent event) {
    setState(() {
      _downIndex = -1;
    });
    if (_touchIndex != -1) {
      setState(() {
        _touchIndex = -1;
      });
    }
  }

  void _handlePointerCancel(PointerCancelEvent event) {
    setState(() {
      _downIndex = -1;
    });
    if (_touchIndex != -1) {
      setState(() {
        _touchIndex = -1;
      });
    }
  }

  List<Widget> _buildActionFabs() {
    final widgets = <Widget>[];
    final count = widget.actionFabs.length;
    if (_actionKeys.length < count) {
      for (var i = _actionKeys.length; i < count; i++) {
        _actionKeys.add(GlobalKey());
      }
    } else if (_actionKeys.length > count) {
      _actionKeys.removeRange(count, _actionKeys.length);
    }
    for (var i = count - 1; i >= 0; i--) {
      var fab = widget.actionFabs[i];
      widgets.add(
        _ExpandingActionButton(
          maxDistance:
              (AppDimens.iconButtonSize + AppDimens.marginNormal) * (i + 1),
          progress: _animation,
          child: ActionButton(
            key: _actionKeys[i],
            icon: fab.icon,
            onPressed: fab.onPressed,
            elevation: _f * widget.elevation,
            duration: _f == 1.0 ? widget.duration : Duration.zero,
          ),
          tip: fab.tip,
          showTip: _f == 1.0 && _touchIndex == i + 1,
        ),
      );
    }
    return widgets;
  }

  Widget _buildMainFab() {
    var fab = widget.mainFabBuilder?.call(context, _f);
    return AnimatedRotation(
      duration: widget.duration,
      curve: Curves.easeOut,
      turns: fab != null
          ? 0.0
          : _open
              ? 1.0
              : 0.0,
      child: ActionButton(
        key: _mainKey,
        onPressed: () {
          _open ? toggle() : fab?.onPressed();
        },
        onLongPressed: () => toggle(),
        elevation: widget.elevation,
        icon: fab?.icon ?? const Icon(Icons.arrow_back_ios_new_rounded),
      ),
    );
  }

  Rect? _widgetRect(GlobalKey key) {
    RenderBox? ro = key.currentContext?.findRenderObject() as RenderBox?;
    if (ro == null) return null;
    var offset = ro.localToGlobal(Offset.zero);
    var size = ro.size;
    return Rect.fromLTWH(offset.dx, offset.dy, size.width, size.height);
  }

  Offset? _pointerOffset(PointerEvent event) {
    var position = event.original?.position;
    if (position == null) return null;
    return position;
  }

  bool _pointerInWidget(PointerEvent event, GlobalKey key) {
    var offset = _pointerOffset(event);
    if (offset == null) return false;
    var rect = _widgetRect(key);
    if (rect == null) return false;
    return rect.contains(offset);
  }

  bool _isPointerInMainFab(PointerEvent event) {
    return _pointerInWidget(event, _mainKey);
  }

  int _isPointerInActionFabs(PointerEvent event) {
    for (var i = 0; i < _actionKeys.length; i++) {
      var key = _actionKeys[i];
      if (_pointerInWidget(event, key)) {
        return i;
      }
    }
    return -1;
  }
}

@immutable
class _ExpandingActionButton extends StatelessWidget {
  const _ExpandingActionButton({
    Key? key,
    required this.maxDistance,
    required this.progress,
    required this.child,
    required this.tip,
    this.showTip = false,
  }) : super(key: key);

  final double maxDistance;
  final Animation<double> progress;
  final Widget child;
  final String tip;
  final bool showTip;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: progress,
      builder: (context, child) {
        final offset = progress.value * maxDistance;
        return Positioned(
          bottom: offset,
          child: child!,
        );
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          child,
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: showTip ? AppDimens.marginNormal : 0,
          ),
          AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: showTip ? 1.0 : 0.0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                color: Theme.of(context).colorScheme.onSurface,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimens.marginNormal,
                vertical: AppDimens.marginHalf,
              ),
              child: Text(
                tip,
                style: Theme.of(context).textTheme.caption?.copyWith(
                      color: Theme.of(context).colorScheme.surface,
                    ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

@immutable
class ActionButton extends StatelessWidget {
  const ActionButton({
    Key? key,
    this.onPressed,
    this.onLongPressed,
    required this.icon,
    this.elevation = 8.0,
    this.duration = const Duration(milliseconds: 350),
  }) : super(key: key);

  final VoidCallback? onPressed;
  final VoidCallback? onLongPressed;
  final Widget icon;
  final double elevation;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () => onPressed?.call(),
      onLongPress: () => onLongPressed?.call(),
      child: Material(
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        color: theme.colorScheme.surface,
        animationDuration: duration,
        elevation: elevation,
        child: SizedBox(
          width: AppDimens.iconButtonSize,
          height: AppDimens.iconButtonSize,
          child: icon,
        ),
      ),
    );
  }
}
