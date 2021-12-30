import 'package:flutter/material.dart';
import 'package:flutter_html/html_parser.dart';

class StringUtils {
  static String simplifyToSingleLine(String str) {
    var text = HtmlParser.parseHTML(str).body?.text;
    if (text == null) return str;
    text = text.replaceAll(RegExp('\\s{2}|\t|\r|\n'), ' ');
    var chars = Characters(text);
    return chars.join('\u{200B}');
  }
}
