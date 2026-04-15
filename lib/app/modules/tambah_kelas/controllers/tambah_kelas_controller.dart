import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TambahKelasController extends GetxController {
  final namaKelasC = TextEditingController();
  final ruanganC = TextEditingController();
  final jamC = TextEditingController();
  final pengampuC = TextEditingController();
  final fotoDosenC = TextEditingController();

  final isLoading = false.obs;

  @override
  void onClose() {
    namaKelasC.dispose();
    ruanganC.dispose();
    jamC.dispose();
    pengampuC.dispose();
    fotoDosenC.dispose();
    super.onClose();
  }

  Future<void> simpanKelas() async {
    if (namaKelasC.text.isEmpty ||
        ruanganC.text.isEmpty ||
        jamC.text.isEmpty ||
        pengampuC.text.isEmpty) {
      Get.snackbar('Error', 'Semua kolom wajib diisi kecuali Foto Dosen',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    isLoading.value = true;
    try {
      await FirebaseFirestore.instance.collection('kelas').add({
        'nama_kelas': namaKelasC.text,
        'ruangan': ruanganC.text,
        'jam': jamC.text,
        'pengampu': pengampuC.text,
        'foto_dosen': fotoDosenC.text,
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
