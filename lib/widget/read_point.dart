import 'package:flutter/material.dart';

class RedPoint extends StatelessWidget {
  const RedPoint({
    Key? key,
    required this.count,
  }) : super(key: key);

  final int count;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Container(
      constraints: BoxConstraints(
        minWidth: count <= 0 ? 10 : 12,
        maxWidth: count <= 0 ? 10 : double.infinity,
        minHeight: count <= 0 ? 10 : 12,
        maxHeight: count <= 0 ? 10 : 12,
      ),
      decoration: BoxDecoration(
        color: themeData.colorScheme.error,
        borderRadius: BorderRadius.circular(99),
      ),
      padding: count <= 0
          ? null
          : const EdgeInsets.symmetric(
              vertical: 1,
              horizontal: 3,
            ),
      child: count <= 0
          ? null
          : Text(
              count < 100 ? '$count' : '99+',
              style: themeData.textTheme.caption?.copyWith(
                color: themeData.colorScheme.onError,
                fontSize: 10,
                height: 1,
              ),
            ),
    );
  }
}
