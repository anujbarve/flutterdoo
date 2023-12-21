import 'package:flutter/material.dart';

import '../constants/colors.dart';

class AppButton extends StatelessWidget {

  final String buttonText;
  final VoidCallback func;
  final Color color;

  const AppButton({super.key, required this.buttonText, required this.func, required this.color});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: func,
      child: Container(
        alignment: Alignment.center,
        height: 50,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10
            )
          ]
        ),
        child: Text(
          buttonText,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
