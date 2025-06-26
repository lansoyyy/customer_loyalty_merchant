import 'package:customer_loyalty/utils/colors.dart';
import 'package:customer_loyalty/widgets/drawer_widget.dart';
import 'package:customer_loyalty/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController _percentageController =
      TextEditingController(text: '5.0');
  final TextEditingController _nameController =
      TextEditingController(text: 'Kaffi Cafe');
  final TextEditingController _pinController = TextEditingController();
  final TextEditingController _emailController =
      TextEditingController(text: 'contact@kafficafe.com');
  final TextEditingController _contactController =
      TextEditingController(text: '+639639520422');
  final TextEditingController _descriptionController =
      TextEditingController(text: 'Your friendly coffee shop');
  final TextEditingController _longDescriptionController = TextEditingController(
      text:
          'Kaffi Cafe offers a cozy ambiance with premium coffee and pastries, dedicated to customer satisfaction.');
  File? _logoImage;

  @override
  void dispose() {
    _percentageController.dispose();
    _nameController.dispose();
    _pinController.dispose();
    _emailController.dispose();
    _contactController.dispose();
    _descriptionController.dispose();
    _longDescriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickLogoImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null && mounted) {
      setState(() {
        _logoImage = File(pickedFile.path);
      });
    }
  }

  void _handleSave() {
    // Validate inputs
    final percentageText = _percentageController.text;
    if (percentageText.isEmpty ||
        double.tryParse(percentageText) == null ||
        double.parse(percentageText) < 0) {
      _showSnackBar('Please enter a valid percentage', Colors.red[600]!);
      return;
    }
    if (_nameController.text.isEmpty) {
      _showSnackBar('Please enter a valid name', Colors.red[600]!);
      return;
    }
    if (_pinController.text.isNotEmpty &&
        (_pinController.text.length != 6 ||
            int.tryParse(_pinController.text) == null)) {
      _showSnackBar('PIN must be a 6-digit number', Colors.red[600]!);
      return;
    }
    if (_emailController.text.isNotEmpty &&
        !_emailController.text.contains('@')) {
      _showSnackBar('Please enter a valid email', Colors.red[600]!);
      return;
    }
    if (_contactController.text.isEmpty) {
      _showSnackBar('Please enter a valid contact number', Colors.red[600]!);
      return;
    }
    if (_descriptionController.text.isEmpty) {
      _showSnackBar('Please enter a description', Colors.red[600]!);
      return;
    }

    // Show confirmation dialog
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
          text: 'Are you sure you want to save these settings?',
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
              // Save settings (placeholder action)
              print('Percentage: $percentageText%');
              print('Name: ${_nameController.text}');
              print(
                  'PIN: ${_pinController.text.isEmpty ? "No change" : _pinController.text}');
              print('Email: ${_emailController.text}');
              print('Contact: ${_contactController.text}');
              print('Description: ${_descriptionController.text}');
              print('Long Description: ${_longDescriptionController.text}');
              print('Logo: ${_logoImage?.path ?? "No logo selected"}');
              _showSnackBar('Settings saved successfully!', bayanihanBlue);
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
          text: 'Settings',
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
                    text: 'About Settings',
                    fontSize: 18,
                    fontFamily: 'Bold',
                    color: bayanihanBlue,
                    isBold: true,
                  ),
                  content: TextWidget(
                    text:
                        'Settings allow you to configure the points percentage per transaction, update your business logo, name, PIN, and other details. These changes will be reflected in the user\'s application.',
                    fontSize: 16,
                    fontFamily: 'Regular',
                    color: Colors.black87,
                    maxLines: 50,
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Configure % per Transaction
            TextWidget(
              text: 'Points Percentage per Transaction',
              fontSize: 16,
              fontFamily: 'Bold',
              color: Colors.black,
              isBold: true,
            ),
            const SizedBox(height: 8),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _percentageController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Enter percentage (e.g., 5.0)',
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
                      ),
                    ),
                    const SizedBox(width: 8),
                    TextWidget(
                      text: '%',
                      fontSize: 16,
                      fontFamily: 'Medium',
                      color: bayanihanBlue,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Update Logo
            TextWidget(
              text: 'Update Logo',
              fontSize: 16,
              fontFamily: 'Bold',
              color: Colors.black,
              isBold: true,
            ),
            const SizedBox(height: 8),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                        border:
                            Border.all(color: bayanihanBlue.withOpacity(0.3)),
                      ),
                      child: _logoImage == null
                          ? Center(
                              child: Icon(
                                FontAwesomeIcons.image,
                                color: Colors.grey[600],
                                size: 40,
                              ),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                _logoImage!,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _pickLogoImage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: bayanihanBlue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: TextWidget(
                          text: 'Select Logo',
                          fontSize: 14,
                          fontFamily: 'Medium',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Update Name
            TextWidget(
              text: 'Update Name',
              fontSize: 16,
              fontFamily: 'Bold',
              color: Colors.black,
              isBold: true,
            ),
            const SizedBox(height: 8),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: 'Enter business name',
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
                      borderSide: BorderSide(color: bayanihanBlue, width: 2),
                    ),
                    prefixIcon:
                        Icon(Icons.business, color: bayanihanBlue, size: 20),
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
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Change PIN
            TextWidget(
              text: 'Change PIN',
              fontSize: 16,
              fontFamily: 'Bold',
              color: Colors.black,
              isBold: true,
            ),
            const SizedBox(height: 8),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  controller: _pinController,
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  maxLength: 6,
                  decoration: InputDecoration(
                    hintText: 'Enter 6-digit PIN',
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
                      borderSide: BorderSide(color: bayanihanBlue, width: 2),
                    ),
                    prefixIcon:
                        Icon(Icons.lock, color: bayanihanBlue, size: 20),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                    fillColor: Colors.white,
                    filled: true,
                    counterText: '',
                  ),
                  style: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'Regular',
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Edit Details
            TextWidget(
              text: 'Edit Details',
              fontSize: 16,
              fontFamily: 'Bold',
              color: Colors.black,
              isBold: true,
            ),
            const SizedBox(height: 8),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        hintText: 'Enter short description (e.g., tagline)',
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
                        prefixIcon: Icon(Icons.description,
                            color: bayanihanBlue, size: 20),
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
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _longDescriptionController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText:
                            'Enter long description (e.g., business details)',
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
                            Icon(Icons.notes, color: bayanihanBlue, size: 20),
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
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'Enter email address',
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
                            Icon(Icons.email, color: bayanihanBlue, size: 20),
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
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _contactController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: 'Enter contact number',
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
                            Icon(Icons.phone, color: bayanihanBlue, size: 20),
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
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Save Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _handleSave,
                style: ElevatedButton.styleFrom(
                  backgroundColor: bayanihanBlue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  elevation: 2,
                  shadowColor: bayanihanBlue.withOpacity(0.3),
                ),
                child: TextWidget(
                  text: 'Save Settings',
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
