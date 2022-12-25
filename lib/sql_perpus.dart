import 'package:sqflite/sqflite.dart' as sql;
import 'package:perpuskita_app/Pages/model/buku.dart';
import 'package:perpuskita_app/Pages/model/majalah.dart';

class SQLPerpus {
  static Future<sql.Database> db() async {
    return sql.openDatabase("perpus.db", version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTable(database);
    });
  }

  static Future<void> createTable(sql.Database database) async {
    await database.execute("""
    CREATE TABLE perpus(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      nama_buku TEXT,
      penulis_buku TEXT,
      tahun_buku TEXT,
      sipnosis_buku TEXT,
      foto_buku
    )
    """);
    
    await database.execute("""
    CREATE TABLE majalah(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      judul_majalah TEXT,
      penerbit_majalah TEXT,
      tglterbit_majalah TEXT,
      foto_majalah
    )
    """);
  }

//CURD tabel perpus
  static Future<int> createData(Buku buku) async {
    final db = await SQLPerpus.db();
    final data = buku.toList();
    return db.insert('perpus', data);
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    final db = await SQLPerpus.db();
    return db.query("perpus");
  }

  static Future<int> changeData(Buku buku) async {
    final db = await SQLPerpus.db();
    final data = buku.toList();
    return await db.update("perpus", data, where: "id=?", whereArgs: [buku.id]);
  }

  static Future deleteData(int id) async {
    final db = await SQLPerpus.db();
    await db.delete("perpus", where: "id=$id");
  }

//CURD tabel majalah
  static Future<int> createData2(Majalah majalah) async {
    final db = await SQLPerpus.db();
    final data = majalah.toList();
    return db.insert('majalah', data);
  }

  static Future<List<Map<String, dynamic>>> getData2() async {
    final db = await SQLPerpus.db();
    return db.query("majalah");
  }

  static Future<int> changeData2(Majalah majalah) async {
    final db = await SQLPerpus.db();
    final data = majalah.toList();
    return await db.update("majalah", data, where: "id=?", whereArgs: [majalah.id]);
  }

  static Future deleteData2(int id) async {
    final db = await SQLPerpus.db();
    await db.delete("perpus", where: "id=$id");
  }
}