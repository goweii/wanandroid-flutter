import 'package:wanandroid/api/wan_apis.dart';

class SignInRepo {
  Future<void> login({
    required String username,
    required String password1,
    required String password2,
  }) {
    return WanApis.register(
      username: username,
      password: password1,
      repassword: password2,
    );
  }
}