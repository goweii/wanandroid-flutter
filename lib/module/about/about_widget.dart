import 'package:flutter/material.dart';
import 'package:wanandroid/api/wan/wan_const.dart';
import 'package:wanandroid/entity/article_info.dart';
import 'package:wanandroid/env/asset/app_images.dart';
import 'package:wanandroid/env/l10n/generated/l10n.dart';
import 'package:wanandroid/env/mvvm/data_provider.dart';
import 'package:wanandroid/env/route/route_map.dart';
import 'package:wanandroid/env/route/router.dart';
import 'package:wanandroid/module/about/about_view_model.dart';
import 'package:wanandroid/module/common/update/update_dialog.dart';
import 'package:wanandroid/widget/action_item.dart';

class WanLogo extends StatelessWidget {
  const WanLogo({
    Key? key,
    required this.size,
  }) : super(key: key);

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: EdgeInsets.all(size * 0.1),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(size * 0.2),
      ),
      child: Image.asset(
        AppImages.logo,
        color: Colors.white,
      ),
    );
  }
}

class AboutAppVersion extends StatelessWidget {
  const AboutAppVersion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DataConsumer<AppInfoStatableData>(
      builder: (context, data) {
        return Text(
          Strings.of(context).version_perfix +
              (data.value?.versionName ?? '0.0.0'),
          style: Theme.of(context).textTheme.subtitle2,
        );
      },
    );
  }
}

class AboutActions extends StatelessWidget {
  const AboutActions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ActionItem(
            title: Text(Strings.of(context).official_website),
            onPressed: () => AppRouter.of(context).pushNamed(
              RouteMap.articlePage,
              arguments: ArticleInfo.fromUrl(WanConst.website),
            ),
          ),
          DataConsumer<UpdateInfoStatableData>(
            builder: (context, data) {
              return ActionItem(
                title: Text(Strings.of(context).version_update),
                tip: Text(
                  data.value == null
                      ? Strings.of(context).already_the_latest_version
                      : Strings.of(context).new_version_found,
                ),
                onPressed: () {
                  if (data.value == null) {
                    return;
                  }
                  UpdateDialog.show(
                    context: context,
                    updateInfo: data.value!,
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
