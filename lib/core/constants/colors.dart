import 'package:flutter/material.dart';

abstract class AppColors {
  static Color white = Colors.white;
  static Color black = Colors.black;
  static Color transparent = Colors.transparent;
  static Color primary = const Color(0xffebd279);
  static Color secondary = const Color(0xff221f20);

  // Brand Colors
  static const brandColor = _BrandColors();

  // Brand Colors
  static const accentColor = _AccentColors();

  // Neutral Colors
  static const neutral = _NeutralColors();

  // Error Colors
  static const error = _ErrorColors();

  // Warning Colors
  static const warning = _WarningColors();

  // Success Colors
  static const success = _SuccessColors();
}

class _BrandColors {
  const _BrandColors();

  final brandColor25 = const Color(0xfff7edc9);
  final brandColor50 = const Color(0xfff5e9bc);
  final brandColor100 = const Color(0xfff3e4af);
  final brandColor200 = const Color(0xfff1e0a1);
  final brandColor300 = const Color(0xffefdb94);
  final brandColor400 = const Color(0xffedd786);
  final brandColor500 = const Color(0xffebd279);
  final brandColor600 = const Color(0xffd4bd6d);
  final brandColor700 = const Color(0xffbca861);
  final brandColor800 = const Color(0xffa59355);
  final brandColor900 = const Color(0xff8d7e49);
  final brandColor950 = const Color(0xff76693d);
  final brandColor1000 = const Color(0xff5e5430);
}

class _AccentColors {
  const _AccentColors();

  final accentColor25 = const Color(0xffa7a5a6);
  final accentColor50 = const Color(0xff918f90);
  final accentColor100 = const Color(0xff7a7979);
  final accentColor200 = const Color(0xff646263);
  final accentColor300 = const Color(0xff4e4c4d);
  final accentColor400 = const Color(0xff383536);
  final accentColor500 = const Color(0xff221f20);
  final accentColor600 = const Color(0xff1f1c1d);
  final accentColor700 = const Color(0xff1b191a);
  final accentColor800 = const Color(0xff181616);
  final accentColor900 = const Color(0xff141313);
  final accentColor950 = const Color(0xff111010);
  final accentColor1000 = const Color(0xff0e0c0d);
}

class _NeutralColors {
  const _NeutralColors();

  final neutralColor25 = const Color(0xfff8f8f8);
  final neutralColor50 = const Color(0xfff7f7f7);
  final neutralColor100 = const Color(0xfff5f5f5);
  final neutralColor200 = const Color(0xfff3f3f3);
  final neutralColor300 = const Color(0xfff1f1f1);
  final neutralColor400 = const Color(0xfff0f0f0);
  final neutralColor500 = const Color(0xffeeeeee);
  final neutralColor600 = const Color(0xffd6d6d6);
  final neutralColor700 = const Color(0xffbebebe);
  final neutralColor800 = const Color(0xffa7a7a7);
  final neutralColor900 = const Color(0xff8f8f8f);
  final neutralColor950 = const Color(0xff777777);
  final neutralColor1000 = const Color(0xff5f5f5f);
}

class _ErrorColors {
  const _ErrorColors();

  final errorColor25 = const Color(0xffebacb1);
  final errorColor50 = const Color(0xffe6989e);
  final errorColor100 = const Color(0xffe0838a);
  final errorColor200 = const Color(0xffdb6e77);
  final errorColor300 = const Color(0xffd65963);
  final errorColor400 = const Color(0xffd14550);
  final errorColor500 = const Color(0xffcc303c);
  final errorColor600 = const Color(0xffb82b36);
  final errorColor700 = const Color(0xffa32630);
  final errorColor800 = const Color(0xff8f222a);
  final errorColor900 = const Color(0xff7a1d24);
  final errorColor950 = const Color(0xff66181e);
  final errorColor1000 = const Color(0xff521318);
}

class _WarningColors {
  const _WarningColors();

  final warningColor25 = const Color(0xfff8e5b9);
  final warningColor50 = const Color(0xfff6dfa7);
  final warningColor100 = const Color(0xfff4d895);
  final warningColor200 = const Color(0xfff2d284);
  final warningColor300 = const Color(0xfff1cb72);
  final warningColor400 = const Color(0xffefc561);
  final warningColor500 = const Color(0xffedbe4f);
  final warningColor600 = const Color(0xffd5ab47);
  final warningColor700 = const Color(0xffbe983f);
  final warningColor800 = const Color(0xffa68537);
  final warningColor900 = const Color(0xff8e722f);
  final warningColor950 = const Color(0xff775f28);
  final warningColor1000 = const Color(0xff5f4c20);
}

class _SuccessColors {
  const _SuccessColors();

  final successColor25 = const Color(0xffb1cdb7);
  final successColor50 = const Color(0xff9dc0a5);
  final successColor100 = const Color(0xff89b393);
  final successColor200 = const Color(0xff76a781);
  final successColor300 = const Color(0xff629a6f);
  final successColor400 = const Color(0xff4f8e5d);
  final successColor500 = const Color(0xff3b814b);
  final successColor600 = const Color(0xff357444);
  final successColor700 = const Color(0xff2f673c);
  final successColor800 = const Color(0xff295a35);
  final successColor900 = const Color(0xff234d2d);
  final successColor950 = const Color(0xff1e4126);
  final successColor1000 = const Color(0xff18341e);
}
