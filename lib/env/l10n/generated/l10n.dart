// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class Strings {
  Strings();

  static Strings? _current;

  static Strings get current {
    assert(_current != null,
        'No instance of Strings was loaded. Try to initialize the Strings delegate before accessing Strings.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<Strings> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = Strings();
      Strings._current = instance;

      return instance;
    });
  }

  static Strings of(BuildContext context) {
    final instance = Strings.maybeOf(context);
    assert(instance != null,
        'No instance of Strings present in the widget tree. Did you add Strings.delegate in localizationsDelegates?');
    return instance!;
  }

  static Strings? maybeOf(BuildContext context) {
    return Localizations.of<Strings>(context, Strings);
  }

  /// `WanAndroid`
  String get wanandroid {
    return Intl.message(
      'WanAndroid',
      name: 'wanandroid',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home_title {
    return Intl.message(
      'Home',
      name: 'home_title',
      desc: '',
      args: [],
    );
  }

  /// `Mine`
  String get mine_title {
    return Intl.message(
      'Mine',
      name: 'mine_title',
      desc: '',
      args: [],
    );
  }

  /// `Navigation`
  String get navigation_title {
    return Intl.message(
      'Navigation',
      name: 'navigation_title',
      desc: '',
      args: [],
    );
  }

  /// `Publish`
  String get publish_title {
    return Intl.message(
      'Publish',
      name: 'publish_title',
      desc: '',
      args: [],
    );
  }

  /// `Question`
  String get question_title {
    return Intl.message(
      'Question',
      name: 'question_title',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings_title {
    return Intl.message(
      'Settings',
      name: 'settings_title',
      desc: '',
      args: [],
    );
  }

  /// `Bookmark`
  String get bookmark_title {
    return Intl.message(
      'Bookmark',
      name: 'bookmark_title',
      desc: '',
      args: [],
    );
  }

  /// `TOP`
  String get top_tag {
    return Intl.message(
      'TOP',
      name: 'top_tag',
      desc: '',
      args: [],
    );
  }

  /// `NEW`
  String get new_tag {
    return Intl.message(
      'NEW',
      name: 'new_tag',
      desc: '',
      args: [],
    );
  }

  /// `Unknown`
  String get unknown_username {
    return Intl.message(
      'Unknown',
      name: 'unknown_username',
      desc: '',
      args: [],
    );
  }

  /// `Slide up to load more`
  String get paged_list_footer_load_more {
    return Intl.message(
      'Slide up to load more',
      name: 'paged_list_footer_load_more',
      desc: '',
      args: [],
    );
  }

  /// `Loading data`
  String get paged_list_footer_loading {
    return Intl.message(
      'Loading data',
      name: 'paged_list_footer_loading',
      desc: '',
      args: [],
    );
  }

  /// `No more data`
  String get paged_list_footer_ended {
    return Intl.message(
      'No more data',
      name: 'paged_list_footer_ended',
      desc: '',
      args: [],
    );
  }

  /// `Pull to refresh`
  String get refresh_header_state_pull_to_refresh {
    return Intl.message(
      'Pull to refresh',
      name: 'refresh_header_state_pull_to_refresh',
      desc: '',
      args: [],
    );
  }

  /// `Release to refresh`
  String get refresh_header_state_release_to_refresh {
    return Intl.message(
      'Release to refresh',
      name: 'refresh_header_state_release_to_refresh',
      desc: '',
      args: [],
    );
  }

  /// `Refreshing`
  String get refresh_header_state_refreshing {
    return Intl.message(
      'Refreshing',
      name: 'refresh_header_state_refreshing',
      desc: '',
      args: [],
    );
  }

  /// `Refresh succeed`
  String get refresh_header_state_refresh_success {
    return Intl.message(
      'Refresh succeed',
      name: 'refresh_header_state_refresh_success',
      desc: '',
      args: [],
    );
  }

  /// `Refresh failed`
  String get refresh_header_state_refresh_failed {
    return Intl.message(
      'Refresh failed',
      name: 'refresh_header_state_refresh_failed',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to use`
  String get welcome_to_use {
    return Intl.message(
      'Welcome to use',
      name: 'welcome_to_use',
      desc: '',
      args: [],
    );
  }

  /// `Developed by Goweii`
  String get develop_by_goweii {
    return Intl.message(
      'Developed by Goweii',
      name: 'develop_by_goweii',
      desc: '',
      args: [],
    );
  }

  /// `Go lgoin`
  String get go_login {
    return Intl.message(
      'Go lgoin',
      name: 'go_login',
      desc: '',
      args: [],
    );
  }

  /// `Go register`
  String get go_register {
    return Intl.message(
      'Go register',
      name: 'go_register',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Input your account`
  String get input_account_hint {
    return Intl.message(
      'Input your account',
      name: 'input_account_hint',
      desc: '',
      args: [],
    );
  }

  /// `Input your password`
  String get input_password_hint {
    return Intl.message(
      'Input your password',
      name: 'input_password_hint',
      desc: '',
      args: [],
    );
  }

  /// `Input your password again`
  String get input_password_again_hint {
    return Intl.message(
      'Input your password again',
      name: 'input_password_again_hint',
      desc: '',
      args: [],
    );
  }

  /// `Unknown error`
  String get unknown_error {
    return Intl.message(
      'Unknown error',
      name: 'unknown_error',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<Strings> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<Strings> load(Locale locale) => Strings.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
