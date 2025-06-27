import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer_loyalty/screens/home_screen.dart';
import 'package:customer_loyalty/utils/colors.dart';
import 'package:customer_loyalty/widgets/button_widget.dart';
import 'package:customer_loyalty/widgets/show.snackbar_widget.dart';
import 'package:customer_loyalty/widgets/text_widget.dart';
import 'package:customer_loyalty/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MerchantLoginScreen extends StatefulWidget {
  const MerchantLoginScreen({super.key});

  @override
  _MerchantLoginScreenState createState() => _MerchantLoginScreenState();
}

class _MerchantLoginScreenState extends State<MerchantLoginScreen> {
  final _merchantIdController = TextEditingController();

  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  height: 200,
                  color: bayanihanBlue,
                ),
                // Greeting with Date/Time

                // Title

                SizedBox(height: 25),
                // Login Form
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: bayanihanBlue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextWidget(
                          text: 'Merchant Login',
                          fontSize: 24,
                          fontFamily: 'Bold',
                          color: Colors.white,
                          align: TextAlign.center,
                        ),
                        SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: TextFieldWidget(
                            isObscure: true,
                            showEye: true,
                            hintColor: Colors.white,
                            label: 'Merchant ID',
                            controller: _merchantIdController,
                          ),
                        ),
                        SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: ButtonWidget(
                            color: Colors.white,
                            textColor: bayanihanBlue,
                            label: 'Login',
                            onPressed: () async {
                              FirebaseFirestore.instance
                                  .collection('Merchants')
                                  .where('merchantId',
                                      isEqualTo: _merchantIdController.text)
                                  .get()
                                  .then((QuerySnapshot querySnapshot) {
                                if (querySnapshot.docs.isNotEmpty) {
                                  print(querySnapshot.docs.first.data());
                                  box.write('merchant',
                                      querySnapshot.docs.first.data());
                                  Get.off(HomeScreen(),
                                      transition: Transition.zoom);
                                } else {
                                  showSnackBar(
                                      context,
                                      'Merchant ID does not exist!',
                                      Colors.red);
                                }
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
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
}
