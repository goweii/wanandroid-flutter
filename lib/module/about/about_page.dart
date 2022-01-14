import 'package:flutter/material.dart';
import 'package:wanandroid/env/dimen/app_dimens.dart';
import 'package:wanandroid/env/l10n/generated/l10n.dart';
import 'package:wanandroid/env/mvvm/data_provider.dart';
import 'package:wanandroid/env/mvvm/view_model.dart';
import 'package:wanandroid/module/about/about_view_model.dart';
import 'package:wanandroid/module/about/about_widget.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {                                                                                                                                                  
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<AboutViewModel>(
      create: (context) => AboutViewModel()..getAppInfo(),
      provide: (viewModel) => [
        DataProvider<AppInfoStatableData>(
            create: (context) => viewModel.appInfoStatableData),
        DataProvider<UpdateInfoStatableData>(
            create: (context) => viewModel.updateInfoStatableData),
      ],
      builder: (context, viewModel) {
        return Scaffold(
          appBar: AppBar(
            title: Text(Strings.of(context).about_title),
          ),
          body: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: OrientationBuilder(
              builder: (context, orientation) {
                if (orientation == Orientation.portrait) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      SizedBox(height: 50),
                      WanLogo(size: 80),
                      SizedBox(height: AppDimens.marginNormal),
                      AboutAppVersion(),
                      SizedBox(height: 50),
                      AboutActions(),
                    ],
                  );
                } else {
                  return Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            WanLogo(size: 80),
                            SizedBox(height: AppDimens.marginNormal),
                            AboutAppVersion(),
                          ],
                        ),
                      ),
                      const Expanded(
                        child: Center(
                          child: AboutActions(),
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }
}
