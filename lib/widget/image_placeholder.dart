import 'package:flutter/material.dart';
import 'package:wanandroid/env/asset/app_images.dart';

class ImagePlaceholder extends StatelessWidget {
  const ImagePlaceholder({
    Key? key,
    this.backgroundColor,
    this.foregroundColor,
  }) : super(key: key);

  final Color? backgroundColor;
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Container(
      color: backgroundColor ?? themeData.hoverColor,
      child: Center(
        child: FractionallySizedBox(
          widthFactor: 0.618,
          heightFactor: 0.618,
          child: Image.asset(
            AppImages.logo,
            fit: BoxFit.contain,
            color: foregroundColor ??
                themeData.colorScheme.onSurface.withOpacity(0.1),
          ),
        ),
      ),
    );
  }
}
