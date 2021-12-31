import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wanandroid/api/wan_store.dart';
import 'package:wanandroid/env/l10n/localization.dart';
import 'package:wanandroid/env/l10n/generated/l10n.dart';
import 'package:wanandroid/env/provider/login.dart';
import 'package:wanandroid/env/theme/theme_model.dart';
import 'package:wanandroid/env/theme/theme_model_manager.dart';
import 'package:wanandroid/env/theme/theme_model_provider.dart';
import 'package:wanandroid/env/route/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  await WanStore().init();
  LoginState loginState = LoginState(isLogin: await WanStore().isLogin);
  ThemeModel themeModel = await ThemeModelStore.load();
  runApp(MultiProvider(
    providers: [
      ThemeModelProvider(
        themeModel: themeModel,
      ),
      LoginStateProvider(
        loginState: loginState,
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (context) => Strings.of(context).wanandroid,
      theme: ThemeModel.listen(context).lightTheme,
      darkTheme: ThemeModel.listen(context).darkTheme,
      themeMode: ThemeModel.listen(context).themeMode,
      localizationsDelegates: Localization.localizationsDelegates,
      supportedLocales: Localization.supportedLocales,
      localeResolutionCallback: Localization.localeResolutionCallback,
      onGenerateRoute: AppRouter.generateRoute,
      onUnknownRoute: AppRouter.unknownRoute,
      initialRoute: AppRouter.initialRoute,
    );
  }
}
