import 'package:wanandroid/api/wan_apis.dart';

class SignInRepo {
  Future<void> login({
    required String username,
    required String password,
  }) {
    return WanApis.login(
      username: username,
      password: password,
    );
  }
}