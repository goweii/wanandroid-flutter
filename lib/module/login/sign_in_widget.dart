import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid/env/dimen/app_dimens.dart';
import 'package:wanandroid/env/l10n/generated/l10n.dart';
import 'package:wanandroid/module/login/sign_in_repo.dart';
import 'package:wanandroid/widget/input_edit.dart';
import 'package:wanandroid/widget/main_button.dart';

class SignInWidget extends StatefulWidget {
  final PageController? pageController;

  const SignInWidget({
    Key? key,
    this.pageController,
  }) : super(key: key);

  @override
  _SignInWidgetState createState() => _SignInWidgetState();
}

class _SignInWidgetState extends State<SignInWidget> {
  final SignInRepo _repo = SignInRepo();

  String? _account;
  String? _password;

  bool get btnEnable =>
      _account != null &&
      _account!.isNotEmpty &&
      _password != null &&
      _password!.isNotEmpty;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: AppDimens.appBarHeight),
        GestureDetector(
          onTap: () {
            widget.pageController?.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.fastOutSlowIn,
            );
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                Strings.of(context).go_register,
                style: Theme.of(context).textTheme.button?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              const SizedBox(width: AppDimens.marginHalf),
              Icon(
                CupertinoIcons.arrow_right_circle,
                size: 18,
                color: Theme.of(context).colorScheme.primary,
              ),
            ],
          ),
        ),
        const SizedBox(height: AppDimens.marginNormal),
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: AppDimens.marginNormal * 3,
          ),
          child: InputEdit(
            securty: false,
            prefix: const Icon(
              CupertinoIcons.person_solid,
              size: 20,
            ),
            onChanged: (value) => setState(() => _account = value),
          ),
        ),
        const SizedBox(height: AppDimens.marginSmall),
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: AppDimens.marginNormal * 3,
          ),
          child: InputEdit(
            securty: true,
            prefix: const Icon(
              CupertinoIcons.lock_fill,
              size: 20,
            ),
            onChanged: (value) => setState(() => _password = value),
          ),
        ),
        const SizedBox(height: AppDimens.marginNormal),
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: AppDimens.marginNormal * 3,
          ),
          child: MainButton(
            child: Text(Strings.of(context).login),
            onPressed: btnEnable ? _login : null,
          ),
        ),
      ],
    );
  }

  _login() {
    _repo.login(username: _account!, password: _password!).then((value) {
      setState(() {});
    }, onError: (e) {
      setState(() {});
    });
  }
}
