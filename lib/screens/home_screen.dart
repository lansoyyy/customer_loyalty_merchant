import 'package:customer_loyalty/utils/colors.dart';
import 'package:customer_loyalty/widgets/text_widget.dart';
import 'package:customer_loyalty/widgets/touchable_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Color(0xFF1C2526), // Dark background mimicking screenshot
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Greeting

              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextWidget(
                    text: 'Dashboard',
                    fontSize: 28,
                    color: Colors.white,
                    fontFamily: 'Bold',
                  ),
                  CircleAvatar(
                    minRadius: 20,
                    maxRadius: 20,
                    backgroundColor: Colors.white,
                    child: Icon(
                      FontAwesomeIcons.user,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Points Display
              Container(
                width: double.infinity,
                height: 150,
                padding: EdgeInsets.all(25.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF0033A0),
                      Color.fromARGB(255, 26, 64, 177)
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [],
                ),
              ),
              SizedBox(height: 10),
              // Points Display
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 175,
                    height: 150,
                    padding: EdgeInsets.all(25.0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF0033A0),
                          Color.fromARGB(255, 26, 64, 177)
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [],
                    ),
                  ),
                  Container(
                    width: 175,
                    height: 150,
                    padding: EdgeInsets.all(25.0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF0033A0),
                          Color.fromARGB(255, 26, 64, 177)
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Transaction History
              TextWidget(
                text: 'History',
                fontSize: 20,
                color: Colors.white,
                isBold: true,
              ),
              SizedBox(height: 10),
              Expanded(
                child: ListView(
                  children: [
                    _buildTransactionItem('Caramel Macchiato',
                        'Oct 20, 10:00 am', '+120.22 pts', Colors.green),
                    _buildTransactionItem('Chocolate Burst', 'Oct 20, 10:05 am',
                        '+60.75 pts', Colors.green),
                    _buildTransactionItem('Stawberry Tea', 'Oct 20, 10:10 am',
                        '-680 pts', Colors.red),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionItem(
      String title, String date, String amount, Color color) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Color(0xFF2C3E50),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              FontAwesomeIcons.gift,
              color: Colors.white70,
              size: 20,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  text: title,
                  fontSize: 16,
                  color: Colors.white,
                ),
                TextWidget(
                  text: date,
                  fontSize: 12,
                  color: Colors.white70,
                ),
              ],
            ),
          ),
          TextWidget(
            text: amount,
            fontSize: 16,
            color: color,
            isBold: true,
          ),
        ],
      ),
    );
  }
}
