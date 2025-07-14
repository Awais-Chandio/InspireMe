import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspire_me/views/splash_screen.dart';
import 'views/home_screen.dart';
import 'themes/theme_controller.dart';
import 'controllers/quote_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    
    options: DefaultFirebaseOptions.currentPlatform,
);
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
          home: SplashScreen(),
        ));
  }
}
