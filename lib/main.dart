import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wanandroid/env/http/http.dart';
import 'package:wanandroid/env/l10n/localization.dart';
import 'package:wanandroid/env/l10n/generated/l10n.dart';
import 'package:wanandroid/env/theme/theme_model.dart';
import 'package:wanandroid/env/theme/theme_model_provider.dart';
import 'package:wanandroid/env/route/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  await Http().init();
  runApp(MultiProvider(
    providers: [
      ThemeModelProvider(),
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
