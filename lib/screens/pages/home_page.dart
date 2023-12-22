import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/6,
              decoration: BoxDecoration(
                color: Colors.greenAccent,
                borderRadius: BorderRadius.circular(10)
              ),
              child: Stack(
                children: [
                  Positioned(
                      top: 20,
                      left: 20,
                      child: Text("Hello User ✌",
                      maxLines: 2,
                      style: GoogleFonts.lato(
                        fontSize: 24
                      ),
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
