import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(
      appBarTheme:
          AppBarTheme(backgroundColor: Colors.grey.shade900, elevation: 0),
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Colors.grey.shade900);
}
