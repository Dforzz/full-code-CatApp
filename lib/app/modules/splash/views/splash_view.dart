import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFFB8C00), Color(0xFF5D4037)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset('assets/lottie/splash.json', width: 250),

                const SizedBox(height: 30),

                const Text(
                  "CatApp",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.1,
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  "Integrasi Firebse Auth dengan Flutter",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),

                const SizedBox(height: 60),

                Obx(
                  () => AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: controller.isLoading.value
                        ? Column(
                            key: const ValueKey(1),
                            children: const [
                              SizedBox(
                                height: 40,
                                width: 40,
                                child: CircularProgressIndicator(
                                  strokeWidth: 4,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 15),
                              Text(
                                "Memuat aplikasi...",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          )
                        : Column(
                            key: const ValueKey(2),
                            children: [
                              SizedBox(
                                width: double.infinity,
                                height: 55,
                                child: ElevatedButton(
                                  onPressed: controller.goToLogin,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor: const Color(0xFF5D4037),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: const Text(
                                    "Lanjutkan",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 15),

                              TextButton(
                                onPressed: controller.goToLogin,
                                child: const Text(
                                  "Lewati",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
