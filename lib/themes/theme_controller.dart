import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  var isDark = false.obs;

  ThemeData get lightTheme => ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.yellow[50],
        colorScheme: const ColorScheme.light(
          primary: Colors.blue,
          onPrimary: Colors.white,
          onBackground: Colors.black,
        ),
        textTheme: const TextTheme(
          headlineSmall: TextStyle(color: Colors.black, fontSize: 24),
          bodyMedium: TextStyle(color: Colors.black87),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
      );

  ThemeData get darkTheme => ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        colorScheme: const ColorScheme.dark(
          primary: Colors.teal,
          onPrimary: Colors.white,
          onBackground: Colors.white,
        ),
        textTheme: const TextTheme(
          headlineSmall: TextStyle(color: Colors.white, fontSize: 24),
          bodyMedium: TextStyle(color: Colors.white70),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
        ),
      );

  ThemeData get currentTheme => isDark.value ? darkTheme : lightTheme;

  void toggleTheme() {
    isDark.value = !isDark.value;
    Get.changeTheme(currentTheme);
  }
}
