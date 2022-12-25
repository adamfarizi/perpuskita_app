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
  const MyWidget({
    super.key,
  });

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
  void initState() {
    refreshData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: AppBar(
            backgroundColor: Colors.white,
            shadowColor: Colors.white,
            flexibleSpace: Container(
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 50,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      const Image(
                        image: AssetImage('asset/img/P2.png'),
                        width: 60,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 300,
                        height: 50,
                        child: TextField(
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(10),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hintText: 'Search Books'),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        body: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisExtent: 235),
            itemCount: perpus.length,
            itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: Center(child: Text(perpus[index]['nama_buku'] ?? "No Tittle", textAlign: TextAlign.center,),),
                        content: Container(
                          height: 150,
                          width: 100,
                          child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Penulis : " + perpus[index]['penulis_buku']),
                            const SizedBox(height: 5),
                            Text("Tahun : " + perpus[index]['tahun_buku']),
                            const SizedBox(height: 10),
                            const Text("Sinopsis", style: TextStyle(fontWeight: FontWeight.bold),),
                            Text("Si Fulan lagi bosan di kantor. Dia sedang memfotokopi sebuah lembar kerja. Tetapi mesin fotokopi ngadat sehingga dia kesal lalu menendang mesin itu. Mesin bekerja lagi tapi yang keluar bukannya hasil fotokopi lembar kerja, tapi sebuah titik hitam besar hampir memenuhi seluruh lembar kertas.",
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,)
                          ],
                        ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              Form(perpus[index]['id']);
                              Navigator.of(context).pop();
                            },
                            child: const Text('EDIT'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pop(deleteData(perpus[index]['id']));
                            },
                            child: const Text('HAPUS'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Card(
                      child: Column(
                        children: [
                          const Image(
                            image: AssetImage('asset/img/book3.jpg'),
                            fit: BoxFit.cover,
                            height: 150,
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Container(
                              width: 150,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    perpus[index]['nama_buku'] ?? "No Tittle",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF494CA2)),
                                  ),
                                  const SizedBox(height: 5,),
                                  Text(perpus[index]['tahun_buku'], style: TextStyle(fontSize: 10),)
                                ],
                              ),
                            )
                          ),
                        ],
                      ),
                    ),
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
                  const Text('Data Buku Baru',
                      style: TextStyle(
                          color: Color(0xFF494CA2),
                          fontWeight: FontWeight.bold,
                          fontSize: 20)),
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
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF494CA2)),
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
                      child: Text(id == null ? 'Tambah' : 'ubah'))
                ],
              )),
            )));
  }
}
