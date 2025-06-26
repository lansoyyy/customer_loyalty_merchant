import 'package:customer_loyalty/utils/colors.dart';
import 'package:customer_loyalty/widgets/drawer_widget.dart';
import 'package:customer_loyalty/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoadUserCardScreen extends StatefulWidget {
  String userId;

  LoadUserCardScreen({required this.userId});

  @override
  _LoadUserCardScreenState createState() => _LoadUserCardScreenState();
}

class _LoadUserCardScreenState extends State<LoadUserCardScreen> {
  final TextEditingController _pointsController = TextEditingController();

  final double _currentBalance = 1234.50;

  @override
  void dispose() {
    _pointsController.dispose();
    super.dispose();
  }

  void _showInfoDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: Colors.white,
        title: TextWidget(
          text: 'About Load User Card',
          fontSize: 18,
          fontFamily: 'Bold',
          color: bayanihanBlue,
          isBold: true,
        ),
        content: TextWidget(
          text:
              'The points entered here will be loaded onto the selected user\'s loyalty card, increasing their available balance for rewards.',
          fontSize: 16,
          fontFamily: 'Regular',
          color: Colors.black87,
          maxLines: 50,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: TextWidget(
              text: 'Close',
              fontSize: 14,
              fontFamily: 'Medium',
              color: bayanihanBlue,
            ),
          ),
        ],
      ),
    );
  }

  void _handleConfirm() {
    final pointsText = _pointsController.text;
    if (pointsText.isEmpty ||
        double.tryParse(pointsText) == null ||
        double.parse(pointsText) <= 0) {
      _showSnackBar('Please enter a valid points amount', Colors.red[600]!);
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: Colors.white,
        title: TextWidget(
          text: 'Confirm Load',
          fontSize: 18,
          fontFamily: 'Bold',
          color: bayanihanBlue,
          isBold: true,
        ),
        content: TextWidget(
          text:
              'Are you sure you want to load $pointsText points to the user\'s card?',
          fontSize: 16,
          fontFamily: 'Regular',
          color: Colors.black87,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: TextWidget(
              text: 'Cancel',
              fontSize: 14,
              fontFamily: 'Medium',
              color: Colors.grey[600],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Placeholder for loading points to user's card
              print('Loading $pointsText points to user card');
              _showSnackBar('Points loaded successfully!', bayanihanBlue);
              _pointsController.clear();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: bayanihanBlue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            child: TextWidget(
              text: 'Confirm',
              fontSize: 14,
              fontFamily: 'Medium',
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: TextWidget(
          text: message,
          fontSize: 14,
          fontFamily: 'Regular',
          color: Colors.white,
        ),
        backgroundColor: color,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        backgroundColor: bayanihanBlue,
        foregroundColor: Colors.white,
        title: TextWidget(
          text: 'Load User Card',
          fontSize: 20,
          fontFamily: 'Bold',
          color: Colors.white,
          isBold: true,
        ),
        centerTitle: true,
        elevation: 4,
        actions: [
          IconButton(
            onPressed: _showInfoDialog,
            icon: const Icon(Icons.info_outline),
          ),
        ],
      ),
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          text: 'Current Balance',
                          fontSize: 16,
                          fontFamily: 'Medium',
                          color: Colors.grey[800],
                        ),
                        TextWidget(
                          text: '$_currentBalance pts',
                          fontSize: 24,
                          fontFamily: 'Bold',
                          color: bayanihanBlue,
                          isBold: true,
                        ),
                      ],
                    ),
                    Icon(
                      FontAwesomeIcons.wallet,
                      color: bayanihanBlue,
                      size: 24,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextWidget(
              text: 'Load Points to User Card',
              fontSize: 18,
              fontFamily: 'Bold',
              color: Colors.white,
              isBold: true,
            ),
            const SizedBox(height: 12),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: _pointsController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Enter points amount (e.g., 100.00)',
                        hintStyle: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Regular',
                          color: Colors.grey[600],
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(color: bayanihanBlue.withOpacity(0.3)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(color: bayanihanBlue.withOpacity(0.3)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(color: bayanihanBlue, width: 2),
                        ),
                        prefixIcon: Icon(Icons.monetization_on,
                            color: bayanihanBlue, size: 20),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 10),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'Regular',
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _handleConfirm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: bayanihanBlue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          elevation: 2,
                          shadowColor: bayanihanBlue.withOpacity(0.3),
                        ),
                        child: TextWidget(
                          text: 'Confirm',
                          fontSize: 16,
                          fontFamily: 'Bold',
                          color: Colors.white,
                          isBold: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
