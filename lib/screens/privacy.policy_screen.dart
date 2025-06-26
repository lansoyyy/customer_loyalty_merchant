import 'package:customer_loyalty/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:customer_loyalty/utils/colors.dart';
import 'package:customer_loyalty/widgets/text_widget.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      drawer: const DrawerWidget(),
      appBar: AppBar(
        backgroundColor: bayanihanBlue,
        foregroundColor: Colors.white,
        title: TextWidget(
          text: 'Privacy Policy',
          fontSize: 20,
          fontFamily: 'Bold',
          color: Colors.white,
          isBold: true,
        ),
        centerTitle: true,
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                text: 'Privacy Policy',
                fontSize: 32,
                color: Colors.white,
                fontFamily: 'Bold',
                isBold: true,
              ),
              TextWidget(
                text: 'Updated on June 21, 2025    |     8 min read',
                fontSize: 14,
                color: Colors.grey,
                fontFamily: 'Regular',
              ),
              SizedBox(height: 20),
              TextWidget(
                align: TextAlign.start,
                text: '''
1. Introduction
Welcome to the Customer Loyalty Program (Merchant App). We value your privacy and are committed to protecting your business and personal information. This Privacy Policy outlines how we collect, use, and protect your information through the use of our application.

2. Information We Collect
a. Business and Merchant Information
We may collect data you provide, such as:

- Business name
- Contact person name
- Email address
- Business address
- Store location

b. Technical and Usage Data
We also collect non-personal data, including:

- Device information (model, OS)
- App usage behavior
- Crash reports and analytics for improvement

3. How We Use Your Information
The data we collect is used to:

- Manage your merchant account
- Enable participation in the Customer Loyalty Program
- Monitor and improve app features and services
- Provide support and respond to inquiries
- Ensure secure and personalized merchant experiences

4. Sharing of Information
We do not sell or rent your data. Information may be shared with:

- Service providers for analytics and hosting
- Legal authorities if required by applicable laws
- Loyalty program administrators for account management

5. Data Security
We implement reasonable safeguards to protect your data. However, no method of transmission over the internet is entirely secure.

6. Third-Party Services
The app may contain links or integrations with third-party tools (e.g., analytics providers). We do not control their practices and recommend reviewing their individual privacy policies.

7. Data Retention
We retain your data only as long as necessary to fulfill the purposes outlined in this policy, or as required by law.

8. Your Rights
You have the right to:

- View the data we collect
- Request correction or deletion of your data
- Withdraw consent at any time

To exercise these rights, please contact us using the information provided below.

9. Children's Privacy
This application is not intended for use by individuals under the age of 18. We do not knowingly collect personal data from minors.

10. Updates to This Policy
We may revise this Privacy Policy periodically. Significant changes will be communicated via in-app notifications or updated on this screen, along with a new revision date.

11. Contact Us
For any questions or concerns, please contact:

Algo Vision  
Cagayan De Oro City, Misamis Oriental, Philippines  
Email: algovision123@gmail.com
                ''',
                fontSize: 16,
                maxLines: 200,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
