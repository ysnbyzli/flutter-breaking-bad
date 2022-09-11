import 'package:flutter/material.dart';
import 'package:project/theme/color_theme.dart';

class LightTheme {
  late ThemeData theme;

  LightTheme() {
    theme = ThemeData(
      appBarTheme: const AppBarTheme(
        backgroundColor: ThemeColor.darkGreen200,
        shadowColor: ThemeColor.darkGreen,
        elevation: 0,
        toolbarHeight: 80,
      ),
      cardTheme: CardTheme(
        shadowColor: ThemeColor.darkGreen,
        elevation: 8,
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
