import 'package:flutter/material.dart';

class OpacityButton extends StatefulWidget {
  const OpacityButton({
    Key? key,
    required this.child,
    required this.onPressed,
    this.pressedOpacity = 0.4,
    this.animatedDuration = const Duration(milliseconds: 100),
  }) : super(key: key);

  final Widget child;
  final Duration animatedDuration;
  final double pressedOpacity;
  final VoidCallback onPressed;

  @override
  State<OpacityButton> createState() => _OpacityButtonState();
}

class _OpacityButtonState extends State<OpacityButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onHighlightChanged: (value) => setState(() => _pressed = value),
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: widget.onPressed,
      child: AnimatedOpacity(
        opacity: _pressed ? widget.pressedOpacity : 1.0,
        duration: widget.animatedDuration,
        child: widget.child,
      ),
    );
  }
}
