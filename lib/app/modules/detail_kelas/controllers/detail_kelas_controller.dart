import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DetailKelasController extends GetxController {
  Future<void> deleteKelas(String id) async {
    try {
      await FirebaseFirestore.instance.collection('kelas').doc(id).delete();
      Get.snackbar('Sukses', 'Kelas berhasil dihapus');
    } catch (e) {
      Get.snackbar('Error', 'Kelas gagal dihapus');
    }
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
