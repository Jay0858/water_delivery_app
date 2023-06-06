import 'dart:async';

import 'package:flutter/material.dart';
import 'package:water_delivery_app/res/constant/app_colors.dart';
import 'package:water_delivery_app/res/constant/app_images.dart';
import 'package:water_delivery_app/res/constant/app_string.dart';
import 'package:water_delivery_app/view/onboading/onboading_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 6),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const OnboadingScreen(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.LightBlue,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                height: height / 5,
                AppImages.drips,
              ),
            ),
            SizedBox(height: height / 50),
            const Center(
              child: Text(
                AppString.appName,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 38,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
