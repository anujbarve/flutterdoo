import 'package:flutter/material.dart';
import 'package:flutterdoo/screens/login_screen.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/colors.dart';
import '../widgets/appButton.dart';
import '../widgets/textfield.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 200,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "FlutterDoo",
                    style: GoogleFonts.lato(
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                        color: AppColors.bg2Color
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Text(
                  "Create your account",
                  style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppColors.bgColor
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                AppTextField("Email",emailController,false,TextInputType.emailAddress),
                const SizedBox(
                  height: 10,
                ),
                AppTextField("Password", passwordController,true,TextInputType.text),
                const SizedBox(
                  height: 10,
                ),
                AppTextField("Confirm Password", confirmPasswordController,true,TextInputType.text),
                const SizedBox(
                  height: 10,
                ),
                AppButton(buttonText: 'Register', func: () {  }, color: AppColors.bg2Color,),
                const SizedBox(
                  height: 10,
                ),
                Divider(),
                const SizedBox(
                  height: 10,
                ),
                AppButton(
                  buttonText: "Already have an account, Login Now",
                  func: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  color: AppColors.midColor,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
