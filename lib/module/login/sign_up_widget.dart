import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid/env/dimen/app_dimens.dart';
import 'package:wanandroid/env/http/api.dart';
import 'package:wanandroid/env/l10n/generated/l10n.dart';
import 'package:wanandroid/env/route/router.dart';
import 'package:wanandroid/module/login/sign_in_repo.dart';
import 'package:wanandroid/module/login/sign_up_repo.dart';
import 'package:wanandroid/widget/input_edit.dart';
import 'package:wanandroid/widget/main_button.dart';

class SignUpWidget extends StatefulWidget {
  final VoidCallback? onSignInPressed;

  const SignUpWidget({
    Key? key,
    this.onSignInPressed,
  }) : super(key: key);

  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final SignUpRepo _signUpRepp = SignUpRepo();
  final SignInRepo _signInRepo = SignInRepo();

  String? _account;
  String? _password1;
  String? _password2;

  bool get btnEnable =>
      _account != null &&
      _account!.isNotEmpty &&
      _password1 != null &&
      _password1!.isNotEmpty &&
      _password2 != null &&
      _password2!.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: AppDimens.appBarHeight),
        GestureDetector(
          onTap: widget.onSignInPressed,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                CupertinoIcons.arrow_left_circle,
                size: 18,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: AppDimens.marginHalf),
              Text(
                Strings.of(context).go_login,
                style: Theme.of(context).textTheme.button?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
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
            hintText: Strings.of(context).input_account_hint,
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
            hintText: Strings.of(context).input_password_hint,
            onChanged: (value) => setState(() => _password1 = value),
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
            hintText: Strings.of(context).input_password_again_hint,
            onChanged: (value) => setState(() => _password2 = value),
          ),
        ),
        const SizedBox(height: AppDimens.marginLarge),
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: AppDimens.marginNormal * 3,
          ),
          child: MainButton(
            child: Text(Strings.of(context).register),
            disable: !btnEnable,
            onPressed: _register,
          ),
        ),
      ],
    );
  }

  Future<dynamic> _register() async {
    try {
      await _signUpRepp.register(
        username: _account!,
        password1: _password1!,
        password2: _password2!,
      );
      return await _login();
    } on ApiException catch (e) {
      return e.msg ?? Strings.of(context).unknown_error;
    } catch (e) {
      return Strings.of(context).unknown_error;
    }
  }

  Future<dynamic> _login() async {
    try {
      await _signInRepo.login(
        username: _account!,
        password: _password1!,
      );
      AppRouter.of(context).pop();
    } on ApiException catch (e) {
      return e.msg ?? Strings.of(context).unknown_error;
    } catch (e) {
      return Strings.of(context).unknown_error;
    }
  }
}
