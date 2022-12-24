import 'package:flutter/material.dart';
import 'package:indexed/indexed.dart';
import 'package:perpuskita_app/Pages/Home_page.dart';
import 'package:perpuskita_app/Pages/Boarding_page.dart';

void main() {
  runApp(MaterialApp(
    title: 'PERPUS KITA',
    home: const Login(),
    routes: <String, WidgetBuilder>{
      '/Boarding': (BuildContext context) => const Boarding(),
      '/Login': (BuildContext context) => const Login(),
      '/Home': (BuildContext context) => const Home(),
    },
  ));
}

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        body: Container(
          child: Indexer(
            children: [
              Indexed(
                  index: 1,
                  child: Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      height: 286,
                      width: 410,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('asset/img/bg1.png' ),
                            opacity: 100,
                            fit: BoxFit.contain),
                      ),
                    )
                  )),
              Indexed(
                  index: 2,
                  child: Positioned(
                    top: 200,
                    left: 0,
                    child: Container(
                      height: 700,
                      width: 410,
                      decoration: const BoxDecoration(
                          color: Color(0xFFFFFFFF),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25))),
                    ),
                  )),
              Indexed(
                index: 3,
                child: Positioned(
                  top: 150,
                  left: 150,
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      image: DecorationImage(
                        image: AssetImage('asset/img/P.png'),
                        fit: BoxFit.contain)
                    ),
                  )
                  )),
              Indexed(
                index: 4,
                child: Positioned(
                  top: 280,
                  left: 45,
                  child: Column(
                    children: <Widget> [
                      const Text('WELCOME BACK', style: TextStyle(
                        color: Color(0xFF33313B),
                        fontWeight: FontWeight.bold,
                        fontSize: 25
                      ),),
                      const SizedBox(height: 20,),
                      Row(
                        children: const [
                          Text('Email *', textAlign: TextAlign.left,),
                          SizedBox(width: 235,)
                        ],
                      ),
                      const SizedBox(
                        width: 320,
                        height: 80,
                        child: TextField(
                          decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(20),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          hintText: 'examplee@gmail.com'),
                        ),
                      ),
                      Row(
                        children: const [
                          Text('Password *', textAlign: TextAlign.left,),
                          SizedBox(width: 210,)
                        ],
                      ),
                      const SizedBox(
                        width: 320,
                        height: 80,
                        child: TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(20),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          hintText: 'yout password'),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/Home');
                        },
                        child:Container(
                        height: 50,
                        width: 320,
                        padding: const EdgeInsets.all(15),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
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
                      const SizedBox(height: 20,),
                      Row(
                        children: [
                          const Text("Don't have any account ? "),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/Home');
                            },
                            child:const Text('Sign In', style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF494CA2),
                            ),),
                          ),
                        ],
                      )
                    ],
                  ) 
                ))
            ],
          ),
        ));
  }
}
