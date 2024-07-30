import 'package:edyon/Reset_pwd.dart';
import 'package:edyon/register_adress.dart';
import 'package:edyon/register_mobile.dart';
import 'package:edyon/registration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'splash2.dart';
import 'EducationDetails.dart';
import 'splash1.dart';
import 'otppage.dart';
import 'signin_page.dart';
import 'create_password.dart';
import 'Navbar.dart';
import 'Instructor.dart';
import 'Instructor_deatails.dart';
import 'Contact_us.dart';
import 'privacy_policy.dart';
import 'terms_page.dart';
import 'wallet.dart';
import 'my_profile _page.dart';
import 'notifications.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Setting the status bar color
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xFFFFCFEF), // Your color here
      statusBarBrightness: Brightness.dark, // For iOS (light or dark)
      statusBarIconBrightness: Brightness.dark, // For Android (light or dark)
    ));

    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),

        // home: MainPage(),
        debugShowCheckedModeBanner: false, // Remove the debug banner
        initialRoute: '/',
        routes: {
          '/': (context) => MainPage(),
          '/login': (context) => MainPage()
        });
  }
}
