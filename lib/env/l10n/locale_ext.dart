import 'package:flutter/material.dart';

class LocaleInfo {
  final List<String> languageTags;
  final String languageName;
  final String chineseName;
  final String englishName;

  LocaleInfo({
    required this.languageTags,
    required this.languageName,
    required this.chineseName,
    required this.englishName,
  });

  List<Locale> get locales {
    return languageTags.map((tag) {
      if (tag.contains('_') && tag.contains('-')) {
        var splits = tag.split(RegExp('[-_]'));
        return Locale.fromSubtags(
          languageCode: splits[0],
          countryCode: splits[1],
          scriptCode: splits[2],
        );
      } else if (tag.contains('_')) {
        var splits = tag.split(RegExp('[_]'));
        return Locale.fromSubtags(
          languageCode: splits[0],
          countryCode: splits[1],
        );
      } else if (tag.contains('-')) {
        var splits = tag.split(RegExp('[-]'));
        return Locale.fromSubtags(
          languageCode: splits[0],
          scriptCode: splits[1],
        );
      } else {
        return Locale.fromSubtags(
          languageCode: tag,
        );
      }
    }).toList();
  }
}

class LocaleInfos {
  static List<LocaleInfo> all = [
    LocaleInfo(
      languageTags: ['en_US'],
      languageName: 'English',
      chineseName: '英文',
      englishName: 'English',
    ),
    LocaleInfo(
      languageTags: ['ar_EG', 'ar_IL'],
      languageName: 'العربية',
      chineseName: '阿拉伯语',
      englishName: 'Arabic',
    ),
    LocaleInfo(
      languageTags: ['bg_BG'],
      languageName: 'български',
      chineseName: '保加利亚语',
      englishName: 'bulgarian',
    ),
    LocaleInfo(
      languageTags: ['bs_BA'],
      languageName: '　',
      chineseName: '波斯尼亚语',
      englishName: '　',
    ),
    LocaleInfo(
      languageTags: ['cs_CZ'],
      languageName: 'čeština',
      chineseName: '捷克语',
      englishName: 'Czech',
    ),
    LocaleInfo(
      languageTags: ['da_DK'],
      languageName: 'Dansk',
      chineseName: '丹麦语',
      englishName: 'Danish',
    ),
    LocaleInfo(
      languageTags: ['de_DE', 'de_AT', 'de_CH'],
      languageName: 'Deutsch',
      chineseName: '德语',
      englishName: 'German',
    ),
    LocaleInfo(
      languageTags: ['el_GR'],
      languageName: 'ελληνικά',
      chineseName: '希腊',
      englishName: 'Greek',
    ),
    LocaleInfo(
      languageTags: ['es_ES', 'es_US'],
      languageName: 'Español',
      chineseName: '西班牙语',
      englishName: 'Spanish',
    ),
    LocaleInfo(
      languageTags: ['et_EE'],
      languageName: 'eesti',
      chineseName: '爱沙尼亚语',
      englishName: 'Estonian',
    ),
    LocaleInfo(
      languageTags: ['fa_IR'],
      languageName: 'فارسی',
      chineseName: '波斯语',
      englishName: 'Perisan',
    ),
    LocaleInfo(
      languageTags: ['fi_FI'],
      languageName: 'Suomi',
      chineseName: '芬兰语',
      englishName: 'Finnish',
    ),
    LocaleInfo(
      languageTags: ['fr_FR'],
      languageName: 'Français',
      chineseName: '法语',
      englishName: 'French',
    ),
    LocaleInfo(
      languageTags: ['ha_GH', 'ha_NE', 'ha_NG'],
      languageName: 'Hausa',
      chineseName: '豪萨语',
      englishName: 'Hausa',
    ),
    LocaleInfo(
      languageTags: ['hr_HR'],
      languageName: 'hrvatski',
      chineseName: '克罗地亚语',
      englishName: 'Croatian',
    ),
    LocaleInfo(
      languageTags: ['hu_HU'],
      languageName: 'Magyar',
      chineseName: '匈牙利语',
      englishName: 'Hungarian',
    ),
    LocaleInfo(
      languageTags: ['in_ID'],
      languageName: 'Indonesia',
      chineseName: '印度尼西亚语',
      englishName: 'Indonesian',
    ),
    LocaleInfo(
      languageTags: ['it_IT', 'it_CH'],
      languageName: 'Italiano',
      chineseName: '意大利语',
      englishName: 'Italian',
    ),
    LocaleInfo(
      languageTags: ['he_IL', 'iw_IL'],
      languageName: 'עברית',
      chineseName: '希伯来语',
      englishName: 'Hebrew',
    ),
    LocaleInfo(
      languageTags: ['ja_JP'],
      languageName: '日本語の言語',
      chineseName: '日语',
      englishName: 'Japanese',
    ),
    LocaleInfo(
      languageTags: ['lo_LA'],
      languageName: 'ລາວ',
      chineseName: '老挝语',
      englishName: 'Laotian',
    ),
    LocaleInfo(
      languageTags: ['lt_LT'],
      languageName: 'Lietuvių',
      chineseName: '立陶宛',
      englishName: 'Lithuanian',
    ),
    LocaleInfo(
      languageTags: ['lv_LV'],
      languageName: 'latviešu',
      chineseName: '拉脱维亚语',
      englishName: 'Latviesu',
    ),
    LocaleInfo(
      languageTags: ['mk_MK'],
      languageName: 'македонски јазик',
      chineseName: '马其顿语',
      englishName: 'Macedonian',
    ),
    LocaleInfo(
      languageTags: ['mn_MN'],
      languageName: 'Монгол',
      chineseName: '蒙古语',
      englishName: 'Mongolian',
    ),
    LocaleInfo(
      languageTags: ['ms_MY'],
      languageName: 'Bahasa Melayu',
      chineseName: '马来西亚语',
      englishName: 'Malay',
    ),
    LocaleInfo(
      languageTags: ['nb_NO'],
      languageName: 'Norsk bokmal',
      chineseName: '挪威语',
      englishName: 'Norwegian',
    ),
    LocaleInfo(
      languageTags: ['ne_NP'],
      languageName: 'नेपाली',
      chineseName: '尼泊尔语',
      englishName: 'Nepali',
    ),
    LocaleInfo(
      languageTags: ['nl_NL', 'nl_BE'],
      languageName: 'Nederlands',
      chineseName: '荷兰语',
      englishName: 'Dutch',
    ),
    LocaleInfo(
      languageTags: ['pl_PL'],
      languageName: 'Polski',
      chineseName: '波兰语',
      englishName: 'Polish',
    ),
    LocaleInfo(
      languageTags: ['pt_BR', 'pt_PT'],
      languageName: 'Protuguês',
      chineseName: '葡萄牙语',
      englishName: 'Portuguese',
    ),
    LocaleInfo(
      languageTags: ['ro_RO'],
      languageName: 'româna',
      chineseName: '罗马尼亚',
      englishName: 'Romanian',
    ),
    LocaleInfo(
      languageTags: ['ru_RU'],
      languageName: 'Русский',
      chineseName: '俄语',
      englishName: 'Russian',
    ),
    LocaleInfo(
      languageTags: ['sk_SK'],
      languageName: 'Slovenčina',
      chineseName: '斯洛伐克语',
      englishName: 'Slovencina',
    ),
    LocaleInfo(
      languageTags: ['sl_SI'],
      languageName: 'Slovenščina',
      chineseName: '斯洛文尼亚语',
      englishName: 'Slovenian',
    ),
    LocaleInfo(
      languageTags: ['sq_AL'],
      languageName: 'shqiptar',
      chineseName: '阿尔巴尼亚语',
      englishName: 'Albanian',
    ),
    LocaleInfo(
      languageTags: ['sr_RS'],
      languageName: 'српски',
      chineseName: '塞尔维亚语',
      englishName: 'Serbian',
    ),
    LocaleInfo(
      languageTags: ['sv_SE'],
      languageName: 'Svenska',
      chineseName: '瑞典语',
      englishName: 'Swedish',
    ),
    LocaleInfo(
      languageTags: ['th_TH'],
      languageName: 'ไทย',
      chineseName: '泰语',
      englishName: 'Thai',
    ),
    LocaleInfo(
      languageTags: ['tr_TR'],
      languageName: 'Türkçe',
      chineseName: '土耳其语',
      englishName: 'Turkey',
    ),
    LocaleInfo(
      languageTags: ['uk_UA'],
      languageName: 'українська',
      chineseName: '乌克兰语',
      englishName: 'Ukrainian',
    ),
    LocaleInfo(
      languageTags: ['ur_PK'],
      languageName: 'اردو',
      chineseName: '乌尔都语',
      englishName: 'Urdu',
    ),
    LocaleInfo(
      languageTags: ['vi_VN'],
      languageName: 'tiếng việt',
      chineseName: '越南语',
      englishName: 'Vietnamese',
    ),
    LocaleInfo(
      languageTags: ['zh_CN'],
      languageName: '简体中文',
      chineseName: '简体中文',
      englishName: 'Chinese Simplified',
    ),
    LocaleInfo(
      languageTags: ['zh_TW'],
      languageName: '繁體中文',
      chineseName: '繁体中文',
      englishName: 'Chinese Traditional',
    ),
    LocaleInfo(
      languageTags: ['bn_BD', 'bn_IN'],
      languageName: 'বাংলা',
      chineseName: '孟加拉语',
      englishName: 'Bengali',
    ),
    LocaleInfo(
      languageTags: ['hi_IN'],
      languageName: 'हिंदी',
      chineseName: '印度语',
      englishName: 'Hindi',
    ),
    LocaleInfo(
      languageTags: ['ko_KR'],
      languageName: '한국의',
      chineseName: '韩语',
      englishName: 'Korean',
    ),
    LocaleInfo(
      languageTags: ['ca_ES'],
      languageName: 'catalá',
      chineseName: '加泰罗尼亚语',
      englishName: 'Catalan',
    ),
    LocaleInfo(
      languageTags: ['tl_PH'],
      languageName: 'Tagalog',
      chineseName: '菲律宾语',
      englishName: 'Filipino',
    ),
    LocaleInfo(
      languageTags: ['af_ZA'],
      languageName: 'Afrikaans',
      chineseName: '南非语',
      englishName: 'Afrikaans',
    ),
    LocaleInfo(
      languageTags: ['rm_CH'],
      languageName: 'Rumantsch',
      chineseName: '罗曼什语',
      englishName: 'Romansh',
    ),
    LocaleInfo(
      languageTags: ['my_ZG', 'my_MM'],
      languageName: 'ဗမာ',
      chineseName: '缅甸语',
      englishName: 'Burmese',
    ),
    LocaleInfo(
      languageTags: ['km_KH'],
      languageName: 'ខ្មែរ',
      chineseName: '柬埔寨语',
      englishName: 'Khmer',
    ),
    LocaleInfo(
      languageTags: ['am_ET'],
      languageName: 'አማርኛ',
      chineseName: '阿姆哈拉语',
      englishName: 'Amharic',
    ),
    LocaleInfo(
      languageTags: ['be_BY'],
      languageName: 'беларуская',
      chineseName: '白俄罗斯语',
      englishName: '	Belarusian',
    ),
    LocaleInfo(
      languageTags: ['sw_TZ'],
      languageName: 'Kiswahili',
      chineseName: '斯瓦希里语',
      englishName: '	Swahili',
    ),
    LocaleInfo(
      languageTags: ['zu_ZA'],
      languageName: 'isiZulu',
      chineseName: '祖鲁语',
      englishName: 'Zulu',
    ),
    LocaleInfo(
      languageTags: ['az_AZ'],
      languageName: 'azərbaycanca',
      chineseName: '阿塞拜疆语',
      englishName: '	 Azerbaijani',
    ),
    LocaleInfo(
      languageTags: ['hy_AM'],
      languageName: 'Հայերէն',
      chineseName: '亚美尼亚语',
      englishName: 'Armenian',
    ),
    LocaleInfo(
      languageTags: ['ka_GE'],
      languageName: 'ქართული',
      chineseName: '格鲁吉亚语',
      englishName: 'Georgian',
    ),
    LocaleInfo(
      languageTags: ['kk_KZ'],
      languageName: 'қазақ тілі',
      chineseName: '哈萨克语',
      englishName: 'Kazakh',
    ),
    LocaleInfo(
      languageTags: ['gl-rES'],
      languageName: 'Galego',
      chineseName: '加利西亚语',
      englishName: 'Galician',
    ),
    LocaleInfo(
      languageTags: ['is-rIS'],
      languageName: 'íslenska',
      chineseName: '冰岛语',
      englishName: 'Icelandic',
    ),
    LocaleInfo(
      languageTags: ['kn-rIN'],
      languageName: 'ಕನ್ನಡ',
      chineseName: '坎纳达语',
      englishName: 'Kannada',
    ),
    LocaleInfo(
      languageTags: ['ky-rKG'],
      languageName: 'кыргыз тили; قىرعىز تىلى',
      chineseName: '吉尔吉斯语',
      englishName: 'Kyrgyz',
    ),
    LocaleInfo(
      languageTags: ['ml-rIN'],
      languageName: 'മലയാളം',
      chineseName: '马拉亚拉姆语',
      englishName: '	Malayalam',
    ),
    LocaleInfo(
      languageTags: ['mr-rIN'],
      languageName: 'मराठी',
      chineseName: '马拉提语/马拉地语',
      englishName: 'Marathi',
    ),
    LocaleInfo(
      languageTags: ['ta-rIN'],
      languageName: 'தமிழ்',
      chineseName: '泰米尔语',
      englishName: 'Tamil',
    ),
    LocaleInfo(
      languageTags: ['te-rIN'],
      languageName: 'తెలుగు',
      chineseName: '泰卢固语',
      englishName: 'Telugu',
    ),
    LocaleInfo(
      languageTags: ['uz-rUZ'],
      languageName: 'Ўзбек тили',
      chineseName: '乌兹别克语',
      englishName: 'Uzbek',
    ),
    LocaleInfo(
      languageTags: ['eu-rES'],
      languageName: 'Euskara',
      chineseName: '巴斯克语',
      englishName: 'Basque',
    ),
    LocaleInfo(
      languageTags: ['si_LK'],
      languageName: 'සිංහල',
      chineseName: '僧加罗语',
      englishName: 'Sinhala',
    ),
  ];
}

extension LocaleExt on Locale {
  LocaleInfo? get localeInfo {
    Locale currLocale = this;
    for (var localeInfo in LocaleInfos.all) {
      for (var locale in localeInfo.locales) {
        if (locale == currLocale) {
          return localeInfo;
        }
      }
    }
    for (var localeInfo in LocaleInfos.all) {
      for (var locale in localeInfo.locales) {
        if (locale.languageCode == currLocale.languageCode &&
            (locale.countryCode == currLocale.countryCode ||
                locale.scriptCode == currLocale.scriptCode)) {
          return localeInfo;
        }
      }
    }
    for (var localeInfo in LocaleInfos.all) {
      for (var locale in localeInfo.locales) {
        if (locale.languageCode == currLocale.languageCode) {
          return localeInfo;
        }
      }
    }
    return null;
  }
}
