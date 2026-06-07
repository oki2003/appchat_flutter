import 'dart:ui';

import 'package:flutter/material.dart';

class BrandAppTheme {
  BrandAppTheme({required this.context});
  final BuildContext context;
  bool get isDarkMode => Theme.of(context).brightness == Brightness.dark;

  Color primaryBrandColor = const Color(0xFFDC2626);
  Color primaryLightBrandColor = const Color(0xFFEA580C);
  Color get noteBrandColor =>
      isDarkMode ? const Color(0xFF64748B) : const Color(0xFF71717A);
  Color backgroundInputBrandColor = const Color(0xFFE7E8EB);
  Color borderBrandColor = const Color(0xFFE4E4E7);
  Color get textColor =>
      isDarkMode ? const Color(0xFFFFFFFF) : const Color(0xFF111111);
  Color get containerColor =>
      isDarkMode ? const Color(0xFF242424) : const Color(0xFFFFFFFF);
}
