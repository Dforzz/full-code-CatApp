import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../controllers/login_controller.dart';
import '../../../routes/app_pages.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 40),

              Lottie.asset(
                'assets/lottie/login.json',
                height: 200,
              ),

              const SizedBox(height: 30),

              const Text(
                "Portal Akademik",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A237E), // Deep Indigo
                ),
              ),

              const SizedBox(height: 30),

              TextField(
                controller: controller.emailController,
                decoration: const InputDecoration(
                  hintText: 'Email',
                  prefixIcon: Icon(Icons.email),
                ),
              ),

              const SizedBox(height: 16),

              TextField(
                controller: controller.passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: controller.login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1A237E), // Deep Indigo
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 3,
                  ),
                  child: const Text(
                    "Login Mahasiswa",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              TextButton(
                onPressed: () => Get.toNamed(Routes.REGISTER),
                child: const Text(
                  "Mahasiswa Baru? Daftar di sini",
                  style: TextStyle(color: Color(0xFF1A237E), fontWeight: FontWeight.w600), // Deep Indigo
                ),
              ),

              TextButton(
                onPressed: () => Get.toNamed(Routes.FORGOT_PASSWORD),
                child: const Text(
                  "Lupa Password Portal?",
                  style: TextStyle(color: Color(0xFFFFB300), fontWeight: FontWeight.bold), // Academic Gold
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}