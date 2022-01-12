import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wanandroid/api/wan/wan_store.dart';
import 'package:wanandroid/env/l10n/locale_model.dart';
import 'package:wanandroid/env/l10n/locale_model_provider.dart';
import 'package:wanandroid/env/l10n/locale_model_store.dart';
import 'package:wanandroid/env/l10n/localization.dart';
import 'package:wanandroid/env/l10n/generated/l10n.dart';
import 'package:wanandroid/env/provider/login.dart';
import 'package:wanandroid/env/provider/unread.dart';
import 'package:wanandroid/env/route/route_delegate.dart';
import 'package:wanandroid/env/route/route_parser.dart';
import 'package:wanandroid/env/theme/theme_model.dart';
import 'package:wanandroid/env/theme/theme_model_store.dart';
import 'package:wanandroid/env/theme/theme_model_provider.dart';
import 'package:wanandroid/main_view_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  await WanStore().init();
  LoginState loginState = LoginState();
  loginState.update(await WanStore().userInfo);
  ThemeModel themeModel = await ThemeModelStore.load();
  LocaleModel localeModel = await LocaleModelStore.load();
  runApp(MultiProvider(
    providers: [
      ThemeModelProvider(themeModel: themeModel),
      LocaleModelProvider(localeModel: localeModel),
      LoginStateProvider(loginState: loginState),
      UnreadModelProvider(),
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
  final MainViewModel _viewModel = MainViewModel();
  final AppRouteDelegate _appRouteDelegate = AppRouteDelegate();
  final AppRouteParser _appRouteParser = AppRouteParser();

  @override
  void initState() {
    super.initState();
    LoginState.stream().listen((event) {
      _viewModel.updateUnreadMsgCount();
    });
    _viewModel.updateUnreadMsgCount();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (context) => Strings.of(context).wanandroid,
      theme: ThemeModel.listen(context).lightTheme,
      darkTheme: ThemeModel.listen(context).darkTheme,
      themeMode: ThemeModel.listen(context).themeMode,
      localizationsDelegates: Localization.localizationsDelegates,
      supportedLocales: Localization.supportedLocales,
      localeResolutionCallback: Localization.localeResolutionCallback,
      locale: LocaleModel.listen(context).locale,
      routerDelegate: _appRouteDelegate,
      routeInformationParser: _appRouteParser,
    );
  }
}
