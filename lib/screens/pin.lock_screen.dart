import 'package:customer_loyalty/screens/home_screen.dart';
import 'package:customer_loyalty/utils/colors.dart';
import 'package:customer_loyalty/widgets/text_widget.dart';
import 'package:customer_loyalty/widgets/touchable_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PinLockScreen extends StatefulWidget {
  @override
  _PinLockScreenState createState() => _PinLockScreenState();
}

class _PinLockScreenState extends State<PinLockScreen> {
  String _pin = '';
  final int _pinLength = 6;

  void _addNumber(String number) {
    if (_pin.length < _pinLength) {
      setState(() {
        _pin += number;
        if (_pin.length == _pinLength) {
          // Navigate to success screen after 6 digits
          Get.back(result: _pin);
        }
      });
    }
  }

  void _deleteNumber() {
    if (_pin.isNotEmpty) {
      setState(() {
        _pin = _pin.substring(0, _pin.length - 1);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1C2526), // Dark background
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Greeting with Date/Time
            TextWidget(
              text: 'Enter the pin number from your card',
              fontSize: 16,
              color: Colors.white70,
              align: TextAlign.center,
            ),
            SizedBox(height: 20),
            // PIN Display
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _pinLength,
                (index) => Container(
                  margin: EdgeInsets.all(8),
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: index < _pin.length ? bayanihanBlue : Colors.grey,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
            SizedBox(height: 40),
            // Numeric Keypad
            SingleChildScrollView(
              child: Column(
                children: [
                  _buildKeypadRow(['1', '2', '3']),
                  _buildKeypadRow(['4', '5', '6']),
                  _buildKeypadRow(['7', '8', '9']),
                  _buildKeypadRow(['', '0', '⌫']),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKeypadRow(List<String> numbers) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: numbers.map((number) {
          return Padding(
            padding: EdgeInsets.all(8.0),
            child: TouchableWidget(
              onTap: () {
                if (number == '⌫') {
                  _deleteNumber();
                } else if (number.isNotEmpty) {
                  _addNumber(number);
                }
              },
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: bayanihanBlue,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: TextWidget(
                    text: number == '⌫' ? '⌫' : number,
                    fontSize: 24,
                    color: Colors.white,
                    isBold: true,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
