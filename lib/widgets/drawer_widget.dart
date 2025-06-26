import 'package:customer_loyalty/screens/auth/login_screen.dart';
import 'package:customer_loyalty/screens/banner_screen.dart';
import 'package:customer_loyalty/screens/history_screen.dart';
import 'package:customer_loyalty/screens/pin.lock_screen.dart';
import 'package:customer_loyalty/screens/reload_screen.dart';
import 'package:customer_loyalty/screens/settings_screen.dart';
import 'package:customer_loyalty/widgets/divider_widget.dart';
import 'package:customer_loyalty/widgets/logout_widget.dart';
import 'package:customer_loyalty/widgets/text_widget.dart';
import 'package:customer_loyalty/widgets/touchable_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/home_screen.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF1C2526),
            Color(0xFF2A3B3C),
          ],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      child: Image.asset(
                        'assets/images/logo.png',
                        height: 100,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextWidget(
                      text: 'Jollibee',
                      fontSize: 20,
                      fontFamily: 'Bold',
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              navBarItem(Icons.dashboard_outlined, 'Dashboard', () {
                Get.off(HomeScreen(), transition: Transition.zoom);
              }),
              navBarItem(Icons.bookmark_border_outlined, 'Banners', () {
                Get.to(PinLockScreen(), transition: Transition.zoom)!
                    .whenComplete(
                  () async {
                    Get.off(BannersScreen(), transition: Transition.zoom);
                    // Logic of RFID Scanning/QR Code Scanning/Card ID Input in here

                    // Dialog
                  },
                );
              }),
              navBarItem(Icons.cached, 'Reload', () {
                Get.to(PinLockScreen(), transition: Transition.zoom)!
                    .whenComplete(
                  () async {
                    Get.off(ReloadScreen(), transition: Transition.zoom);
                    // Logic of RFID Scanning/QR Code Scanning/Card ID Input in here

                    // Dialog
                  },
                );
              }),
              navBarItem(Icons.history, 'History', () {
                Get.off(HistoryScreen(), transition: Transition.zoom);
              }),
              navBarItem(Icons.settings, 'Settings', () {
                Get.to(PinLockScreen(), transition: Transition.zoom)!
                    .whenComplete(
                  () async {
                    Get.off(SettingsScreen(), transition: Transition.zoom);
                    // Logic of RFID Scanning/QR Code Scanning/Card ID Input in here

                    // Dialog
                  },
                );
              }),
              const Spacer(),
              DividerWidget(),
              const SizedBox(height: 12),
              ListTile(
                leading: const Icon(
                  Icons.logout_rounded,
                  color: Colors.redAccent,
                  size: 26,
                ),
                onTap: () {
                  // Implement logout logic
                  logout(context, MerchantLoginScreen());
                },
                title: TextWidget(
                  text: 'Logout',
                  fontSize: 16,
                  fontFamily: 'Medium',
                  color: Colors.redAccent,
                ),
                hoverColor: Colors.white10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget navBarItem(
    IconData icon,
    String title,
    Function onTap,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TouchableWidget(
        onTap: () {
          onTap();
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          height: 50,
          child: ListTile(
            trailing: Icon(
              icon,
              color: Colors.white,
              size: 26,
            ),
            title: TextWidget(
              text: title,
              fontSize: 16,
              fontFamily: 'Medium',
              color: Colors.white,
            ),
            hoverColor: Colors.white10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}
