import 'package:flutter/material.dart';
import 'package:perpuskita_app/sql_perpus.dart';
import 'package:perpuskita_app/Pages/page1.dart';

void main(List<String> args) {
  runApp(page2());
}

class page2 extends StatelessWidget {
  const page2({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: GridView.builder(
            gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount: 1,
            itemBuilder: (_, index) => Padding(
            padding: EdgeInsets.all(10),
            child: Card(
              child: Column(
                children: [
                  Image(
                    image: AssetImage('asset/img/book3.jpg'),
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                       "No Title",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
            ),),
        )
      ),
    );
  }
}
