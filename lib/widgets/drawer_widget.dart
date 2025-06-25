import 'package:customer_loyalty/screens/auth/login_screen.dart';
import 'package:customer_loyalty/widgets/divider_widget.dart';
import 'package:customer_loyalty/widgets/logout_widget.dart';
import 'package:customer_loyalty/widgets/text_widget.dart';
import 'package:flutter/material.dart';

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
                      text: 'Kaffi Cafe',
                      fontSize: 20,
                      fontFamily: 'Bold',
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              DividerWidget(),
              ListTile(
                leading: const Icon(
                  Icons.dashboard_outlined,
                  color: Colors.white,
                  size: 26,
                ),
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                    (route) => false,
                  );
                },
                title: TextWidget(
                  text: 'Dashboard',
                  fontSize: 16,
                  fontFamily: 'Medium',
                  color: Colors.white,
                ),
                hoverColor: Colors.white10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
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
}
