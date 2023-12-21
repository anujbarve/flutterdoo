import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatelessWidget {

  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType textInputType;


  const AppTextField(this.hintText, this.controller, this.obscureText, this.textInputType);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5
          )
        ]
      ),
      child: TextFormField(
        obscureText: obscureText,
        keyboardType: textInputType,
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(0),
          hintStyle: TextStyle(
            height: 1,
          )
        ),
      ),
    );
  }
}
