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
                "Welcome Back",
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
                onPressed: controller.login,
                child: const Text("Login"),
              ),

              const SizedBox(height: 10),

              TextButton(
                onPressed: () => Get.toNamed(Routes.REGISTER),
                child: const Text(
                  "Belum punya akun? Register",
                  style: TextStyle(color: Color(0xFF5D4037)),
                ),
              ),

              TextButton(
                onPressed: () => Get.toNamed(Routes.FORGOT_PASSWORD),
                child: const Text(
                  "Lupa Password?",
                  style: TextStyle(color: Color(0xFFFB8C00)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}