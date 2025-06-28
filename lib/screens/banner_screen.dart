import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer_loyalty/utils/colors.dart';
import 'package:customer_loyalty/widgets/drawer_widget.dart';
import 'package:customer_loyalty/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class BannersScreen extends StatefulWidget {
  const BannersScreen({super.key});

  @override
  _BannersScreenState createState() => _BannersScreenState();
}

class _BannersScreenState extends State<BannersScreen> {
  final ImagePicker _picker = ImagePicker();
  final box = GetStorage();

  Future<void> _addBanner() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.camera);
      if (pickedFile == null || !mounted) {
        _showSnackBar('No image selected.', Colors.red[600]!);
        return;
      }

      // Get merchant ID
      final merchantId = box.read('merchant')['merchantId'];
      // Create a unique file name using timestamp
      final fileName =
          'banners/$merchantId/${DateTime.now().millisecondsSinceEpoch}.jpg';
      final file = File(pickedFile.path);

      // Upload to Firebase Storage
      final storageRef = FirebaseStorage.instance.ref().child(fileName);
      final uploadTask = await storageRef.putFile(file);
      final downloadUrl = await uploadTask.ref.getDownloadURL();

      // Update Firestore with the download URL
      await FirebaseFirestore.instance
          .collection('Merchants')
          .doc(box.read('merchant')['id'])
          .update({
        'banners': FieldValue.arrayUnion([downloadUrl])
      });

      if (mounted) {
        setState(() {});
        _showSnackBar('Banner uploaded successfully!', bayanihanBlue);
      }
    } catch (e) {
      if (mounted) {
        _showSnackBar('Error uploading banner: $e', Colors.red[600]!);
      }
    }
  }

  void _removeBanner(String banner) {
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
            onPressed: () async {
              if (mounted) {
                await FirebaseFirestore.instance
                    .collection('Merchants')
                    .doc(box.read('merchant')['id'])
                    .update({
                  'banners': FieldValue.arrayRemove([banner])
                });

                setState(() {});
              }
              Navigator.pop(context);
              _showSnackBar('Banner removed successfully!', Colors.red[600]!);
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
            icon: const Icon(Icons.info_outline),
          ),
        ],
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
                  merchant['banners'].isEmpty
                      ? Center(
                          child: TextWidget(
                            text: 'No banners uploaded',
                            fontSize: 16,
                            fontFamily: 'Regular',
                            color: Colors.grey[600],
                          ),
                        )
                      : Expanded(
                          child: ListView.builder(
                            itemCount: merchant['banners'].length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: double.infinity,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    image: DecorationImage(
                                        image: NetworkImage(
                                          merchant['banners'][index],
                                        ),
                                        fit: BoxFit.cover),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: IconButton(
                                        onPressed: () {
                                          _removeBanner(
                                              merchant['banners'][index]);
                                        },
                                        icon: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: const Icon(
                                              FontAwesomeIcons.trash,
                                              color: Colors.white,
                                              size: 18,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          }),
    );
  }
}
