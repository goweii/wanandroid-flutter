import 'package:flutter/material.dart';
import 'package:wanandroid/api/wan/bean/user_coin_bean.dart';
import 'package:wanandroid/env/dimen/app_dimens.dart';
import 'package:wanandroid/env/route/route_map.dart';
import 'package:wanandroid/env/route/router.dart';

class CoinRankingItem extends StatelessWidget {
  const CoinRankingItem({
    Key? key,
    required this.coinInfoBean,
    required this.maxCoinCount,
  }) : super(key: key);

  final UserCoinBean coinInfoBean;
  final int maxCoinCount;

  int get index => int.tryParse(coinInfoBean.rank) ?? -1;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.surface,
      child: InkWell(
        onTap: () {
          AppRouter.of(context).pushNamed(
            RouteMap.userPage,
            arguments: coinInfoBean.userId,
          );
        },
        child: Stack(
          children: [
            Positioned.fill(
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor:
                    coinInfoBean.coinCount.toDouble() / maxCoinCount.toDouble(),
                child: Container(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppDimens.marginNormal),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    constraints: const BoxConstraints(
                      minWidth: 30,
                    ),
                    alignment: Alignment.center,
                    child: _CoinRankingIndex(index: index),
                  ),
                  const SizedBox(width: AppDimens.marginHalf),
                  Expanded(
                    child: Text(
                      coinInfoBean.nameToShow,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                  const SizedBox(width: AppDimens.marginHalf),
                  Text(
                    '${coinInfoBean.coinCount}',
                    style: Theme.of(context).textTheme.subtitle2?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CoinRankingIndex extends StatelessWidget {
  const _CoinRankingIndex({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    if (index == 1) {
      return Text(
        '🏅️',
        style: Theme.of(context).textTheme.subtitle1,
      );
    }
    if (index == 2) {
      return Text(
        '🥈',
        style: Theme.of(context).textTheme.subtitle1,
      );
    }
    if (index == 3) {
      return Text(
        '🥉',
        style: Theme.of(context).textTheme.subtitle1,
      );
    }
    return Text(
      '$index',
      style: Theme.of(context).textTheme.subtitle2?.copyWith(
            color: Theme.of(context).textTheme.caption?.color,
          ),
    );
  }
}
