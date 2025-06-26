import 'package:customer_loyalty/screens/auth/login_screen.dart';
import 'package:customer_loyalty/screens/banner_screen.dart';
import 'package:customer_loyalty/screens/developers_screen.dart';
import 'package:customer_loyalty/screens/history_screen.dart';
import 'package:customer_loyalty/screens/load.user_screen.dart';
import 'package:customer_loyalty/screens/pin.lock_screen.dart';
import 'package:customer_loyalty/screens/privacy.policy_screen.dart';
import 'package:customer_loyalty/screens/reload_screen.dart';
import 'package:customer_loyalty/screens/settings_screen.dart';
import 'package:customer_loyalty/utils/colors.dart';
import 'package:customer_loyalty/widgets/divider_widget.dart';
import 'package:customer_loyalty/widgets/logout_widget.dart';
import 'package:customer_loyalty/widgets/text_widget.dart';
import 'package:customer_loyalty/widgets/touchable_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
            Color.fromARGB(255, 3, 69, 156),
            bayanihanBlue,
          ],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: 100,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                navBarItem(Icons.dashboard_outlined, 'Dashboard', () {
                  Get.off(HomeScreen(), transition: Transition.zoom);
                }),
                navBarItem(Icons.cached, 'Reload Points', () {
                  Get.to(PinLockScreen(), transition: Transition.zoom)!
                      .whenComplete(
                    () async {
                      Get.off(ReloadScreen(), transition: Transition.zoom);
                      // Logic of RFID Scanning/QR Code Scanning/Card ID Input in here

                      // Dialog
                    },
                  );
                }),
                navBarItem(Icons.person_add_alt_1_outlined, 'Load User', () {
                  _showBottomSheet(context, true);
                }),
                navBarItem(Icons.history, 'History', () {
                  Get.off(HistoryScreen(), transition: Transition.zoom);
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
                DividerWidget(),
                SizedBox(
                  height: 20,
                ),
                navBarItem(Icons.code, 'Developers', () {
                  Get.to(DevelopersScreen(), transition: Transition.zoom);
                }),
                navBarItem(Icons.privacy_tip_outlined, 'Privacy Policy', () {
                  Get.to(PrivacyPolicyScreen(), transition: Transition.zoom);
                }),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: TouchableWidget(
                    onTap: () {
                      logout(context, MerchantLoginScreen());
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 50,
                      child: ListTile(
                        trailing: Icon(
                          Icons.logout_rounded,
                          color: Colors.white,
                          size: 26,
                        ),
                        title: TextWidget(
                          text: 'Logout',
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
                ),
              ],
            ),
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

  void _showBottomSheet(BuildContext context, bool isUserLoad) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      backgroundColor: const Color.fromARGB(255, 4, 89, 199),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildBottomSheetItem(
                icon: FontAwesomeIcons.barcode,
                text: 'Scan Loyalty Card',
                context: context,
                isLoadUser: isUserLoad,
              ),
              DividerWidget(color: Colors.white.withOpacity(0.5)),
              _buildBottomSheetItem(
                icon: FontAwesomeIcons.qrcode,
                text: 'Scan QR Code',
                context: context,
                isLoadUser: isUserLoad,
              ),
              DividerWidget(color: Colors.white.withOpacity(0.5)),
              _buildBottomSheetItem(
                icon: FontAwesomeIcons.hashtag,
                text: 'Input Card Number',
                context: context,
                isLoadUser: isUserLoad,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBottomSheetItem(
      {required IconData icon,
      required String text,
      required BuildContext context,
      required bool isLoadUser}) {
    return TouchableWidget(
      onTap: () async {
        Get.to(PinLockScreen(), transition: Transition.zoom)!.whenComplete(
          () async {
            Navigator.pop(context);
            // Logic of RFID Scanning/QR Code Scanning/Card ID Input in here

            // Dialog
            Get.to(
                LoadUserCardScreen(
                  userId: '12345',
                ),
                transition: Transition.zoom);
          },
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 24),
            const SizedBox(width: 16),
            TextWidget(
              text: text,
              fontSize: 16,
              color: Colors.white,
              fontFamily: 'Medium',
            ),
          ],
        ),
      ),
    );
  }
}
