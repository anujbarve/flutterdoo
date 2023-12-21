import 'package:flutter/material.dart';
import 'package:flutterdoo/screens/register_screen.dart';
import 'package:flutterdoo/widgets/appButton.dart';
import 'package:flutterdoo/widgets/textfield.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

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
                        color: AppColors.bg2Color),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Text(
                  "Login to your Account",
                  style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppColors.bgColor),
                ),
                const SizedBox(
                  height: 30,
                ),
                AppTextField("Email", emailController, false,
                    TextInputType.emailAddress),
                const SizedBox(
                  height: 10,
                ),
                AppTextField(
                    "Password", passwordController, true, TextInputType.text),
                const SizedBox(
                  height: 10,
                ),
                AppButton(
                  color: AppColors.bg2Color,
                  buttonText: 'Sign In',
                  func: () {},
                ),
                const SizedBox(
                  height: 10,
                ),
                Divider(),
                const SizedBox(
                  height: 10,
                ),
                AppButton(
                  buttonText: "Don't Have an Account Register Now",
                  func: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RegisterScreen()));
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
