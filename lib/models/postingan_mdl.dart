import 'package:equatable/equatable.dart';

class PostinganMdl extends Equatable {
  final String id;
  final String deskripsi;
  final String gambar;

  const PostinganMdl({required this.id, required this.deskripsi, required this.gambar});

  factory PostinganMdl.fromMap({
    required String id,
    required Map<String, dynamic> map,
  }) {
    return PostinganMdl(id: id, deskripsi: map['deskripsi'], gambar: map['gambar']);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'deskripsi': deskripsi,
      'gambar': gambar,
    };
  }

  @override
  List<Object?> get props => [id, deskripsi, gambar];
}
