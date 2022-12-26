import 'package:perpuskita_app/sql_perpus.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'model/majalah.dart';

void main() {
  runApp(const Magazine());
}

class Magazine extends StatelessWidget {
  const Magazine({Key? key}) : super(key: key);

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
  TextEditingController judulController = TextEditingController();
  TextEditingController penerbitController = TextEditingController();
  TextEditingController tglterbitController = TextEditingController();

  List<Map<String, dynamic>> majalah = [];
  void refreshData() async {
    final data = await SQLPerpus.getData2();
    setState(() {
      majalah = data;
    });
  }

  @override
  void initState() {
    refreshData();
    super.initState();
  }

  String? gambarmajalah;
  Future<String> getFilePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom,
    allowedExtensions: [
      'jpg',
      'png',
      'webm',
    ],);

    if (result != null) {
      PlatformFile sourceFile = result.files.first;
      final destination = await getExternalStorageDirectory();
      File? destinationFile =
          File('${destination!.path}/${sourceFile.name.hashCode}');
      final newFile =
          File(sourceFile.path!).copy(destinationFile.path.toString());
      setState(() {
        gambarmajalah = destinationFile.path;
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
                              hintText: 'Search Majalah'),
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
            itemCount: majalah.length,
            itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: Center(child: Text(majalah[index]['judul_majalah'] ?? "No Tittle", textAlign: TextAlign.center,),),
                        content: Container(
                          height: 80,
                          width: 100,
                          child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Penerbit : " + majalah[index]['penerbit_majalah']),
                            const SizedBox(height: 5),
                            Text("Tanggal Terbit : " + majalah[index]['tglterbit_majalah']),
                            const SizedBox(height: 10),
                            
                          ],
                        ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('Cancel', style: TextStyle(color: Color(0xFF494CA2)),),
                          ),
                          TextButton(
                            onPressed: () {
                              Form(majalah[index]['id']);
                              Navigator.of(context).pop();
                            },
                            child: const Text('EDIT', style: TextStyle(color: Color(0xFF494CA2)),),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pop(deleteData2(majalah[index]['id']));
                            },
                            child: const Text('HAPUS', style: TextStyle(color: Color(0xFF494CA2)),),
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
                           if ((majalah[index]['foto_majalah'] as String) == "null")...[
                          const Image(
                            image: AssetImage('asset/img/book3.jpg'),
                          fit: BoxFit.cover,
                          height: 150,
                          ),
                          ]
                          else ...[
                          Container(
                            height: 150, width: 200,
                            child: Image.file(
                                    File(majalah[index]['foto_majalah']),
                                    fit: BoxFit.cover,
                                    )
                          ),
                          ],
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Container(
                              width: 150,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    majalah[index]['judul_majalah'] ?? "No Tittle",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF494CA2)),
                                  ),
                                  const SizedBox(height: 5,),
                                  Text(majalah[index]['tglterbit_majalah'], style: TextStyle(fontSize: 10),)
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

  Future<void> createData2(Majalah majalah) async {
    await SQLPerpus.createData2(majalah);
    refreshData();
  }

  Future<void> changeData2(Majalah majalah) async {
    await SQLPerpus.changeData2(majalah);
    refreshData();
  }

  Future deleteData2(int id) async {
    await SQLPerpus.deleteData2(id);
    return refreshData();
  }

  void Form(id) async {
    if (id != null) {
      final datamajalah = majalah.firstWhere((element) => element['id'] == id);
      judulController.text = datamajalah['judul_majalah'];
      penerbitController.text = datamajalah['penerbit_majalah'];
      tglterbitController.text = datamajalah['tglterbit_majalah'];
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
                  const Text('Data Majalah Baru',
                      style: TextStyle(
                          color: Color(0xFF494CA2),
                          fontWeight: FontWeight.bold,
                          fontSize: 20)),
                  const SizedBox(height: 10),
                  TextField(
                    controller: judulController,
                    decoration: const InputDecoration(hintText: "Judul Majalah"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: penerbitController,
                    decoration: const InputDecoration(hintText: "Penerbit Majalah"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: tglterbitController,
                    decoration: const InputDecoration(hintText: "Tanggal Terbit Majalah"),
                  ),
                  const SizedBox(
                    height: 10,
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
                          String? gambar = gambarmajalah;
                          final data = Majalah(
                              id: id,
                              judul_majalah: judulController.text,
                              penerbit_majalah: penerbitController.text,
                              tglterbit_majalah: tglterbitController.text,
                              foto_majalah: gambar.toString());
                          await createData2(data);
                          print("Tambah");
                        } else {
                          String? gambar = gambarmajalah;
                          final data = Majalah(
                              id: id,
                              judul_majalah: judulController.text,
                              penerbit_majalah: penerbitController.text,
                              tglterbit_majalah: tglterbitController.text,
                              foto_majalah: gambar.toString());
                          await changeData2(data);
                          print("Updated");
                        }
                        judulController.text = '';
                        penerbitController.text = '';
                        tglterbitController.text = '';
                        Navigator.pop(context);
                      },
                      child: Text(id == null ? 'Tambah' : 'ubah'))
                ],
              )),
            )));
  }
}