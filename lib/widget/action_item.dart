import 'package:flutter/material.dart';
import 'package:wanandroid/env/dimen/app_dimens.dart';

class ActionItem extends StatefulWidget {
  const ActionItem({
    Key? key,
    this.backgroundColor,
    this.leading,
    required this.title,
    this.desc,
    this.tip,
    this.tipColor,
    this.treading,
    this.onPressed,
    this.children,
    this.expanded,
  }) : super(key: key);

  final Color? backgroundColor;
  final Widget? leading;
  final Widget title;
  final Widget? desc;
  final Widget? tip;
  final Color? tipColor;
  final Widget? treading;
  final VoidCallback? onPressed;
  final List<Widget>? children;
  final bool? expanded;

  @override
  State<ActionItem> createState() => _ActionItemState();
}

class _ActionItemState extends State<ActionItem> {
  bool _expanded = false;

  bool get expandable => widget.children?.isNotEmpty == true;

  @override
  void initState() {
    _expanded = widget.expanded ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Material(
          color:
              widget.backgroundColor ?? Theme.of(context).colorScheme.surface,
          child: InkWell(
            onTap: !expandable
                ? widget.onPressed
                : () => setState(() => _expanded = !_expanded),
            child: Container(
              padding: const EdgeInsets.all(AppDimens.marginNormal),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.leading != null) ...[
                    IconTheme(
                      child: widget.leading!,
                      data: Theme.of(context).iconTheme.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                    const SizedBox(width: AppDimens.marginHalf),
                  ],
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DefaultTextStyle(
                          style:
                              Theme.of(context).textTheme.subtitle1!.copyWith(
                                    height: 1.0,
                                  ),
                          child: widget.title,
                        ),
                        if (widget.desc != null) ...[
                          const SizedBox(height: AppDimens.marginSmall),
                          DefaultTextStyle(
                            style: Theme.of(context).textTheme.subtitle2!,
                            child: widget.desc!,
                          ),
                        ],
                      ],
                    ),
                  ),
                  if (widget.tip != null) ...[
                    const SizedBox(width: AppDimens.marginSmall),
                    DefaultTextStyle(
                      style: Theme.of(context).textTheme.caption!.copyWith(
                            color: widget.tipColor ??
                                Theme.of(context).textTheme.caption!.color,
                          ),
                      child: widget.tip!,
                    ),
                  ],
                  if (!expandable && widget.treading != null)
                    IconTheme(
                      child: widget.treading!,
                      data: Theme.of(context).iconTheme.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                  if (expandable ||
                      (!expandable &&
                          widget.treading == null &&
                          widget.onPressed != null)) ...[
                    const SizedBox(width: AppDimens.marginSmall),
                    AnimatedRotation(
                      duration: const Duration(milliseconds: 200),
                      turns: _expanded ? 0.75 : 0.5,
                      child: Icon(
                        Icons.arrow_back_ios_rounded,
                        size: 18,
                        color: Theme.of(context).textTheme.caption?.color,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
        if (expandable)
          ClipRect(
            child: AnimatedAlign(
              duration: const Duration(milliseconds: 300),
              heightFactor: _expanded ? 1 : 0,
              alignment: Alignment.topCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: widget.children!,
              ),
            ),
          ),
      ],
    );
  }
}
