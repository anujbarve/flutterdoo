import 'package:flutter/material.dart';
import 'package:flutterdoo/constants/colors.dart';
import 'package:flutterdoo/screens/login_screen.dart';
import 'package:flutterdoo/services/firebase_service.dart';
import 'package:flutterdoo/widgets/appButton.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  FirebaseAuthService _authService = new FirebaseAuthService();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppButton(buttonText: "Log Out", func: () {
                _authService.signOut();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
              } , color: AppColors.jade),
            ),

          ],
      ),
    );
  }
}
