import 'package:customer_loyalty/utils/colors.dart';
import 'package:customer_loyalty/widgets/drawer_widget.dart';
import 'package:customer_loyalty/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class BannersScreen extends StatefulWidget {
  const BannersScreen({super.key});

  @override
  _BannersScreenState createState() => _BannersScreenState();
}

class _BannersScreenState extends State<BannersScreen> {
  final List<File> _banners = []; // List to store banner images
  final ImagePicker _picker = ImagePicker();

  Future<void> _addBanner() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null && mounted) {
      setState(() {
        _banners.add(File(pickedFile.path));
      });
    }
  }

  void _removeBanner(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: Colors.white,
        title: TextWidget(
          text: 'Confirm Deletion',
          fontSize: 18,
          fontFamily: 'Bold',
          color: bayanihanBlue,
          isBold: true,
        ),
        content: TextWidget(
          text: 'Are you sure you want to remove this banner?',
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
            onPressed: () {
              if (mounted) {
                setState(() {
                  _banners.removeAt(index);
                });
              }
              Navigator.pop(context);
              _showSnackBar('Banner removed successfully!', bayanihanBlue);
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

  void _saveChanges() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: Colors.white,
        title: TextWidget(
          text: 'Confirm Changes',
          fontSize: 18,
          fontFamily: 'Bold',
          color: bayanihanBlue,
          isBold: true,
        ),
        content: TextWidget(
          text: 'Are you sure you want to save banner changes?',
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
            onPressed: () {
              Navigator.pop(context);
              // Placeholder for saving banners (e.g., upload to server)
              print(
                  'Banners saved: ${_banners.map((file) => file.path).toList()}');
              _showSnackBar('Banners saved successfully!', bayanihanBlue);
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

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: TextWidget(
          text: message,
          fontSize: 14,
          fontFamily: 'Regular',
          color: Colors.white,
        ),
        backgroundColor: color,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        backgroundColor: bayanihanBlue,
        foregroundColor: Colors.white,
        title: TextWidget(
          text: 'Banners',
          fontSize: 20,
          fontFamily: 'Bold',
          color: Colors.white,
          isBold: true,
        ),
        centerTitle: true,
        elevation: 4,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  backgroundColor: Colors.white,
                  title: TextWidget(
                    text: 'About Banners',
                    fontSize: 18,
                    fontFamily: 'Bold',
                    color: bayanihanBlue,
                    isBold: true,
                  ),
                  content: TextWidget(
                    maxLines: 50,
                    text:
                        'Banners uploaded here will be displayed in the user\'s application to showcase promotions, events, or other important announcements.',
                    fontSize: 16,
                    fontFamily: 'Regular',
                    color: Colors.black87,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: TextWidget(
                        text: 'Close',
                        fontSize: 14,
                        fontFamily: 'Medium',
                        color: bayanihanBlue,
                      ),
                    ),
                  ],
                ),
              );
            },
            icon: Icon(
              Icons.info_outline,
            ),
          ),
        ],
      ),
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Add Banner Button
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
                    TextWidget(
                      text: 'Add New Banner',
                      fontSize: 16,
                      fontFamily: 'Bold',
                      color: bayanihanBlue,
                      isBold: true,
                    ),
                    ElevatedButton(
                      onPressed: _addBanner,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: bayanihanBlue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                      ),
                      child: TextWidget(
                        text: 'Upload Image',
                        fontSize: 14,
                        fontFamily: 'Medium',
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Banners Grid
            TextWidget(
              text: 'Current Banners',
              fontSize: 16,
              fontFamily: 'Bold',
              color: Colors.black,
              isBold: true,
            ),
            const SizedBox(height: 8),
            Expanded(
              child: _banners.isEmpty
                  ? Center(
                      child: TextWidget(
                        text: 'No banners uploaded',
                        fontSize: 16,
                        fontFamily: 'Regular',
                        color: Colors.grey[600],
                      ),
                    )
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 1,
                      ),
                      itemCount: _banners.length,
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            Card(
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              color: Colors.white,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.file(
                                  _banners[index],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: GestureDetector(
                                onTap: () => _removeBanner(index),
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Colors.red[600],
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    FontAwesomeIcons.trash,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
            ),
            const SizedBox(height: 20),
            // Save Changes Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _banners.isEmpty ? null : _saveChanges,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      _banners.isEmpty ? Colors.grey[800] : bayanihanBlue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  elevation: 2,
                  shadowColor: bayanihanBlue.withOpacity(0.3),
                ),
                child: TextWidget(
                  text: 'Save Changes',
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
    );
  }
}
