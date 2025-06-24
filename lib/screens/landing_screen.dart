import 'package:customer_loyalty/screens/pin.lock_screen.dart';
import 'package:customer_loyalty/utils/colors.dart';
import 'package:customer_loyalty/widgets/text_widget.dart';
import 'package:flutter/material.dart';

import 'package:flutter_swipe_button/flutter_swipe_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // --- Background image ---
          Positioned.fill(
            child: Image.asset(
              'assets/images/backgrounds/customer.jpg',
              fit: BoxFit.cover,
            ),
          ),

          // --- Dark–blue gradient overlay for better contrast ---
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF1C2526).withOpacity(0.5),
                    Colors.transparent
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF1C2526).withOpacity(0.9),
                    Colors.transparent
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
          ),

          // --- Foreground content ---
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                children: [
                  const Spacer(),

                  // Main headline
                  TextWidget(
                    text: 'SukiStar',
                    fontSize: 48,
                    fontFamily: 'Bold',
                    isBold: true,
                    color: Colors.white,
                    align: TextAlign.center,
                  ),

                  SizedBox(
                    width: 275,
                    child: TextWidget(
                      text: 'Your Journey to Exclusive Rewards Starts Here',
                      align: TextAlign.center,
                      fontSize: 12,
                      fontFamily: 'Medium',
                      color: plainWhite,
                    ),
                  ),

                  const Spacer(flex: 2),

                  // Swipe button
                  SwipeButton.expand(
                    height: 60,
                    thumbPadding: const EdgeInsets.all(5),
                    activeThumbColor: Colors.white,
                    activeTrackColor: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(40),
                    thumb: const Icon(FontAwesomeIcons.arrowRight,
                        color: Colors.black, size: 28),
                    // onSwipe: () => Get.off(() => const HomeScreen(),
                    //     transition: Transition.zoom),
                    onSwipe: () async {
                      Get.off(PinLockScreen(), transition: Transition.zoom);
                    },
                    child: TextWidget(
                      text: 'Swipe to continue',
                      fontSize: 18,
                      fontFamily: 'Bold',
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 28),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
