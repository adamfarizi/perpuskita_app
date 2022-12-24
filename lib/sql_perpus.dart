import 'package:sqflite/sqflite.dart' as sql;

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
      genre_buku TEXT,
      penulis_buku TEXT,
      tahun_buku TEXT,
      jumlah_buku TEXT

    )
    """);
  }

  static Future<int> createData(String nama_buku, String genre_buku,
      String penulis_buku, String tahun_buku, String jumlah_buku) async {
    final db = await SQLPerpus.db();
    final data = {
      'nama_buku': nama_buku,
      'genre_buku': genre_buku,
      'penulis_buku': penulis_buku,
      'tahun_buku': tahun_buku,
      'jumlah_buku': jumlah_buku
    };
    return await db.insert("perpus", data);
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    final db = await SQLPerpus.db();
    return db.query("perpus");
  }

  static Future<int> changeData(int id, String nama_buku, String genre_buku,
      String penulis_buku, String tahun_buku, String jumlah_buku) async {
    final db = await SQLPerpus.db();
    final data = {
      'nama_buku': nama_buku,
      'genre_buku': genre_buku,
      'penulis_buku': penulis_buku,
      'tahun_buku': tahun_buku,
      'jumlah_buku': jumlah_buku
    };
    return await db.update("perpus", data, where: "id=$id");
  }

  static Future deleteData(int id) async {
    final db = await SQLPerpus.db();
    await db.delete("perpus", where: "id=$id");
  }
}
