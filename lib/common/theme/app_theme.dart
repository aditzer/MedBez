import 'package:flutter/material.dart';
import 'package:medbez/common/constants/constants.dart';

ThemeData theme() {
  return ThemeData(
      scaffoldBackgroundColor: Colors.white,
      colorScheme: ColorScheme.fromSeed(seedColor: primaryGreen),
      useMaterial3: true,
      appBarTheme: appBarTheme(),
  );
}

AppBarTheme appBarTheme() {
  return const AppBarTheme(
      elevation: 2,
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: appBarGreen,
      foregroundColor: Colors.white
  );
}