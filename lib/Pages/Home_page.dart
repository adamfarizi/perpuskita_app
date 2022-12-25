import 'package:flutter/material.dart';
import 'package:perpuskita_app/Pages/page1.dart';
import 'package:perpuskita_app/Pages/page2.dart';
import 'package:perpuskita_app/Pages/page3.dart';
import 'package:perpuskita_app/Pages/page4.dart';


void main() {
  runApp(const Home());
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        home: DefaultTabController(
          length: 4,
          child: Scaffold(
            body: TabBarView(
              children: <Widget> [
                Book(),
                page2(),
                page3(),
                page4()
                
              ]),
            bottomNavigationBar: Material(
              color: Colors.white,
              child: TabBar(
                labelPadding: EdgeInsets.all(8),
                unselectedLabelColor: Color(0xFF494CA2),
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.all(
                      Radius.circular(10)), // Creates border
                  color: Color(0xFF494CA2)),
                padding: EdgeInsets.all(5),
                tabs: [
                  Tab(
                    icon: Icon(Icons.home),
                  ),
                  Tab(
                    icon: Icon(Icons.book),
                  ),
                  Tab(
                  icon: Icon(Icons.shop),
                  ),
                  Tab(
                    icon: Icon(Icons.account_circle_rounded),
                  ),
                ]),
            )
          )
      )
    );
  }

  
}
