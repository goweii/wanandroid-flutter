import 'package:flutter/material.dart';
import 'package:wanandroid/env/dimen/app_dimens.dart';
import 'package:wanandroid/env/route/route_map.dart';
import 'package:wanandroid/widget/action_item.dart';

class MinePage extends StatefulWidget {
  const MinePage({Key? key}) : super(key: key);

  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: double.infinity,
            color: Theme.of(context).colorScheme.primary,
            child: Stack(
              children: [
                SafeArea(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: AppDimens.appBarHeight,
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          onPressed: null,
                          icon: Icon(
                            Icons.notifications,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      ),
                      ClipOval(
                        child: SizedBox(
                          width: 80,
                          height: 80,
                          child: Container(
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimary
                                .withAlpha(60),
                          ),
                        ),
                      ),
                      const SizedBox(height: AppDimens.marginNormal),
                      Text(
                        "goweii",
                        style: Theme.of(context).textTheme.headline6?.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                      ),
                      const SizedBox(height: AppDimens.marginHalf),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "dengji:123",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                          ),
                          const SizedBox(width: AppDimens.marginNormal),
                          Text(
                            "paiming:12",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppDimens.marginLarge),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ActionItem(
                    leading: const Icon(Icons.settings),
                    title: const Text("Settings"),
                    onPressed: () {
                      Navigator.of(context).pushNamed(RouteMap.settingsPage);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
