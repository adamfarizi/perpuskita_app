    import 'dart:convert';
    import 'package:http/http.dart' as http;
    import 'package:flutter/material.dart';
    
    void main() {
      runApp(const MyApp());
    }
    
    class MyApp extends StatefulWidget {
      const MyApp({Key? key}) : super(key: key);
    
      @override
      _MyAppState createState() => _MyAppState();
    }
    
    class _MyAppState extends State<MyApp> {
      //_get berfungsi untuk menampung data dari internet nanti
      List _get = [];
    
      //paste apikey yang didapatkan dari newsapi.org
      var apikey = 'ISI DENGAN API KEY YANG KALIAN DAPATKAN';
    
      @override
      void initState() {
        super.initState();
        _getData();
      }
    
      //method untuk merequest/mengambil data dari internet
      Future _getData() async {
        try {
          final response = await http.get(Uri.parse(
              "https://newsapi.org/v2/top-headlines?country=id&category=business&apiKey=${apikey}"));
    
          // cek apakah respon berhasil
          if (response.statusCode == 200) {
            final data = jsonDecode(response.body);
    
            setState(() {
              //memasukan data yang di dapat dari internet ke variabel _get
              _get = data['articles'];
            });
          }
        } catch (e) {
          //tampilkan error di terminal
          print(e);
        }
      }
    
      @override
      Widget build(BuildContext context) {
        return MaterialApp(
          //menghilangkan debug label
          debugShowCheckedModeBanner: false,
          home: Scaffold(
    
              //membuat appbar dengan background putih dan membuat tulisan di tengah
              appBar: AppBar(
                backgroundColor: Colors.white,
                title: Builder(builder: (context) {
                  return Center(
                    child: Text(
                      "Apk Berita",
                      style: TextStyle(color: Colors.black38),
                    ),
                  );
                }),
              ),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 15,
                        left: 15
                      ),
                      child: Text(
                        "List Berita"
                      ),
                    ),
                    //widget gridview, kita buat custom di bawah
                    GridList(get: _get),
                  ],
                ),
              )),
        );
      }
    }
    
    class GridList extends StatelessWidget {
      const GridList({
        Key? key,
        required List get,
      }) : _get = get, super(key: key);
    
      final List _get;
    
      @override
      Widget build(BuildContext context) {
        return GridView.builder(
    
          //wajib menggunakan 2 baris script di bawah ini, agar dapat digabung dengan widget lain
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
    
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            // banyak grid yang ditampilkan dalam satu baris
            crossAxisCount: 2
          ),
          itemBuilder: (_, index) => Padding(
            padding: EdgeInsets.all(10),
            child: Card(
              child: Column(
                children: [
                  Image(
                    image: NetworkImage(_get[index]['urlToImage'] ??
                        "https://cdn.pixabay.com/photo/2018/03/17/20/51/white-buildings-3235135__340.jpg"),
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      _get[index]['title'] ?? "No Title",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
            ),
          ),
         
         
         itemCount: _get.length,
        );
      }
    }