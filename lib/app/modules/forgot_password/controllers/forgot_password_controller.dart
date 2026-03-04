import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final emailController = TextEditingController();
  final isLoading = false.obs;

  Future<void> resetPassword() async {
    if (emailController.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Email tidak boleh kosong',
        backgroundColor: const Color(0xFF5D4037),
        colorText: Colors.white,
      );
      return;
    }

    try {
      isLoading.value = true;

      await _auth.sendPasswordResetEmail(
        email: emailController.text.trim(),
      );

      Get.snackbar(
        'Success',
        'Link reset dikirim ke ${emailController.text.trim()}',
        backgroundColor: const Color(0xFFFB8C00),
        colorText: Colors.white,
      );

      Get.back();

    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        'Error',
        e.message ?? 'Gagal kirim email reset',
        backgroundColor: const Color(0xFF5D4037),
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}