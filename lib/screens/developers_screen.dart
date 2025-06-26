import 'package:customer_loyalty/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:customer_loyalty/utils/colors.dart';
import 'package:customer_loyalty/widgets/text_widget.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class DevelopersScreen extends StatelessWidget {
  const DevelopersScreen({super.key});

  // Team information
  static const String teamName = 'Algo Vision';
  static const String contactNumber = '+639639520422';
  static const String email = 'algovision123@gmail.com';
  static const String facebookPage = 'facebook.com/algovision';
  static const String location = 'Cagayan De Oro City, Misamis Oriental';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      drawer: const DrawerWidget(),
      appBar: AppBar(
        backgroundColor: bayanihanBlue,
        foregroundColor: Colors.white,
        title: TextWidget(
          text: 'Developers',
          fontSize: 20,
          fontFamily: 'Bold',
          color: Colors.white,
          isBold: true,
        ),
        centerTitle: true,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Logo Placeholder
            Center(
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.black26.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Image.asset(
                    'assets/images/avlogo.png',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Team Name Header
            Center(
              child: Column(
                children: [
                  TextWidget(
                    text: teamName,
                    fontSize: 28,
                    fontFamily: 'Bold',
                    color: bayanihanBlue,
                    isBold: true,
                  ),
                  const SizedBox(height: 8),
                  TextWidget(
                    text: 'The Team Behind Discover Philippines',
                    fontSize: 16,
                    fontFamily: 'Regular',
                    color: Colors.black,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            // About Section
            TextWidget(
              text:
                  'Algo Vision is a passionate team dedicated to creating innovative solutions for seamless user experiences. Based in Cagayan De Oro City, we strive to empower communities through technology.',
              fontSize: 14,
              fontFamily: 'Regular',
              color: Colors.black,
              align: TextAlign.center,
              maxLines: 50,
            ),
            const SizedBox(height: 20),
            // Contact Information Card
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: bayanihanBlue.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildContactItem(
                      context,
                      icon: FontAwesomeIcons.phone,
                      title: 'Contact Number',
                      value: contactNumber,
                      onTap: () {
                        Clipboard.setData(
                            const ClipboardData(text: contactNumber));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: TextWidget(
                                  text: 'Number copied!',
                                  fontSize: 14,
                                  color: Colors.white)),
                        );
                      },
                    ),
                    const Divider(height: 24),
                    _buildContactItem(
                      context,
                      icon: FontAwesomeIcons.envelope,
                      title: 'Email',
                      value: email,
                      onTap: () {
                        Clipboard.setData(const ClipboardData(text: email));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: TextWidget(
                                  text: 'Email copied!',
                                  fontSize: 14,
                                  color: Colors.white)),
                        );
                      },
                    ),
                    const Divider(height: 24),
                    _buildContactItem(
                      context,
                      icon: FontAwesomeIcons.facebook,
                      title: 'Facebook Page',
                      value: facebookPage,
                      onTap: () async {
                        final url = Uri.parse('https://$facebookPage');
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url,
                              mode: LaunchMode.externalApplication);
                        }
                      },
                    ),
                    const Divider(height: 24),
                    _buildContactItem(
                      context,
                      icon: FontAwesomeIcons.locationDot,
                      title: 'Location',
                      value: location,
                      onTap: () {
                        Clipboard.setData(const ClipboardData(text: location));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: TextWidget(
                                  text: 'Location copied!',
                                  fontSize: 14,
                                  color: Colors.white)),
                        );
                      },
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

  Widget _buildContactItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: bayanihanBlue.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: bayanihanBlue,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    text: title,
                    fontSize: 16,
                    fontFamily: 'Medium',
                    color: Colors.grey[800],
                  ),
                  TextWidget(
                    text: value,
                    fontSize: 14,
                    fontFamily: 'Regular',
                    color: Colors.grey[600],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
