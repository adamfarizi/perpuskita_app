class Majalah {
  final int? id;
  final String judul_majalah;
  final String penerbit_majalah;
  final String tglterbit_majalah;
  final String foto_majalah;

  const Majalah({this.id, required this.judul_majalah, required this.penerbit_majalah, required this.tglterbit_majalah, required this.foto_majalah});
  Map<String, dynamic> toList() {
    return {'id': id, 'judul_majalah': judul_majalah, 'penerbit_majalah': penerbit_majalah, 'tglterbit_majalah': tglterbit_majalah, 'foto_majalah': foto_majalah};
  }

  @override
  String toString() {
   return "{'id': id, 'judul_majalah': judul_majalah, 'penerbit_majalah': penerbit_majalah, 'tglterbit_majalah': tglterbit_majalah, 'foto_majalah': foto_majalah}";
  }
}