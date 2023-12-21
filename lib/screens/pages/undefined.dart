import 'package:flutter/material.dart';

class UnDefinedPage extends StatefulWidget {
  const UnDefinedPage({super.key});

  @override
  State<UnDefinedPage> createState() => _UnDefinedPageState();
}

class _UnDefinedPageState extends State<UnDefinedPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Undefined"),
    );
  }
}
