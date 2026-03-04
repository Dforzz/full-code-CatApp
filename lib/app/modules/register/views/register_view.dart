import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

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
                'assets/lottie/register.json',
                height: 200,
              ),

              const SizedBox(height: 30),

              const Text(
                "Buat Akun Baru",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5D4037),
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

              ElevatedButton(
                onPressed: controller.register,
                child: const Text("Register"),
              ),

              const SizedBox(height: 10),

              TextButton(
                onPressed: () => Get.back(),
                child: const Text(
                  "Sudah punya akun? Login",
                  style: TextStyle(color: Color(0xFF5D4037)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}