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

  /// `Knowledge`
  String get knowledge_title {
    return Intl.message(
      'Knowledge',
      name: 'knowledge_title',
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

  /// `Tap to load more`
  String get paged_list_footer_load_more {
    return Intl.message(
      'Tap to load more',
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

  /// `Welcome to Use`
  String get welcome_to_use {
    return Intl.message(
      'Welcome to Use',
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

  /// `Go Lgoin`
  String get go_login {
    return Intl.message(
      'Go Lgoin',
      name: 'go_login',
      desc: '',
      args: [],
    );
  }

  /// `Go Register`
  String get go_register {
    return Intl.message(
      'Go Register',
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

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
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

  /// `Theme mode`
  String get choice_theme_mode {
    return Intl.message(
      'Theme mode',
      name: 'choice_theme_mode',
      desc: '',
      args: [],
    );
  }

  /// `Follow system`
  String get theme_mode_system {
    return Intl.message(
      'Follow system',
      name: 'theme_mode_system',
      desc: '',
      args: [],
    );
  }

  /// `Dark`
  String get theme_mode_dark {
    return Intl.message(
      'Dark',
      name: 'theme_mode_dark',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get theme_mode_light {
    return Intl.message(
      'Light',
      name: 'theme_mode_light',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get choice_language {
    return Intl.message(
      'Language',
      name: 'choice_language',
      desc: '',
      args: [],
    );
  }

  /// `Follow system`
  String get language_system {
    return Intl.message(
      'Follow system',
      name: 'language_system',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get article_fab_tip_close {
    return Intl.message(
      'Close',
      name: 'article_fab_tip_close',
      desc: '',
      args: [],
    );
  }

  /// `Collect`
  String get article_fab_tip_collect {
    return Intl.message(
      'Collect',
      name: 'article_fab_tip_collect',
      desc: '',
      args: [],
    );
  }

  /// `Publish`
  String get article_fab_tip_publish {
    return Intl.message(
      'Publish',
      name: 'article_fab_tip_publish',
      desc: '',
      args: [],
    );
  }

  /// `Share`
  String get article_fab_tip_share {
    return Intl.message(
      'Share',
      name: 'article_fab_tip_share',
      desc: '',
      args: [],
    );
  }

  /// `Guest`
  String get guest_name {
    return Intl.message(
      'Guest',
      name: 'guest_name',
      desc: '',
      args: [],
    );
  }

  /// `Level:`
  String get level_prefix {
    return Intl.message(
      'Level:',
      name: 'level_prefix',
      desc: '',
      args: [],
    );
  }

  /// `Ranking:`
  String get ranking_prefix {
    return Intl.message(
      'Ranking:',
      name: 'ranking_prefix',
      desc: '',
      args: [],
    );
  }

  /// `Collection`
  String get mine_collection {
    return Intl.message(
      'Collection',
      name: 'mine_collection',
      desc: '',
      args: [],
    );
  }

  /// `Answers`
  String get answers {
    return Intl.message(
      'Answers',
      name: 'answers',
      desc: '',
      args: [],
    );
  }

  /// `Coin`
  String get coin_title {
    return Intl.message(
      'Coin',
      name: 'coin_title',
      desc: '',
      args: [],
    );
  }

  /// `Collected Article`
  String get collected_article {
    return Intl.message(
      'Collected Article',
      name: 'collected_article',
      desc: '',
      args: [],
    );
  }

  /// `Collected Link`
  String get collected_link {
    return Intl.message(
      'Collected Link',
      name: 'collected_link',
      desc: '',
      args: [],
    );
  }

  /// `Shared`
  String get mine_share {
    return Intl.message(
      'Shared',
      name: 'mine_share',
      desc: '',
      args: [],
    );
  }

  /// `About me`
  String get about_me {
    return Intl.message(
      'About me',
      name: 'about_me',
      desc: '',
      args: [],
    );
  }

  /// `About Me`
  String get about_me_title {
    return Intl.message(
      'About Me',
      name: 'about_me_title',
      desc: '',
      args: [],
    );
  }

  /// `Message`
  String get message_title {
    return Intl.message(
      'Message',
      name: 'message_title',
      desc: '',
      args: [],
    );
  }

  /// `Coin Ranking`
  String get coin_ranking_title {
    return Intl.message(
      'Coin Ranking',
      name: 'coin_ranking_title',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Confirm deletion`
  String get confirm_deletion {
    return Intl.message(
      'Confirm deletion',
      name: 'confirm_deletion',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Not supported`
  String get not_support {
    return Intl.message(
      'Not supported',
      name: 'not_support',
      desc: '',
      args: [],
    );
  }

  /// `Buy him a cup of coffee`
  String get buy_him_a_cup_of_coffee {
    return Intl.message(
      'Buy him a cup of coffee',
      name: 'buy_him_a_cup_of_coffee',
      desc: '',
      args: [],
    );
  }

  /// `Share Article`
  String get share_article {
    return Intl.message(
      'Share Article',
      name: 'share_article',
      desc: '',
      args: [],
    );
  }

  /// `Article title`
  String get share_article_title_label {
    return Intl.message(
      'Article title',
      name: 'share_article_title_label',
      desc: '',
      args: [],
    );
  }

  /// `Article link`
  String get share_article_link_label {
    return Intl.message(
      'Article link',
      name: 'share_article_link_label',
      desc: '',
      args: [],
    );
  }

  /// `Input article title`
  String get share_article_title_hint {
    return Intl.message(
      'Input article title',
      name: 'share_article_title_hint',
      desc: '',
      args: [],
    );
  }

  /// `Input article link`
  String get share_article_link_hint {
    return Intl.message(
      'Input article link',
      name: 'share_article_link_hint',
      desc: '',
      args: [],
    );
  }

  /// `Share article successfully`
  String get share_article_successfully {
    return Intl.message(
      'Share article successfully',
      name: 'share_article_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Camera Permission`
  String get sacn_page_camera_permission_title {
    return Intl.message(
      'Camera Permission',
      name: 'sacn_page_camera_permission_title',
      desc: '',
      args: [],
    );
  }

  /// `Camera permission must be granted to start scanning`
  String get sacn_page_camera_permission_request {
    return Intl.message(
      'Camera permission must be granted to start scanning',
      name: 'sacn_page_camera_permission_request',
      desc: '',
      args: [],
    );
  }

  /// `Please go to settings and turn on camera permission`
  String get sacn_page_camera_permission_go_settings {
    return Intl.message(
      'Please go to settings and turn on camera permission',
      name: 'sacn_page_camera_permission_go_settings',
      desc: '',
      args: [],
    );
  }

  /// `Hot search`
  String get search_hot_title {
    return Intl.message(
      'Hot search',
      name: 'search_hot_title',
      desc: '',
      args: [],
    );
  }

  /// `History search`
  String get search_history_title {
    return Intl.message(
      'History search',
      name: 'search_history_title',
      desc: '',
      args: [],
    );
  }

  /// `New Version`
  String get update_title {
    return Intl.message(
      'New Version',
      name: 'update_title',
      desc: '',
      args: [],
    );
  }

  /// `Version:`
  String get version_perfix {
    return Intl.message(
      'Version:',
      name: 'version_perfix',
      desc: '',
      args: [],
    );
  }

  /// `Date:`
  String get date_perfix {
    return Intl.message(
      'Date:',
      name: 'date_perfix',
      desc: '',
      args: [],
    );
  }

  /// `Update Now`
  String get update_now {
    return Intl.message(
      'Update Now',
      name: 'update_now',
      desc: '',
      args: [],
    );
  }

  /// `Update Later`
  String get update_later {
    return Intl.message(
      'Update Later',
      name: 'update_later',
      desc: '',
      args: [],
    );
  }

  /// `Downloading`
  String get downloading {
    return Intl.message(
      'Downloading',
      name: 'downloading',
      desc: '',
      args: [],
    );
  }

  /// `Install Now`
  String get install_now {
    return Intl.message(
      'Install Now',
      name: 'install_now',
      desc: '',
      args: [],
    );
  }

  /// `Installing`
  String get installing {
    return Intl.message(
      'Installing',
      name: 'installing',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get retry {
    return Intl.message(
      'Retry',
      name: 'retry',
      desc: '',
      args: [],
    );
  }

  /// `Permission not granted`
  String get permission_not_granted {
    return Intl.message(
      'Permission not granted',
      name: 'permission_not_granted',
      desc: '',
      args: [],
    );
  }

  /// `Update error`
  String get update_error {
    return Intl.message(
      'Update error',
      name: 'update_error',
      desc: '',
      args: [],
    );
  }

  /// `Install error`
  String get install_error {
    return Intl.message(
      'Install error',
      name: 'install_error',
      desc: '',
      args: [],
    );
  }

  /// `Download error`
  String get download_error {
    return Intl.message(
      'Download error',
      name: 'download_error',
      desc: '',
      args: [],
    );
  }

  /// `Checksum error`
  String get checksum_error {
    return Intl.message(
      'Checksum error',
      name: 'checksum_error',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get about_title {
    return Intl.message(
      'About',
      name: 'about_title',
      desc: '',
      args: [],
    );
  }

  /// `Privacy policy`
  String get privacy_policy {
    return Intl.message(
      'Privacy policy',
      name: 'privacy_policy',
      desc: '',
      args: [],
    );
  }

  /// `Official website`
  String get official_website {
    return Intl.message(
      'Official website',
      name: 'official_website',
      desc: '',
      args: [],
    );
  }

  /// `Version update`
  String get version_update {
    return Intl.message(
      'Version update',
      name: 'version_update',
      desc: '',
      args: [],
    );
  }

  /// `Already the latest version`
  String get already_the_latest_version {
    return Intl.message(
      'Already the latest version',
      name: 'already_the_latest_version',
      desc: '',
      args: [],
    );
  }

  /// `New version found`
  String get new_version_found {
    return Intl.message(
      'New version found',
      name: 'new_version_found',
      desc: '',
      args: [],
    );
  }

  /// `Share now`
  String get share_now {
    return Intl.message(
      'Share now',
      name: 'share_now',
      desc: '',
      args: [],
    );
  }

  /// `Thank you for using WanAndroid!\nWe have updated the %s according to the latest regulatory requirements, and hereby explain to you as follows:\n1. In order to provide you with basic functions related to transactions, we will collect and use necessary information;\n2. Based on your express authorization, we will obtain the storage permission to save the article sharing map, and you have the right to refuse or cancel the authorization;\n3. We will take security measures to protect your information security;\n4. Without your consent, we will not obtain, share or provide your information to third parties.`
  String get privacy_dialog_content {
    return Intl.message(
      'Thank you for using WanAndroid!\nWe have updated the %s according to the latest regulatory requirements, and hereby explain to you as follows:\n1. In order to provide you with basic functions related to transactions, we will collect and use necessary information;\n2. Based on your express authorization, we will obtain the storage permission to save the article sharing map, and you have the right to refuse or cancel the authorization;\n3. We will take security measures to protect your information security;\n4. Without your consent, we will not obtain, share or provide your information to third parties.',
      name: 'privacy_dialog_content',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacy_dialog_content_s {
    return Intl.message(
      'Privacy Policy',
      name: 'privacy_dialog_content_s',
      desc: '',
      args: [],
    );
  }

  /// `Agree`
  String get agree {
    return Intl.message(
      'Agree',
      name: 'agree',
      desc: '',
      args: [],
    );
  }

  /// `Disagree`
  String get disagree {
    return Intl.message(
      'Disagree',
      name: 'disagree',
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
