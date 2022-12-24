import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(page3());
}

class page3 extends StatelessWidget {
  const page3({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text("INI ADALAH FITUR PAGE 3"),
      ),
    );
  }
}