import 'package:customer_loyalty/utils/colors.dart';
import 'package:customer_loyalty/widgets/drawer_widget.dart';
import 'package:customer_loyalty/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: _buildAppBar(),
      backgroundColor: backgroundColor,
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: bayanihanBlue,
      foregroundColor: Colors.white,
      title: TextWidget(
        text: 'History',
        fontSize: 20,
        color: Colors.white,
        fontFamily: 'Bold',
      ),
      centerTitle: true,
      elevation: 4,
    );
  }
}
