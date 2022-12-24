import 'package:perpuskita_app/sql_perpus.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const Book());
}

class Book extends StatelessWidget {
  const Book({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyWidget(),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key,});

  @override
  State<MyWidget> createState() => _MyWidgetPageState();
}

class _MyWidgetPageState extends State<MyWidget> {
  TextEditingController namaController = TextEditingController();
  TextEditingController genreController = TextEditingController();
  TextEditingController penulisController = TextEditingController();
  TextEditingController tahunController = TextEditingController();
  TextEditingController jumlahController = TextEditingController();

  List<Map<String, dynamic>> perpus = [];
  void refreshData() async {
    final data = await SQLPerpus.getData();
    setState(() {
      perpus = data;
    });
  }

  @override
  void iniState() {
    refreshData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(perpus);
    return MaterialApp(
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(350),
          child: AppBar(
            title: const Text('All Books',
                style: TextStyle(
                  color: Color(0xFF494CA2),
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),),
            backgroundColor: Colors.white,
            shadowColor: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25)
              )
            ),
            flexibleSpace: Container(
              child: Column(
                children: <Widget> [
                  const SizedBox(height: 50,),
                  Image.asset('asset/img/book2.png',
                  height: 250,),
                  const SizedBox(height: 20,),
                  SizedBox(
                    width: 350,
                    height: 50,
                    child: TextField(
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          icon: const Icon(Icons.search),
                          hintText: 'Search Books'),
                    ),
                  ),
                ],
              ),
            ),

          ),),
        body: ListView.builder(
            itemCount: perpus.length,
            itemBuilder: (context, index) => Card(
                  child: ListTile(
                    leading: Image.asset('asset/img/book3.jpg', height: 80,),
                    title: Text(perpus[index]['nama_buku']),
                    subtitle: Text("Genre : " + perpus[index]['genre_buku']),
                    isThreeLine: true,
                    trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () => Form(perpus[index]['id']),
                                icon: const Icon(Icons.edit)),
                            IconButton(
                                onPressed: () {
                                  deleteData(perpus[index]['id']);
                                },
                                icon: const Icon(Icons.delete))
                          ],
                        )),
                  ),
                )),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Form(null);
          },
          backgroundColor: const Color(0xFF494CA2),
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Future<void> createData() async {
    await SQLPerpus.createData(namaController.text, genreController.text,
        penulisController.text, tahunController.text, jumlahController.text);
    refreshData();
  }

  Future<void> changeData(int id) async {
    await SQLPerpus.changeData(id, namaController.text, genreController.text,
        penulisController.text, tahunController.text, jumlahController.text);
    refreshData();
  }

  Future deleteData(int id) async {
    await SQLPerpus.deleteData(id);
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Berhasil dihapus")));
    return refreshData();
  }

  void Form(id) async {
    if (id != null) {
      final dataPerpus = perpus.firstWhere((item) => item['id'] == id);

      namaController.text = dataPerpus['nama_buku'];
      genreController.text = dataPerpus['genre_buku'];
      penulisController.text = dataPerpus['penulis_buku'];
      tahunController.text = dataPerpus['tahun_buku'];
      jumlahController.text = dataPerpus['jumlah_buku'];
    }
    
    showModalBottomSheet(
        context: context,
        builder: ((context) => Container(
              padding: const EdgeInsets.all(15),
              width: double.infinity,
              height: 2000,
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  const SizedBox(height: 10),
                  const Text('Input Buku Baru',style: TextStyle(
                    color: Color(0xFF494CA2),
                    fontWeight: FontWeight.bold,
                    fontSize: 20)
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: namaController,
                    decoration: const InputDecoration(hintText: "Nama Buku"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: genreController,
                    decoration: const InputDecoration(hintText: "Genre Buku"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: penulisController,
                    decoration: const InputDecoration(hintText: "Penulis Buku"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: tahunController,
                    decoration: const InputDecoration(hintText: "Tahun Buku"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: jumlahController,
                    decoration: const InputDecoration(hintText: "Jumlah Buku"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF494CA2)),
                    onPressed: () async {
                      if (id == null) {
                        await createData();
                        print("Tambah");
                      } else {
                        await changeData(id);
                        print("Updated");
                      }
                      namaController.text = '';
                      genreController.text = '';
                      penulisController.text = '';
                      tahunController.text = '';
                      jumlahController.text = '';
                      Navigator.pop(context);
                    },
                    child: Text(id == null ? 'Tambah' : 'ubah')
                  )
                ],
              )),
            )));
  }
}
