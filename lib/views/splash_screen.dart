import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspire_me/views/getstarted_screen.dart';
import 'login_screen.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 3), () {
      Get.off(() => GetStartedScreen());
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Lottie.network(
          'https://assets2.lottiefiles.com/packages/lf20_kyu7xb1v.json', // Example animation from LottieFiles
          width: 200,
          height: 200,
          repeat: true,
        ),
      ),
    );
  }
}
