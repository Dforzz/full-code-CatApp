import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Kelas')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.toNamed(Routes.TAMBAH_KELAS),
        icon: const Icon(Icons.add),
        label: const Text('Tambah Kelas'),
      ),
      body: SafeArea(
        child: Container(
          color: const Color(0xFFF5F5F5),
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HEADER
              const Text(
                "Welcome",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5D4037),
                ),
              ),

              const SizedBox(height: 6),

              Text(
                user?.email ?? "User",
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),

              const SizedBox(height: 30),

              // PROFILE CARD
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFB8C00), Color(0xFFFFB74D)],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.orange.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.white,
                      child: Text(
                        user?.email?.substring(0, 1).toUpperCase() ?? "U",
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFB8C00),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Text(
                        "Akun Aktif",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // STATUS CARD
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 6,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Icon(
                        user?.emailVerified == true
                            ? Icons.verified_rounded
                            : Icons.warning_amber_rounded,
                        size: 32,
                        color: user?.emailVerified == true
                            ? Colors.green
                            : const Color(0xFFFB8C00),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          user?.emailVerified == true
                              ? "Email sudah diverifikasi"
                              : "Email belum diverifikasi",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (controller.semuaKelas.isEmpty) {
                    return const Center(child: Text('Belum ada data kelas'));
                  }

                  return ListView.separated(
                    padding: EdgeInsets.zero,
                    itemCount: controller.semuaKelas.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final d = controller.semuaKelas[index];
                      final fotoDosen = d['foto_dosen'] as String?;

                      return ListTile(
                        onTap: () =>
                            Get.toNamed(Routes.DETAIL_KELAS, arguments: d),
                        leading: CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.white,
                          backgroundImage:
                              (fotoDosen != null && fotoDosen.isNotEmpty)
                              ? NetworkImage(fotoDosen)
                              : null,
                          child: (fotoDosen == null || fotoDosen.isEmpty)
                              ? Text(
                                  (d['pengampu'] as String?)
                                          ?.substring(0, 1)
                                          .toUpperCase() ??
                                      'K',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFFB8C00),
                                  ),
                                )
                              : null,
                        ),
                        title: Text(d['nama_kelas'] ?? '-'),
                        subtitle: Text(
                          '${d['ruangan'] ?? '-'} | ${d['jam'] ?? '-'}',
                        ),
                        trailing: Text(d['pengampu'] ?? '-'),
                      );
                    },
                  );
                }),
              ),

              const SizedBox(height: 16),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton.icon(
                  onPressed: _logout,
                  icon: const Icon(Icons.logout),
                  label: const Text("Logout"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5D4037),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
