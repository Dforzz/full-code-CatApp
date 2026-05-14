import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart ';
import 'package:get/get.dart';

class EditKelasController extends GetxController {
  final isLoading = false.obs;

  final namaKelasController = TextEditingController();
  final pengampuController = TextEditingController();
  final ruanganController = TextEditingController();
  final jamController = TextEditingController();
  final fotoDosenController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  late final String kelasId;

  @override
  void onInit() {
    super.onInit();
    final args = (Get.arguments ?? {}) as Map<String, dynamic>;
    kelasId = (args['id'] ?? '') as String;

    namaKelasController.text = (args['nama_kelas'] ?? '') as String;
    pengampuController.text = (args['pengampu'] ?? '') as String;
    ruanganController.text = (args['ruangan'] ?? '') as String;
    jamController.text = (args['jam'] ?? '') as String;
    fotoDosenController.text = (args['foto_dosen'] ?? '') as String;
  }

  Future<void> updateKelas() async {
    if (!(formKey.currentState?.validate() ?? false)) return;

    try {
      isLoading.value = true;
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      await FirebaseFirestore.instance.collection('kelas').doc(kelasId).update({
        'nama_kelas': namaKelasController.text.trim(),
        'pengampu': pengampuController.text.trim(),
        'ruangan': ruanganController.text.trim(),
        'jam': jamController.text.trim(),
        'foto_dosen': fotoDosenController.text.trim(),
      });

      Get.back(); // dialog
      Get.snackbar('Sukses', 'Kelas berhasil diupdate');
      Get.back(); // balik ke detail
    } catch (e) {
      if (Get.isDialogOpen ?? false) Get.back();
      Get.snackbar('Error', 'Gagal update: $e');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    namaKelasController.dispose();
    pengampuController.dispose();
    ruanganController.dispose();
    jamController.dispose();
    fotoDosenController.dispose();
    super.onClose();
  }
}
