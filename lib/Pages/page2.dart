import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(page2());
}

class page2 extends StatelessWidget {
  const page2({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text("INI ADALAH FITUR PAGE 2"),
      ),
    );
  }
}