// create textStyleTheme for large and medium and large fonts and make the font bold for all , letterspacing = 2, color = black

import 'package:flutter/material.dart';

class CustomFontStyle {
  static const TextStyle _baseStyle = TextStyle(
    fontWeight: FontWeight.bold,
    letterSpacing: 2,
    color: Colors.black,
  );

  static TextStyle get veryLarg => _baseStyle.copyWith(fontSize: 24);
  static TextStyle get large => _baseStyle.copyWith(fontSize: 20);
  static TextStyle get medium => _baseStyle.copyWith(fontSize: 18);
  static TextStyle get small => _baseStyle.copyWith(fontSize: 16);
  static TextStyle get verySmall => _baseStyle.copyWith(fontSize: 14);
}
