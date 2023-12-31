import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterdoo/providers/task_provider.dart';
import 'package:flutterdoo/screens/home_screen.dart';
import 'package:flutterdoo/screens/login_screen.dart';
import 'package:flutterdoo/services/shared_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    checkLogin();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      init();
    });
    super.initState();
  }

  void init() async {
    var user = FirebaseAuth.instance.currentUser?.email;
    if(user!=null)
      {
        await Provider.of<TaskProvider>(context,listen: false).init(user!);
      }
  }

  void checkLogin() async {
    var isLoggedIn = SharedPreferenceService.isLogin;
    print(isLoggedIn);
    if (isLoggedIn != null) {
      if (isLoggedIn) {
        Timer(const Duration(seconds: 2), () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const HomeScreen()));
        });
      } else {
        Timer(const Duration(seconds: 2), () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const LoginScreen()));
        });
      }
    }else{
      Timer(const Duration(seconds: 2), () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text(
          "FlutterDoo",
          style: GoogleFonts.lato(
              fontWeight: FontWeight.bold, fontSize: 32, color: AppColors.jade),
        ),
      ),
    );
  }
}
