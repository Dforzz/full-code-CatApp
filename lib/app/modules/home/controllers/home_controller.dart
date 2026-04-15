import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
final semuaKelas = <Map<String, dynamic>>[].obs;
final isLoading = true.obs;
StreamSubscription? _subscribtion;

@override
void onInit() {
    super.onInit();
    _subscribtion = FirebaseFirestore.instance
        .collection('kelas')
        .orderBy('created_at', descending: true)
        .snapshots()
        .listen((snap) {
          semuaKelas.value = snap.docs.map((d) => d.data()).toList();
          isLoading.value = false;
        }, onError: (e) {
          isLoading.value = false;
          Get.snackbar('Error', 'Gagal mengambil data: $e');
        });
  }

  @override
  void onClose() {
    _subscribtion?.cancel();
    super.onClose();
  }
}