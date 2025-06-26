import 'package:customer_loyalty/utils/colors.dart';
import 'package:customer_loyalty/widgets/drawer_widget.dart';
import 'package:customer_loyalty/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

  final List<Map<String, dynamic>> _transactions = [
    {
      'id': '#235532235532',
      'date': '2024-10-20',
      'points': 120.22,
      'type': 'Earned',
      'items': 'Espresso x2',
      'cashier': 'John',
    },
    {
      'id': '#235532235533',
      'date': '2024-10-20',
      'points': 60.75,
      'type': 'Earned',
      'items': 'Latte x1',
      'cashier': 'Jane',
    },
    {
      'id': '#235532235534',
      'date': '2024-10-20',
      'points': -680.0,
      'type': 'Redeemed',
      'items': 'Free Cappuccino',
      'cashier': 'Alex',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _selectDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
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
                      color: bayanihanBlue,
                      isBold: true,
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search by Transaction ID',
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
                        prefixIcon:
                            Icon(Icons.search, color: bayanihanBlue, size: 20),
                        suffixIcon: IconButton(
                          icon:
                              Icon(Icons.clear, color: bayanihanBlue, size: 20),
                          onPressed: () {
                            _searchController.clear();
                            setState(() {});
                          },
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 10),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      style: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'Regular',
                        color: Colors.black87,
                      ),
                      onChanged: (value) {
                        setState(() {});
                      },
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
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Card(
              elevation: 4,
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
                          text: 'Earned',
                          fontSize: 14,
                          fontFamily: 'Medium',
                          color: Colors.grey[800],
                        ),
                        TextWidget(
                          text: '+180.97 pts',
                          fontSize: 16,
                          fontFamily: 'Bold',
                          color: Colors.green[600],
                          isBold: true,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          text: 'Redeemed',
                          fontSize: 14,
                          fontFamily: 'Medium',
                          color: Colors.grey[800],
                        ),
                        TextWidget(
                          text: '-680.00 pts',
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
          ),
          // Transactions
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.builder(
                itemCount: _transactions.length,
                itemBuilder: (context, index) {
                  final transaction = _transactions[index];
                  final transactionDate = DateTime.parse(transaction['date']);
                  if (_searchController.text.isNotEmpty &&
                      !transaction['id']
                          .toString()
                          .toLowerCase()
                          .contains(_searchController.text.toLowerCase())) {
                    return const SizedBox.shrink();
                  }
                  if (_filterType != 'All' &&
                      transaction['type'] != _filterType) {
                    return const SizedBox.shrink();
                  }
                  if (_selectedDateRange != null &&
                      (transactionDate.isBefore(_selectedDateRange!.start) ||
                          transactionDate.isAfter(_selectedDateRange!.end))) {
                    return const SizedBox.shrink();
                  }
                  return _buildTransactionItem(transaction);
                },
              ),
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white,
              bayanihanBlue.withOpacity(0.05),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: bayanihanBlue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  transaction['type'] == 'Earned'
                      ? FontAwesomeIcons.gift
                      : FontAwesomeIcons.ticket,
                  color: bayanihanBlue,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      text: transaction['id'],
                      fontSize: 16,
                      fontFamily: 'Bold',
                      color: Colors.black87,
                      isBold: true,
                    ),
                    TextWidget(
                      text: DateFormat('MMM d, yyyy, h:mm a')
                          .format(DateTime.parse(transaction['date'])),
                      fontSize: 12,
                      fontFamily: 'Regular',
                      color: Colors.grey[600],
                    ),
                    TextWidget(
                      text: 'Items: ${transaction['items']}',
                      fontSize: 12,
                      fontFamily: 'Regular',
                      color: Colors.grey[600],
                    ),
                    TextWidget(
                      text: 'Cashier: ${transaction['cashier']}',
                      fontSize: 12,
                      fontFamily: 'Regular',
                      color: Colors.grey[600],
                    ),
                  ],
                ),
              ),
              TextWidget(
                text: transaction['points'] > 0
                    ? '+${transaction['points']} pts'
                    : '${transaction['points']} pts',
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
