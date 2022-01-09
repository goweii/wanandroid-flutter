import 'package:wanandroid/api/wan/wan_apis.dart';

class SignUpRepo {
  Future<void> register({
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
