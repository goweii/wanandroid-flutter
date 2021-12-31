import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginState {
  static late LoginState _loginState;

  static final StreamController<LoginState> _streamController =
      StreamController.broadcast(sync: false)
        ..stream.listen((event) {
          _loginState = event;
        });

  static LoginState value(BuildContext context) {
    return Provider.of<LoginState>(context, listen: false);
  }

  static LoginState listen(BuildContext context) {
    return Provider.of<LoginState>(context, listen: true);
  }

  static Stream<LoginState> stream() {
    return _streamController.stream;
  }

  LoginState({
    required this.isLogin,
  });

  final bool isLogin;

  notify() {
    if (_loginState.isLogin != isLogin) {
      _streamController.add(this);
    }
  }
}

class LoginStateProvider extends StreamProvider<LoginState> {
  LoginStateProvider({
    Key? key,
    required LoginState loginState,
  }) : super(
          key: key,
          initialData: loginState,
          create: (context) {
            return LoginState._streamController.stream;
          },
        ) {
    LoginState._loginState = loginState;
  }
}
