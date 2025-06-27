import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer_loyalty/screens/home_screen.dart';
import 'package:customer_loyalty/utils/colors.dart';
import 'package:customer_loyalty/widgets/loading.indicator_widget.dart';
import 'package:customer_loyalty/widgets/text_widget.dart';
import 'package:customer_loyalty/widgets/touchable_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quickalert/quickalert.dart';

class PinLockScreen extends StatefulWidget {
  @override
  _PinLockScreenState createState() => _PinLockScreenState();
}

class _PinLockScreenState extends State<PinLockScreen> {
  @override
  void initState() {
    super.initState();
    getPin();
  }

  final box = GetStorage();
  bool hasLoaded = false;
  getPin() async {
    FirebaseFirestore.instance
        .collection('Merchants')
        .where('merchantId', isEqualTo: box.read('merchant')['merchantId'])
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        setState(() {
          _correctPin = querySnapshot.docs.first['pin'].toString();
          hasLoaded = true;
        });
      }
    });
  }

  String _pin = '';
  final int _pinLength = 6;
  String _correctPin = ''; // Correct PIN

  void _addNumber(String number) {
    if (_pin.length < _pinLength) {
      setState(() {
        _pin += number;
        if (_pin.length == _pinLength) {
          _validatePin();
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

  void _validatePin() {
    if (_pin == _correctPin) {
      // Correct PIN, navigate back with result
      Get.back(result: _pin);
    } else {
      // Incorrect PIN, show error dialog and clear input
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Invalid PIN',
        text: 'The PIN you entered is incorrect. Please try again.',
        confirmBtnColor: bayanihanBlue,
        confirmBtnTextStyle: const TextStyle(
          fontFamily: 'Medium',
          color: Colors.white,
        ),
      );
      setState(() {
        _pin = ''; // Clear the PIN input
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false, // Disable Android back button
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Center(
          child: hasLoaded
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Greeting with Date/Time
                    TextWidget(
                      text: "Enter your account's PIN number",
                      fontSize: 16,
                      color: Colors.black,
                      align: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    // PIN Display
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        _pinLength,
                        (index) => Container(
                          margin: const EdgeInsets.all(8),
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            color: index < _pin.length
                                ? bayanihanBlue
                                : Colors.grey,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
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
                )
              : LoadingIndicatorWidget(),
        ),
      ),
    );
  }

  Widget _buildKeypadRow(List<String> numbers) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: numbers.map((number) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
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
