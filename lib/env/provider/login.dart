import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserInfo extends Equatable {
  final String userName;
  final String tokenPass;

  const UserInfo({
    required this.userName,
    required this.tokenPass,
  });

  const UserInfo.guest()
      : userName = '',
        tokenPass = '';

  bool get isGuest => userName.isEmpty && tokenPass.isEmpty;

  @override
  List<Object?> get props => [
        userName,
        tokenPass,
      ];
}

class LoginState extends ChangeNotifier {
  static final LoginState _instance = LoginState._(
    userInfo: const UserInfo.guest(),
  );

  static final StreamController<LoginState> _streamController =
      StreamController<LoginState>.broadcast()..stream.listen((event) {});

  static LoginState value(BuildContext context) {
    return Provider.of<LoginState>(context, listen: false);
  }

  static LoginState listen(BuildContext context) {
    return Provider.of<LoginState>(context, listen: true);
  }

  static Stream<LoginState> stream() {
    return _streamController.stream;
  }

  factory LoginState() => _instance;

  LoginState._({
    required UserInfo userInfo,
  }) : _userInfo = userInfo;

  UserInfo _userInfo;

  bool get isLogin {
    return !_userInfo.isGuest;
  }

  update(UserInfo userInfo) {
    if (_userInfo != userInfo) {
      _userInfo = userInfo;
      notifyListeners();
      _streamController.sink.add(this);
    }
  }

  login(UserInfo userInfo) {
    if (!userInfo.isGuest) {
      update(userInfo);
    }
  }

  logout() {
    update(const UserInfo.guest());
  }
}

class LoginStateProvider extends ChangeNotifierProvider<LoginState> {
  LoginStateProvider({
    Key? key,
    required LoginState loginState,
  }) : super(
          key: key,
          create: (context) => loginState,
        );
}

class LoginStateConsumer extends Consumer<LoginState> {
  LoginStateConsumer({
    Key? key,
    required Widget Function(BuildContext context, LoginState loginState)
        builder,
  }) : super(
          key: key,
          builder: (context, value, child) {
            return builder(context, value);
          },
        );
}
