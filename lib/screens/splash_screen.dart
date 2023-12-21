import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutterdoo/screens/home_screen.dart';
import 'package:flutterdoo/screens/login_screen.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/colors.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.Black,
      body: Center(
        child: Text(
          "FlutterDoo",
          style: GoogleFonts.lato(
            fontWeight: FontWeight.bold,
            fontSize: 32,
            color: AppColors.jade
          ),
        ),
      ),
    );
  }
}
