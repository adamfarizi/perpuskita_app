import 'package:flutter/material.dart';
import 'package:indexed/indexed.dart';
import 'package:perpuskita_app/Pages/Login_page.dart';

void main(List<String> args) {
  runApp(MaterialApp(
      title: 'PERPUS KITA',
      home: const page4(),
      routes: <String, WidgetBuilder>{
        '/Logout': (BuildContext context) => const Login()
      }));
}

class page4 extends StatelessWidget {
  const page4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Indexer(
          children: [
            Indexed(
              child: Column(
                children: [
                  const SizedBox(
                    height: 230,
                  ),
                  Image.asset(
                    'asset/img/alert.png',
                    width: 200,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 300,
                    child: const Text(
                      "Maaf, halaman ini belum tersedia :(",
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
            )
          ],
        ),
      ),
    );
  }
}
