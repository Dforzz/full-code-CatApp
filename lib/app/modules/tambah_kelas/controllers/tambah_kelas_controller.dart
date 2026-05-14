import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TambahKelasController extends GetxController {
  final namaKelas = TextEditingController();
  final ruangan = TextEditingController();
  final jam = TextEditingController();
  final pengampu = TextEditingController();
  final fotoDosen = TextEditingController();

  final isLoading = false.obs;

  @override
  void onClose() {
    namaKelas.dispose();
    ruangan.dispose();
    jam.dispose();
    pengampu.dispose();
    fotoDosen.dispose();
    super.onClose();
  }

  Future<void> simpanKelas() async {
    if (namaKelas.text.isEmpty ||
        ruangan.text.isEmpty ||
        jam.text.isEmpty ||
        pengampu.text.isEmpty) {
      Get.snackbar('Error', 'Semua kolom wajib diisi kecuali Foto Dosen',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    isLoading.value = true;
    try {
      await FirebaseFirestore.instance.collection('kelas').add({
        'nama_kelas': namaKelas.text,
        'ruangan': ruangan.text,
        'jam': jam.text,
        'pengampu': pengampu.text,
        'foto_dosen': fotoDosen.text,
        'created_at': FieldValue.serverTimestamp(),
      });
      Get.back();
      Get.snackbar('Sukses', 'Berhasil menambahkan kelas',
          backgroundColor: Colors.green, colorText: Colors.white);
    } catch (e) {
      Get.snackbar('Error', 'Gagal menyimpan data: $e',
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }
}
