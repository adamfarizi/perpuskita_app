import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(page3());
}

class page3 extends StatelessWidget {
  const page3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: 500,
        child: Column(
          children: [
            const SizedBox(height: 230,),
            Image.asset('asset/img/alert.png', width: 200,),
            const SizedBox(height: 20,),
            Container(
              width: 300,
              child: const Text("Maaf, halaman ini belum tersedia :(", 
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: Color(0xFF494CA2),
                ),
              ),
            )
          ],
        ),
      ),
      );
  }
}