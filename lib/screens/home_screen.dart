import 'package:customer_loyalty/screens/history_screen.dart';
import 'package:customer_loyalty/screens/load.user_screen.dart';
import 'package:customer_loyalty/screens/pin.lock_screen.dart';
import 'package:customer_loyalty/screens/reload_screen.dart';
import 'package:customer_loyalty/utils/colors.dart';
import 'package:customer_loyalty/widgets/amount.purchase_dialog.dart';
import 'package:customer_loyalty/widgets/button_widget.dart';
import 'package:customer_loyalty/widgets/divider_widget.dart';
import 'package:customer_loyalty/widgets/drawer_widget.dart';
import 'package:customer_loyalty/widgets/text_widget.dart';
import 'package:customer_loyalty/widgets/touchable_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:quickalert/quickalert.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Constants for reusable values

  static const _cardGradientColors = [
    Color(0xFF1877F2),
    Color.fromARGB(255, 10, 99, 216)
  ];
  static const _cardPadding = EdgeInsets.all(20.0);
  static const _sectionSpacing = 15.0;
  static const _cardRadius = 16.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      floatingActionButton: _buildFloatingActionButton(context),
      appBar: _buildAppBar(),
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              _buildTotalLoadCard(),
              const SizedBox(height: _sectionSpacing),
              _buildTopUpButton(context),
              const SizedBox(height: _sectionSpacing),
              _buildLoadUserButton(context),
              const SizedBox(height: _sectionSpacing),
              _buildAnalyticsSection(context),
              const SizedBox(height: _sectionSpacing),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    text: 'Transactions ',
                    fontSize: 20,
                    color: Colors.black,
                    fontFamily: 'Bold',
                    isBold: true,
                  ),
                  TextButton(
                    onPressed: () {
                      Get.to(HistoryScreen(), transition: Transition.zoom);
                    },
                    child: TextWidget(
                      text: 'See All',
                      fontSize: 16,
                      color: Colors.black,
                      fontFamily: 'Bold',
                      isBold: true,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 5),
              _buildTransactionSection(),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: bayanihanBlue,
      foregroundColor: Colors.white,
      title: TextWidget(
        text: 'Dashboard',
        fontSize: 20,
        color: Colors.white,
        fontFamily: 'Bold',
      ),
      centerTitle: true,
      elevation: 4,
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _showBottomSheet(context, false),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      backgroundColor: Colors.white,
      elevation: 6,
      child: Icon(
        FontAwesomeIcons.add,
        color: bayanihanBlue,
        size: 28,
      ),
    );
  }

  void _showBottomSheet(BuildContext context, bool isUserLoad) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(_cardRadius)),
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
        if (isLoadUser) {
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
        } else {
          final result = await showDialog<String>(
            context: context,
            builder: (context) => const AmountPurchaseDialog(),
          );

          // Handle the returned value
          if (result != null && context.mounted) {
            // Optionally show a confirmation or process the amount

            Get.to(PinLockScreen(), transition: Transition.zoom)!.whenComplete(
              () async {
                Navigator.pop(context);
                // Logic of RFID Scanning/QR Code Scanning/Card ID Input in here

                // Dialog
                QuickAlert.show(
                    context: context,
                    type: QuickAlertType.success,
                    title: 'Transaction Completed!',
                    text:
                        '${(double.parse(result) * .10).toStringAsFixed(2)} pts is added to # 235 532 235 532',
                    confirmBtnColor: bayanihanBlue,
                    confirmBtnTextStyle:
                        TextStyle(fontFamily: 'Medium', color: Colors.white));
              },
            );
          }
        }
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

  Widget _buildTotalLoadCard() {
    return Container(
      width: double.infinity,
      padding: _cardPadding,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: _cardGradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(_cardRadius),
        boxShadow: [
          BoxShadow(
            color: _cardGradientColors[0].withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWidget(
                text: 'Total Load',
                fontSize: 18,
                color: Colors.white,
                fontFamily: 'Medium',
              ),
              CircleAvatar(
                minRadius: 18,
                maxRadius: 18,
                backgroundColor: Colors.white.withOpacity(0.9),
              ),
            ],
          ),
          TextWidget(
            text: '10,681',
            fontSize: 48,
            color: Colors.white,
            fontFamily: 'Bold',
            isBold: true,
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: TextWidget(
              text: 'Jollibee Food Corp',
              fontSize: 14,
              color: Colors.white70,
              fontFamily: 'Medium',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopUpButton(BuildContext context) {
    return ButtonWidget(
      radius: _cardRadius,
      color: Colors.white,
      textColor: bayanihanBlue,
      width: double.infinity,
      label: 'Reload',
      onPressed: () {
        Get.to(PinLockScreen(), transition: Transition.zoom)!.whenComplete(
          () async {
            Get.off(ReloadScreen(), transition: Transition.zoom);
            // Logic of RFID Scanning/QR Code Scanning/Card ID Input in here

            // Dialog
          },
        );
      },
      fontSize: 18,
    );
  }

  Widget _buildLoadUserButton(BuildContext context) {
    return ButtonWidget(
      radius: _cardRadius,
      color: Colors.white,
      textColor: bayanihanBlue,
      width: double.infinity,
      label: 'Load User',
      onPressed: () => _showBottomSheet(context, true),
      fontSize: 18,
    );
  }

  Widget _buildAnalyticsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          text: 'Summary',
          fontSize: 20,
          color: Colors.black,
          fontFamily: 'Bold',
          isBold: true,
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildAnalyticsCard(
              context,
              icon: FontAwesomeIcons.users,
              title: 'Total Customers',
              value: '1,245',
              gradientColors: [Colors.blue[700]!, Colors.blue[400]!],
            ),
            _buildAnalyticsCard(
              context,
              icon: FontAwesomeIcons.ticket,
              title: 'Points Redeemed',
              value: '25,430',
              gradientColors: [Colors.red[600]!, Colors.red[400]!],
            ),
            _buildAnalyticsCard(
              context,
              icon: FontAwesomeIcons.gift,
              title: 'Points\nGiven',
              value: '32,150',
              gradientColors: [Colors.green[600]!, Colors.green[400]!],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAnalyticsCard(BuildContext context,
      {required IconData icon,
      required String title,
      required String value,
      required List<Color> gradientColors}) {
    return Expanded(
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_cardRadius)),
        child: Container(
          margin: const EdgeInsets.all(3.0),
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: gradientColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(_cardRadius - 4),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              TextWidget(
                text: title,
                fontSize: 14,
                fontFamily: 'Medium',
                color: Colors.white,
              ),
              const SizedBox(height: 12),
              TextWidget(
                text: value,
                fontSize: 24,
                fontFamily: 'Bold',
                color: Colors.white,
                isBold: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionSection() {
    return SizedBox(
      height: 300,
      child: ListView(
        children: [
          _buildTransactionItem(
            '# 235 532 235 532',
            'Oct 20, 10:00 am',
            '+120.22 pts',
          ),
          _buildTransactionItem(
              '# 235 532 235 532', 'Oct 20, 10:05 am', '+60.75 pts'),
          _buildTransactionItem(
            '# 235 532 235 532',
            'Oct 20, 10:10 am',
            '-680 pts',
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(String title, String date, String amount) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: bayanihanBlue,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                FontAwesomeIcons.gift,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    text: title,
                    fontSize: 16,
                    color: Colors.white,
                    fontFamily: 'Medium',
                  ),
                  TextWidget(
                    text: date,
                    fontSize: 12,
                    color: Colors.white70,
                    fontFamily: 'Regular',
                  ),
                ],
              ),
            ),
            TextWidget(
              text: amount,
              fontSize: 16,
              color: Colors.white,
              fontFamily: 'Bold',
              isBold: true,
            ),
          ],
        ),
      ),
    );
  }
}
