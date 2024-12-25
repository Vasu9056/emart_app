import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:mycart/auth_screen/login_screen.dart';
import 'package:mycart/views/splash_screen/splash_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'consts/consts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  GoogleSignIn googleSignIn = GoogleSignIn();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appname,
      theme: ThemeData(
         appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(
              // color: darkFontGrey,
              ),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
