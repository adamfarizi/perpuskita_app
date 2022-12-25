class Buku {
  final int? id;
  final String nama_buku;
  final String penulis_buku;
  final String tahun_buku;
  final String sipnosis_buku;
  final String foto_buku;

  const Buku({this.id, required this.nama_buku, required this.penulis_buku, required this.tahun_buku, required this.sipnosis_buku, required this.foto_buku});
  Map<String, dynamic> toList() {
    return {'id': id, 'nama_buku': nama_buku, 'penulis_buku': penulis_buku, 'tahun_buku': tahun_buku, 'sipnosis_buku': sipnosis_buku, 'foto_buku': foto_buku};
  }

  @override
  String toString() {
   return "{'id': id, 'nama_buku': nama_buku, 'penulis_buku': penulis_buku, 'tahun_buku': tahun_buku, 'sipnosis_buku': sipnosis_buku, 'foto_buku': foto_buku}";
  }
}