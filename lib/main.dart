import 'package:customer_loyalty/firebase_options.dart';
import 'package:customer_loyalty/screens/home_screen.dart';
import 'package:customer_loyalty/screens/splash.login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'customer-loyalty-5e404',
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await GetStorage.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final box = GetStorage();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: box.read('merchant') != null ? HomeScreen() : const SplashScreen(),
    );
  }
}
