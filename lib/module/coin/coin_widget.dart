import 'package:flutter/material.dart';
import 'package:wanandroid/env/dimen/app_dimens.dart';
import 'package:wanandroid/env/mvvm/data_provider.dart';
import 'package:wanandroid/module/coin/coin_view_model.dart';

class CoinWidget extends StatelessWidget {
  const CoinWidget({
    Key? key,
    required this.height,
  }) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    return DataConsumer<UserCoinStatableData>(
      builder: (context, data) {
        return SizedBox(
          height: height,
          child: Center(
            child: Text(
              '${data.value?.coinCount ?? 0}',
              style: Theme.of(context).appBarTheme.titleTextStyle?.copyWith(
                    fontSize: 60,
                  ),
            ),
          ),
        );
      },
    );
  }
}

class CoinHistoryItem extends StatelessWidget {
  const CoinHistoryItem({
    Key? key,
    required this.coinHistoryVO,
  }) : super(key: key);

  final UserCoinHistoryVO coinHistoryVO;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Container(
      color: themeData.colorScheme.surface,
      padding: const EdgeInsets.all(AppDimens.marginNormal),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  coinHistoryVO.reasn,
                  style: themeData.textTheme.subtitle1,
                ),
                const SizedBox(height: AppDimens.marginHalf),
                Text(
                  coinHistoryVO.niceDate,
                  style: themeData.textTheme.subtitle2,
                ),
              ],
            ),
          ),
          Text(
            '+${coinHistoryVO.coinChange}',
            style: themeData.textTheme.subtitle1?.copyWith(
              color: themeData.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
