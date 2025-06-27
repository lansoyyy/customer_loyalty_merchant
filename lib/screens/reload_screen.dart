import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer_loyalty/utils/colors.dart';
import 'package:customer_loyalty/widgets/drawer_widget.dart';
import 'package:customer_loyalty/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_storage/get_storage.dart';

class ReloadScreen extends StatefulWidget {
  const ReloadScreen({super.key});

  @override
  _ReloadScreenState createState() => _ReloadScreenState();
}

class _ReloadScreenState extends State<ReloadScreen> {
  final TextEditingController _amountController = TextEditingController();
  final double _currentBalance = 1234.50; // Example balance

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _handleContinue() {
    final amountText = _amountController.text;
    if (amountText.isEmpty ||
        double.tryParse(amountText) == null ||
        double.parse(amountText) <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: TextWidget(
            text: 'Please enter a valid amount',
            fontSize: 14,
            fontFamily: 'Regular',
            color: Colors.white,
          ),
          backgroundColor: Colors.red[600],
        ),
      );
      return;
    }

    // Show confirmation dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: Colors.white,
        title: TextWidget(
          text: 'Confirm Reload',
          fontSize: 18,
          fontFamily: 'Bold',
          color: bayanihanBlue,
          isBold: true,
        ),
        content: TextWidget(
          text: 'Are you sure you want to reload ${amountText} points?',
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
            onPressed: () async {
              Navigator.pop(context);
              // Process reload

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: TextWidget(
                    text: 'Reload of $amountText pts successful!',
                    fontSize: 14,
                    fontFamily: 'Regular',
                    color: Colors.white,
                  ),
                  backgroundColor: bayanihanBlue,
                ),
              );

              await FirebaseFirestore.instance
                  .collection('Merchants')
                  .doc(box.read('merchant')['id'])
                  .update({
                'points': FieldValue.increment(double.parse(amountText))
              });

              setState(() {
                _amountController.clear();
              });
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

  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        backgroundColor: bayanihanBlue,
        foregroundColor: Colors.white,
        title: TextWidget(
          text: 'Reload Points',
          fontSize: 20,
          fontFamily: 'Bold',
          color: Colors.white,
          isBold: true,
        ),
        centerTitle: true,
        elevation: 4,
      ),
      backgroundColor: backgroundColor,
      body: FutureBuilder<QuerySnapshot>(
          future: FirebaseFirestore.instance
              .collection('Merchants')
              .where('merchantId',
                  isEqualTo: box.read('merchant')['merchantId'])
              .get(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: bayanihanBlue,
                ),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: TextWidget(
                  text: 'Error: ${snapshot.error}',
                  fontSize: 16,
                  fontFamily: 'Regular',
                  color: Colors.red[600],
                ),
              );
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(
                child: TextWidget(
                  text: 'Loading...',
                  fontSize: 16,
                  fontFamily: 'Regular',
                  color: Colors.grey[600],
                ),
              );
            }

            final merchant = snapshot.data!.docs
                .map((doc) {
                  final data = doc.data() as Map<String, dynamic>;
                  data['id'] = doc.id; // Include document ID
                  return data;
                })
                .toList()
                .first;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Points Balance
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
                                text: '${merchant['points']} pts',
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
                  // Input Amount
                  TextWidget(
                    text: 'Reload Amount',
                    fontSize: 18,
                    fontFamily: 'Bold',
                    color: Colors.black,
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
                            controller: _amountController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: 'Enter amount (e.g., 100.00)',
                              hintStyle: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Regular',
                                color: Colors.grey[600],
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: bayanihanBlue.withOpacity(0.3)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: bayanihanBlue.withOpacity(0.3)),
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
                              onPressed: _handleContinue,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: bayanihanBlue,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                                elevation: 2,
                                shadowColor: bayanihanBlue.withOpacity(0.3),
                              ),
                              child: TextWidget(
                                text: 'Continue',
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
            );
          }),
    );
  }
}
