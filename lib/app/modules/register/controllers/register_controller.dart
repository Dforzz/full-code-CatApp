import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../routes/app_pages.dart';

class RegisterController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> register() async {
    try {
      Get.dialog(Center(child: CircularProgressIndicator()));
      
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      
      await userCredential.user?.sendEmailVerification();
      
      Get.back();
      Get.snackbar('Success', 'Akun berhasil dibuat. Verifikasi email!');
      Get.offAllNamed(Routes.LOGIN);
      
    } on FirebaseAuthException catch (e) {
      Get.back();
      Get.snackbar('Error', e.message ?? 'Registrasi gagal');
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}