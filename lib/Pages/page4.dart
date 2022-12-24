import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(page4());
}

class page4 extends StatelessWidget {
  const page4({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text("INI ADALAH FITUR PAGE 4"),
      ),
    );
  }
}