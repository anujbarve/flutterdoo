import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterdoo/providers/auth_provider.dart';
import 'package:flutterdoo/screens/home_screen.dart';
import 'package:flutterdoo/screens/login_screen.dart';
import 'package:flutterdoo/services/firebase_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';
import '../widgets/appButton.dart';
import '../widgets/textfield.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final FirebaseAuthService _authService = FirebaseAuthService();

  TextEditingController usernameController = new TextEditingController();
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
                        color: AppColors.Black
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
                      color: AppColors.Black
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                AppTextField("Username",usernameController,false,TextInputType.text),
                const SizedBox(
                  height: 10,
                ),
                AppTextField("Email", emailController,false,TextInputType.emailAddress),
                const SizedBox(
                  height: 10,
                ),
                AppTextField("Password", passwordController,true,TextInputType.text),
                const SizedBox(
                  height: 10,
                ),
                AppButton(buttonText: 'Register', func: () {
                  RegisterUser();
                }, color: AppColors.jade,),
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
                  color: AppColors.pigmentGreen,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void RegisterUser() async {
    String username = usernameController.text;
    String email = emailController.text;
    String password = passwordController.text;

    try{
      var user = await Provider.of<AuthenticationProvider>(context,listen: false).register(email: email, password: password);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
      showDialog(context: context, builder: (context) => _buildPopupDialog(context,"Registration Successful"));

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

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
}
