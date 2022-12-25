import 'package:perpuskita_app/sql_perpus.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'model/buku.dart';

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
  TextEditingController penulisController = TextEditingController();
  TextEditingController tahunController = TextEditingController();
  TextEditingController sipnosisController = TextEditingController();

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

  String? photoprofile;
  Future<String> getFilePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        'jpg',
        'png',
        'webm',
      ],
    );

    if (result != null) {
      PlatformFile sourceFile = result.files.first;
      final destination = await getExternalStorageDirectory();
      File? destinationFile =
          File('${destination!.path}/${sourceFile.name.hashCode}');
      final newFile =
          File(sourceFile.path!).copy(destinationFile.path.toString());
      setState(() {
        photoprofile = destinationFile.path;
      });
      File(sourceFile.path!.toString()).delete();
      return destinationFile.path;
    } else {
      return "Dokumen belum diupload";
    }
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
                              hintText: 'Search Buku'),
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
                        title: Center(
                          child: Text(
                            perpus[index]['nama_buku'] ?? "No Tittle",
                            textAlign: TextAlign.center,
                          ),
                        ),
                        content: Container(
                          height: 150,
                          width: 100,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  "Penulis : " + perpus[index]['penulis_buku']),
                              const SizedBox(height: 5),
                              Text("Tahun : " + perpus[index]['tahun_buku']),
                              const SizedBox(height: 10),
                              const Text(
                                "Sinopsis",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                perpus[index]['sipnosis_buku'],
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                              ),
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
                          Container(
                            height: 150,
                            width: 200,
                            child: perpus[index]['foto_buku'] != ''
                                ? Image.file(
                                    File(perpus[index]['foto_buku']),
                                    fit: BoxFit.cover,
                                  )
                                : FlutterLogo(),
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
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF494CA2)),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      perpus[index]['tahun_buku'],
                                      style: TextStyle(fontSize: 10),
                                    )
                                  ],
                                ),
                              )),
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

  Future<void> createData(Buku buku) async {
    await SQLPerpus.createData(buku);
    refreshData();
  }

  Future<void> changeData(Buku buku) async {
    await SQLPerpus.changeData(buku);
    refreshData();
  }

  Future deleteData(int id) async {
    await SQLPerpus.deleteData(id);
    return refreshData();
  }

  void Form(id) async {
    if (id != null) {
      final dataPerpus = perpus.firstWhere((element) => element['id'] == id);
      namaController.text = dataPerpus['nama_buku'];
      penulisController.text = dataPerpus['penulis_buku'];
      tahunController.text = dataPerpus['tahun_buku'];
      sipnosisController.text = dataPerpus['sipnosis_buku'];
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
                    controller: sipnosisController,
                    decoration:
                        const InputDecoration(hintText: "Sipnosis Buku"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        getFilePicker();
                      },
                      child: Row(
                        children: const [
                          Text("Pilih Gambar"),
                          Icon(Icons.camera)
                        ],
                      )),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF494CA2)),
                      onPressed: () async {
                        if (id == null) {
                          String? photo = photoprofile;
                          final data = Buku(
                              id: id,
                              nama_buku: namaController.text,
                              penulis_buku: penulisController.text,
                              tahun_buku: tahunController.text,
                              sipnosis_buku: sipnosisController.text,
                              foto_buku: photo.toString());
                          await createData(data);
                          print("Tambah");
                        } else {
                          String? photo = photoprofile;
                          final data = Buku(
                              id: id,
                              nama_buku: namaController.text,
                              penulis_buku: penulisController.text,
                              tahun_buku: tahunController.text,
                              sipnosis_buku: sipnosisController.text,
                              foto_buku: photo.toString());
                          await changeData(data);
                          print("Updated");
                        }
                        namaController.text = '';
                        penulisController.text = '';
                        tahunController.text = '';
                        sipnosisController.text = '';
                        Navigator.pop(context);
                      },
                      child: Text(id == null ? 'Tambah' : 'ubah'))
                ],
              )),
            )));
  }
}
