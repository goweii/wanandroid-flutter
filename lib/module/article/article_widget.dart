import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:wanandroid/env/dimen/app_dimens.dart';
import 'package:wanandroid/widget/expendable_fab.dart';

class FabMenu extends StatelessWidget {
  const FabMenu({
    Key? key,
    required this.onBackPress,
    required this.progress,
    required this.actions,
  }) : super(key: key);

  final VoidCallback onBackPress;
  final double? progress;
  final List<Fab> actions;

  @override
  Widget build(BuildContext context) {
    return ExpendableFab(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimens.marginNormal,
        vertical: AppDimens.bottomBarHeight + AppDimens.marginNormal,
      ),
      mainFabBuilder: (context, f) {
        return Fab(
          icon: CircularPercentIndicator(
            radius: AppDimens.iconButtonSize,
            percent: progress ?? 0.0,
            lineWidth: 3.0,
            backgroundColor: Colors.transparent,
            circularStrokeCap: CircularStrokeCap.round,
            center: Transform.rotate(
              angle: f * math.pi * 0.5,
              child: const Icon(Icons.arrow_back_ios_new_rounded),
            ),
            progressColor: progress != null
                ? Theme.of(context).colorScheme.primary
                : Colors.transparent,
          ),
          tip: '',
          onPressed: () async {
            onBackPress();
            return true;
          },
        );
      },
      actionFabs: actions,
    );
  }
}
