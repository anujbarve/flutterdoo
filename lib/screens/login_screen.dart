import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterdoo/screens/home_screen.dart';
import 'package:flutterdoo/screens/register_screen.dart';
import 'package:flutterdoo/services/firebase_service.dart';
import 'package:flutterdoo/widgets/appButton.dart';
import 'package:flutterdoo/widgets/textfield.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

import '../constants/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  FirebaseAuthService _authService = new FirebaseAuthService();

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
                        color: AppColors.Black),
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
                      color: AppColors.Black),
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
                  color: AppColors.jade,
                  buttonText: 'Sign In',
                  func: () {
                    LoginUser();
                  },
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
                  color: AppColors.pigmentGreen,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void LoginUser() async {
    String email = emailController.text;
    String password = passwordController.text;

    try{
      var user = await Provider.of<AuthenticationProvider>(context,listen: false).login(email: email, password: password);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
      showDialog(context: context, builder: (context) => _buildPopupDialog(context,"Login Successful"));

    }catch(e){
      if(e is FirebaseAuthException)
        {
          showDialog(context: context, builder: (context) => _buildPopupDialog(context,e.message!));
        }
      else
        {
          showDialog(context: context, builder: (context) => _buildPopupDialog(context,e.toString()));
        }

    }
  }

  Widget _buildPopupDialog(BuildContext context,String error) {
    return new AlertDialog(
      title: const Text('Notice'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(error),
        ],
      ),
      actions: <Widget>[
        new ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}
