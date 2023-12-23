import 'package:firebase_auth/firebase_auth.dart';
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
  var user = FirebaseAuth.instance.currentUser!.email;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.greenAccent,
                borderRadius: BorderRadius.circular(100)
              ),
              height: 200,
              width: 200,
              child: Icon(Icons.account_circle_rounded,size: 100,color: AppColors.jade,),
            ),
            SizedBox(height: 20,),
            Text("Logged In as $user"),
            SizedBox(height: 20,),
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
