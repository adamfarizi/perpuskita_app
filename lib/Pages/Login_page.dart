import 'package:flutter/material.dart';
import 'package:perpuskita_app/Pages/Home_page.dart';

void main() {
  runApp(MaterialApp(
      title: 'PERPUS AJA',
      home: Login(),
      routes: <String, WidgetBuilder>{
        '/Login': (BuildContext context) => Login(),
        '/Home' : (BuildContext context) => const Home(),
      }));
}

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Column(
        children:<Widget> [
          const SizedBox(height: 120),
          Center(
            child: Image.asset('asset/img/book.png', width: 300,),
          ),
          const SizedBox(height: 30),
          Row(
            children:const <Widget> [
              SizedBox(width: 50,),
              Text('Welcome', style: TextStyle(
                color: Color(0xFF494CA2),
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),)
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children:const <Widget> [
              SizedBox(width: 50,),
              Text('Increase your knowledge', style: TextStyle(
                color: Color(0xFF494CA2),
                fontSize: 20,
              ),)
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children:const <Widget>[
              SizedBox(width: 50,),
              Text('with read a book', style: TextStyle(
                color: Color(0xFF494CA2),
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),)
            ],
          ),
          const SizedBox(height: 35),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/Home');
            },
            child:Container(
            height: 50,
            width: 320,
            padding: const EdgeInsets.all(15),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Color(0xFF494CA2),
            ),
            child: const Center(
              child: Text(' Log In ', style: TextStyle(
                color: Colors.white,
                fontSize: 17
              ),),
            )
          ),
          ),
          
          const SizedBox(height: 15),
          Container(
            height: 50,
            width: 320,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              color: Colors.white,
              border: Border.all(color: Color(0xFF494CA2), width: 1.5),
            ),
            child: const Center(
              child: Text(' Create an account ', style: TextStyle(
                color: Color(0xFF494CA2),
                fontSize: 17
              ),),
            )
          )
        ],
      )
    );
  }
}