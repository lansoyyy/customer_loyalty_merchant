import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer_loyalty/utils/colors.dart';
import 'package:customer_loyalty/utils/const.dart';
import 'package:customer_loyalty/widgets/drawer_widget.dart';
import 'package:customer_loyalty/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  String _filterType = 'All';
  final TextEditingController _searchController = TextEditingController();
  DateTimeRange? _selectedDateRange;

  final box = GetStorage();
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _selectDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(2050),
      initialDateRange: _selectedDateRange,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: bayanihanBlue,
              onPrimary: Colors.white,
              surface: Colors.white,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );
    if (picked != null && mounted) {
      setState(() {
        _selectedDateRange = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: _buildAppBar(),
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          const SizedBox(height: 20),
          // Filters
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              color: Colors.white,
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      text: 'Filter Transactions',
                      fontSize: 18,
                      fontFamily: 'Bold',
                      color: Colors.black,
                      isBold: true,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextWidget(
                          text: 'Date Range',
                          fontSize: 14,
                          fontFamily: 'Medium',
                          color: Colors.grey[800],
                        ),
                        TextButton(
                          onPressed: () => _selectDateRange(context),
                          child: TextWidget(
                            text: _selectedDateRange == null
                                ? 'Select Dates'
                                : '${DateFormat('MMM d').format(_selectedDateRange!.start)} - ${DateFormat('MMM d').format(_selectedDateRange!.end)}',
                            fontSize: 14,
                            fontFamily: 'Medium',
                            color: bayanihanBlue,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: ['All', 'Earned', 'Redeemed'].map((type) {
                        return ChoiceChip(
                          showCheckmark: false,
                          label: TextWidget(
                            text: type,
                            fontSize: 14,
                            fontFamily: 'Medium',
                            color: _filterType == type
                                ? Colors.white
                                : bayanihanBlue,
                          ),
                          selected: _filterType == type,
                          onSelected: (selected) {
                            setState(() {
                              _filterType = type;
                            });
                          },
                          selectedColor: bayanihanBlue,
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                                color: bayanihanBlue.withOpacity(0.3)),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          elevation: 2,
                          pressElevation: 4,
                          shadowColor: bayanihanBlue.withOpacity(0.3),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Summary
          FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance
                  .collection('History')
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

                final merchant = snapshot.data!.docs.map((doc) {
                  final data = doc.data() as Map<String, dynamic>;
                  data['id'] = doc.id; // Include document ID
                  return data;
                }).toList();

                double earned = 0;
                double redeemed = 0;

                for (int i = 0; i < merchant.length; i++) {
                  if (merchant[i]['type'] == 'Earned') {
                    earned += merchant[i]['points'];
                  } else {
                    redeemed += merchant[i]['points'];
                  }
                }
                return Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                  child: Card(
                    elevation: 4,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(
                                text: 'Total Earned',
                                fontSize: 14,
                                fontFamily: 'Medium',
                                color: Colors.grey[800],
                              ),
                              TextWidget(
                                text: '+ ${formatNumber(earned)} pts',
                                fontSize: 16,
                                fontFamily: 'Bold',
                                color: Colors.green[600],
                                isBold: true,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              TextWidget(
                                text: 'Total Redeemed',
                                fontSize: 14,
                                fontFamily: 'Medium',
                                color: Colors.grey[800],
                              ),
                              TextWidget(
                                text: '- ${formatNumber(redeemed)} pts',
                                fontSize: 16,
                                fontFamily: 'Bold',
                                color: Colors.red[600],
                                isBold: true,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
          // Transactions
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: FutureBuilder<QuerySnapshot>(
                  future: FirebaseFirestore.instance
                      .collection('History')
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

                    final merchant = snapshot.data!.docs.map((doc) {
                      final data = doc.data() as Map<String, dynamic>;
                      data['id'] = doc.id; // Include document ID
                      return data;
                    }).toList();
                    return ListView.builder(
                      itemCount: merchant.length,
                      itemBuilder: (context, index) {
                        final transaction = merchant[index];

                        if (_filterType != 'All' &&
                            transaction['type'] != _filterType) {
                          return const SizedBox.shrink();
                        }
                        if (_selectedDateRange != null &&
                            (transaction['dateTime']
                                    .toDate()
                                    .isBefore(_selectedDateRange!.start) ||
                                transaction['dateTime']
                                    .toDate()
                                    .isAfter(_selectedDateRange!.end))) {
                          return const SizedBox.shrink();
                        }
                        return _buildTransactionItem(transaction);
                      },
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(Map<String, dynamic> transaction) {
    final color =
        transaction['type'] == 'Earned' ? Colors.green[600]! : Colors.red[600]!;
    return Card(
      elevation: 3,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: bayanihanBlue,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  transaction['type'] == 'Earned'
                      ? FontAwesomeIcons.gift
                      : FontAwesomeIcons.ticket,
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
                      text: transaction['userId'],
                      fontSize: 16,
                      fontFamily: 'Bold',
                      color: Colors.black87,
                      isBold: true,
                    ),
                    TextWidget(
                      text: transaction['dateFormatted'],
                      fontSize: 12,
                      fontFamily: 'Regular',
                      color: Colors.grey[600],
                    ),
                  ],
                ),
              ),
              TextWidget(
                text:
                    '${transaction['type'] == 'Earned' ? '+' : '-'} ${formatNumber(transaction['points'])} pts',
                fontSize: 16,
                fontFamily: 'Bold',
                color: color,
                isBold: true,
              ),
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
        text: 'History',
        fontSize: 20,
        fontFamily: 'Bold',
        color: Colors.white,
        isBold: true,
      ),
      centerTitle: true,
      elevation: 4,
    );
  }
}
