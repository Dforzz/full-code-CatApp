import 'package:cloud_firestore/cloud_firestore.dart';

class KelasModel {
  final String id, namaKelas, pengampu, ruangan, jam, fotoDosen;
  final Timestamp? createdAt;

  KelasModel({
    required this.id,
    required this.namaKelas,
    required this.pengampu,
    required this.ruangan,
    required this.jam,
    required this.fotoDosen,
    this.createdAt,
  });

  factory KelasModel.fromMap(Map<String, dynamic> map) => KelasModel(
        id: map['id'] ?? '',
        namaKelas: map['nama_kelas'] ?? '',
        pengampu: map['pengampu'] ?? '',
        ruangan: map['ruangan'] ?? '',
        jam: map['jam'] ?? '',
        fotoDosen: map['foto_dosen'] ?? '',
        createdAt: map['created_at'],
      );
      

  Map<String, dynamic> toMap() => {
        'id': id,
        'nama_kelas': namaKelas,
        'pengampu': pengampu,
        'ruangan': ruangan,
        'jam': jam,
        'foto_dosen': fotoDosen,
        'created_at': createdAt,
      };
}