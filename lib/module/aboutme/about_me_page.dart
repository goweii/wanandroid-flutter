import 'package:flutter/material.dart';
import 'package:wanandroid/env/dimen/app_dimens.dart';
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
      builder: (context, viewModel) => DataProvider<AboutMeStatableData>(
        create: (context) => viewModel.statableData,
        builder: (context, statableData) => Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                child: BlurredImage(url: statableData.value?.avatar ?? ''),
              ),
              Positioned(
                child: Container(
                  color: Theme.of(context).colorScheme.surface.withOpacity(0.8),
                ),
              ),
              OrientationBuilder(builder: (context, orientation) {
                if (orientation == Orientation.portrait) {
                  return Column(
                    children: [
                      const AboutMeAppBar(),
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
                            return QrCodePager(
                              scrollDirection: Axis.horizontal,
                              viewportFraction: iw / w,
                              aboutMeBean: statableData.value,
                            );
                          },
                        ),
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
                            const AboutMeAppBar(),
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
                        child: LayoutBuilder(builder: (context, constraints) {
                          double w = constraints.maxWidth;
                          double h = constraints.maxHeight;
                          double ih;
                          if (h / w > 4.0 / 3.0) {
                            ih = w * (4.0 / 3.0);
                          } else {
                            ih = h;
                          }
                          return QrCodePager(
                            scrollDirection: Axis.vertical,
                            viewportFraction: ih / h,
                            aboutMeBean: statableData.value,
                          );
                        }),
                      ),
                    ],
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
