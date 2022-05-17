library tiengviet;

import 'dart:ui';

import 'package:tiengviet/tiengviet.dart';
import 'package:worldsoft_maintain/Common/Config.dart';

/**
 * [text] vietnamese language
 * [return] vietnamese language unsign
 */
String tiengviet(String text) => TiengVietCore.unsign(text);

Color hexToColor(String hex) {
  hex = hex.replaceFirst('#', '');
  hex = hex.length == 6 ? 'ff' + hex : hex;
  int val = int.parse(hex, radix: 16);
  return Color(val);
}

String generateUrl(String text) {
  if (text.startsWith("http"))
    return text;
  else
    return BaseURL + text;
}
