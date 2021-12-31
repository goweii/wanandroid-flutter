import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wanandroid/env/theme/theme_model.dart';

class ThemeModelProvider extends ChangeNotifierProvider<ThemeModel> {
  ThemeModelProvider({
    Key? key,
    required ThemeModel themeModel,
  }) : super(
          key: key,
          create: (context) => themeModel,
        );
}
