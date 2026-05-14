import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../controllers/jadwal_kelas_controller.dart';

class JadwalKelasView extends GetView<JadwalKelasController> {
  const JadwalKelasView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jadwal Kelas'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          color: const Color(0xFFF5F5F5),
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton.icon(
                  onPressed: () => Get.toNamed(Routes.TAMBAH_KELAS),
                  icon: const Icon(Icons.add_circle_outline),
                  label: const Text(
                    "Tambah Jadwal Baru",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1A237E), // Deep Indigo
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 3,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: const [
                  Icon(Icons.collections_bookmark, color: Color(0xFF1A237E)),
                  SizedBox(width: 8),
                  Text(
                    "Daftar Kelas Semester Ini",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A237E), // Deep Indigo
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
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

                      return Card(
                        elevation: 2,
                        margin: const EdgeInsets.only(bottom: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide(color: Colors.grey.shade200),
                        ),
                        child: InkWell(
                          onTap: () => Get.toNamed(Routes.DETAIL_KELAS, arguments: d),
                          borderRadius: BorderRadius.circular(16),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                Container(
                                  width: 55,
                                  height: 55,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: const Color(0xFFFFB300).withOpacity(0.2), // Academic Gold
                                  ),
                                  child: (fotoDosen != null && fotoDosen.isNotEmpty)
                                      ? ClipOval(
                                          child: Image.network(
                                            fotoDosen,
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, error, stackTrace) {
                                              return Center(
                                                child: Text(
                                                  (d['pengampu'] as String?)?.substring(0, 1).toUpperCase() ?? 'D',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFF1A237E),
                                                    fontSize: 20,
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        )
                                      : Center(
                                          child: Text(
                                            (d['pengampu'] as String?)?.substring(0, 1).toUpperCase() ?? 'D',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF1A237E),
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        d['nama_kelas'] ?? '-',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Color(0xFF1A237E), // Deep Indigo
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          const Icon(Icons.meeting_room, size: 14, color: Colors.grey),
                                          const SizedBox(width: 4),
                                          Text(
                                            d['ruangan'] ?? '-',
                                            style: const TextStyle(color: Colors.black54, fontSize: 13),
                                          ),
                                          const SizedBox(width: 12),
                                          const Icon(Icons.access_time, size: 14, color: Colors.grey),
                                          const SizedBox(width: 4),
                                          Text(
                                            d['jam'] ?? '-',
                                            style: const TextStyle(color: Colors.black54, fontSize: 13),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black26),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
