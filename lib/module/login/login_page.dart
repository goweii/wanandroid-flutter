import 'package:flutter/material.dart';
import 'package:wanandroid/env/asset/app_images.dart';
import 'package:wanandroid/env/dimen/app_dimens.dart';
import 'package:wanandroid/env/l10n/generated/l10n.dart';
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
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.close_rounded,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
              style: Theme.of(context).textTheme.headline6?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
            ),
            const SizedBox(height: AppDimens.marginHalf),
            Text(
              Strings.of(context).develop_by_goweii,
              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    color:
                        Theme.of(context).colorScheme.onPrimary.withAlpha(180),
                  ),
            ),
            const SizedBox(height: AppDimens.marginNormal),
            Expanded(
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: OverflowBox(
                      maxWidth: 900,
                      maxHeight: 900,
                      alignment: Alignment.topCenter,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(900),
                        ),
                      ),
                    ),
                  ),
                  PageView(
                    controller: _pageController,
                    children: [
                      SignInWidget(
                        account: "12",
                        password: "23123",
                        onSignUpPressed: () => _animateToPage(1),
                      ),
                      SignUpWidget(
                        onSignInPressed: () => _animateToPage(0),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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
