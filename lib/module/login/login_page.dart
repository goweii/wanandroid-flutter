import 'package:flutter/material.dart';
import 'package:wanandroid/env/asset/app_images.dart';
import 'package:wanandroid/env/dimen/app_dimens.dart';
import 'package:wanandroid/env/l10n/generated/l10n.dart';
import 'package:wanandroid/env/route/router.dart';
import 'package:wanandroid/module/login/sign_in_widget.dart';
import 'package:wanandroid/module/login/sign_up_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  PageController? _pageController;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController?.dispose();
    _pageController = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            AppRouter.of(context).pop();
          },
          icon: Icon(
            Icons.close_rounded,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        MediaQueryData mediaQueryData = MediaQuery.of(context);
        double screenHeight = mediaQueryData.size.height;
        double bottom = mediaQueryData.viewInsets.bottom;
        double needHeight = mediaQueryData.padding.top + 0;
        return OrientationBuilder(builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            return SafeArea(
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    AnimatedAlign(
                      duration: const Duration(milliseconds: 300),
                      alignment: Alignment.topCenter,
                      heightFactor: screenHeight - bottom > 600 ? 1.0 : 0.0,
                      child: Column(
                        children: [
                          Image.asset(
                            AppImages.logo,
                            color: Theme.of(context).colorScheme.surface,
                            width: 100,
                            height: 100,
                          ),
                          Text(
                            Strings.of(context).welcome_to_use,
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                          ),
                          const SizedBox(height: AppDimens.marginHalf),
                          Text(
                            Strings.of(context).develop_by_goweii,
                            style:
                                Theme.of(context).textTheme.bodyText2?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary
                                          .withAlpha(180),
                                    ),
                          ),
                          const SizedBox(height: AppDimens.marginNormal),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: OverflowBox(
                              maxWidth: constraints.maxWidth * 5,
                              maxHeight: constraints.maxWidth * 5,
                              alignment: Alignment.topCenter,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.surface,
                                  borderRadius: BorderRadius.circular(
                                    constraints.maxWidth * 3,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned.fill(
                            child: PageView(
                              controller: _pageController,
                              children: [
                                Container(
                                  alignment: Alignment.topCenter,
                                  padding: const EdgeInsets.only(
                                    top: AppDimens.marginVeryLarge,
                                  ),
                                  child: SignInWidget(
                                    onSignUpPressed: () => _animateToPage(1),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.topCenter,
                                  padding: const EdgeInsets.only(
                                    top: AppDimens.marginVeryLarge,
                                  ),
                                  child: SignUpWidget(
                                    onSignInPressed: () => _animateToPage(0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Image.asset(
                          AppImages.logo,
                          color: Theme.of(context).colorScheme.surface,
                          width: 100,
                          height: 100,
                        ),
                        Text(
                          Strings.of(context).welcome_to_use,
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                        ),
                        const SizedBox(height: AppDimens.marginHalf),
                        Text(
                          Strings.of(context).develop_by_goweii,
                          style:
                              Theme.of(context).textTheme.bodyText2?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimary
                                        .withAlpha(180),
                                  ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: OverflowBox(
                                  maxWidth: constraints.maxHeight * 5,
                                  maxHeight: constraints.maxHeight * 5,
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color:
                                          Theme.of(context).colorScheme.surface,
                                      borderRadius: BorderRadius.circular(
                                        constraints.maxHeight * 3,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned.fill(
                                child: PageView(
                                  scrollDirection: Axis.vertical,
                                  controller: _pageController,
                                  children: [
                                    Center(
                                      child: SignInWidget(
                                        onSignUpPressed: () =>
                                            _animateToPage(1),
                                      ),
                                    ),
                                    Center(
                                      child: SignUpWidget(
                                        onSignInPressed: () =>
                                            _animateToPage(0),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        });
      }),
    );
  }

  _animateToPage(int page) {
    _pageController?.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.fastOutSlowIn,
    );
  }
}
