import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:wanandroid/env/dimen/app_dimens.dart';
import 'package:wanandroid/env/l10n/generated/l10n.dart';
import 'package:wanandroid/env/mvvm/data_provider.dart';
import 'package:wanandroid/env/mvvm/view_model.dart';
import 'package:wanandroid/module/aboutme/about_me_view_model.dart';
import 'package:wanandroid/module/aboutme/about_me_widget.dart';

class AboutMePage extends StatefulWidget {
  const AboutMePage({Key? key}) : super(key: key);

  @override
  _AboutMePageState createState() => _AboutMePageState();
}

class _AboutMePageState extends State<AboutMePage> {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<AboutMeViewModel>(
      create: (context) => AboutMeViewModel()..getAboutMeInfo(),
      builder: (context, viewModel) {
        return DataProvider<AboutMeStatableData>(
          create: (context) => viewModel.statableData,
          builder: (context, statableData) {
            final ThemeData themeData = Theme.of(context);
            return Scaffold(
              body: Stack(
                fit: StackFit.expand,
                children: [
                  Positioned(
                    child: BlurredImage(url: statableData.value?.avatar ?? ''),
                  ),
                  Container(
                    color: themeData.colorScheme.onSurface.withOpacity(0.1),
                  ),
                  OrientationBuilder(
                    builder: (context, orientation) {
                      bool isPortrait = orientation == Orientation.portrait;
                      if (isPortrait) {
                        return Column(
                          children: [
                            AppBar(
                              title: Text(Strings.of(context).about_me),
                              toolbarHeight:
                                  themeData.appBarTheme.toolbarHeight,
                              backgroundColor: Colors.transparent,
                            ),
                            const SizedBox(height: AppDimens.marginNormal),
                            AboutMeInfo(aboutMeBean: statableData.value),
                            const SizedBox(height: AppDimens.marginNormal),
                            Expanded(
                              child: LayoutBuilder(
                                  builder: (context, constraints) {
                                double w = constraints.maxWidth;
                                double h = constraints.maxHeight;
                                double iw;
                                if (w / h > 3.0 / 4.0) {
                                  iw = h * (3.0 / 4.0);
                                } else {
                                  iw = w;
                                }
                                return Swiper.children(
                                  key: UniqueKey(),
                                  viewportFraction: (iw / w).clamp(0.0, 0.8),
                                  scale: 0.9,
                                  children: [
                                    QrCodeItem(
                                        url:
                                            statableData.value?.wxQrcode ?? ''),
                                    QrCodeItem(
                                        url: statableData.value?.zfbQrcode ??
                                            ''),
                                  ],
                                );
                              }),
                            ),
                            const SizedBox(height: AppDimens.marginNormal),
                          ],
                        );
                      } else {
                        return Row(
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  AppBar(
                                    title: Text(Strings.of(context).about_me),
                                    toolbarHeight:
                                        themeData.appBarTheme.toolbarHeight,
                                    backgroundColor: Colors.transparent,
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: AboutMeInfo(
                                          aboutMeBean: statableData.value),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: LayoutBuilder(
                                  builder: (context, constraints) {
                                double w = constraints.maxWidth;
                                double h = constraints.maxHeight;
                                double ih;
                                if (h / w > 4.0 / 3.0) {
                                  ih = w * (4.0 / 3.0);
                                } else {
                                  ih = h;
                                }
                                return Swiper.children(
                                  key: UniqueKey(),
                                  scrollDirection: Axis.vertical,
                                  viewportFraction: (ih / h).clamp(0.0, 0.8),
                                  scale: 0.9,
                                  children: [
                                    QrCodeItem(
                                        url:
                                            statableData.value?.wxQrcode ?? ''),
                                    QrCodeItem(
                                        url: statableData.value?.zfbQrcode ??
                                            ''),
                                  ],
                                );
                              }),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
