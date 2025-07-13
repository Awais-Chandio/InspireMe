import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'views/home_screen.dart';
import 'themes/theme_controller.dart';
import 'controllers/quote_controller.dart';

void main() {
  // Initialize controllers before the app starts
  Get.put(ThemeController());
  Get.put(QuoteController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Use Get.find() here since controllers are already initialized above
    final themeController = Get.find<ThemeController>();

    return Obx(() => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'InspireMe',
          theme: themeController.currentTheme,
          home: HomeScreen(),
        ));
  }
}
