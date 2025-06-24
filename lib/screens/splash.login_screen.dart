import 'dart:async';

import 'package:customer_loyalty/screens/auth/login_screen.dart';
import 'package:customer_loyalty/screens/pin.lock_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(const Duration(seconds: 5), () async {
      Get.off(MerchantLoginScreen(), transition: Transition.zoom);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1C2526),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
      ),
    );
  }
}
