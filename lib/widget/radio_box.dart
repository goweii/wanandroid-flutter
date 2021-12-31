import 'package:flutter/material.dart';

class RadioBox extends StatelessWidget {
  const RadioBox({
    Key? key,
    required this.value,
    this.size = 18.0,
    this.borderWidth = 1.5,
    this.gapWidth = 1.5,
    this.duration = const Duration(microseconds: 200),
  }) : super(key: key);

  final bool value;
  final double size;
  final double borderWidth;
  final double gapWidth;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedContainer(
            duration: duration,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(size * 0.5)),
              border: Border.all(
                color: value
                    ? themeData.colorScheme.primary
                    : themeData.colorScheme.primary,
                width: borderWidth,
              ),
            ),
          ),
          AnimatedContainer(
            width: value ? (size - (gapWidth + borderWidth) * 2) : 0,
            height: value ? (size - (gapWidth + borderWidth) * 2) : 0,
            duration: duration,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(size * 0.5)),
              color: value
                  ? themeData.colorScheme.primary
                  : themeData.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
