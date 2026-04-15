import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/detail_kelas_controller.dart';

class DetailKelasView extends GetView<DetailKelasController> {
  const DetailKelasView({super.key});

  @override
  Widget build(BuildContext context) {
    // Menarik data yang dikirim dari HomeView
    final Map<String, dynamic> data = Get.arguments ?? {};
    final String namaKelas = data['nama_kelas'] ?? '-';
    final String ruangan = data['ruangan'] ?? '-';
    final String jam = data['jam'] ?? '-';
    final String pengampu = data['pengampu'] ?? '-';
    final String? fotoDosen = data['foto_dosen'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Kelas'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              // Dialog Konfirmasi Hapus
              Get.defaultDialog(
                title: "Hapus Kelas",
                middleText: "Apakah Anda yakin ingin menghapus kelas ini?",
                textCancel: "Batal",
                textConfirm: "Hapus",
                confirmTextColor: Colors.white,
                buttonColor: Colors.red,
                cancelTextColor: Colors.black,
                onConfirm: () {
                  Get.back(); // Tutup dialog
                  // Menggunakan properti id jika tersedia, kosongkan jika tidak ada
                  controller.deleteKelas(data['id'] ?? ''); 
                  Get.back(); // Kembali ke halaman sebelumnya
                },
              );
            },
          )
        ],
      ),
      body: SafeArea(
        child: Container(
          color: const Color(0xFFF5F5F5),
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // FOTO DOSEN
                Hero(
                  tag: 'foto_$namaKelas',
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.white,
                    backgroundImage: (fotoDosen != null && fotoDosen.isNotEmpty)
                        ? NetworkImage(fotoDosen)
                        : null,
                    child: (fotoDosen == null || fotoDosen.isEmpty)
                        ? Text(
                            pengampu.isNotEmpty ? pengampu.substring(0, 1).toUpperCase() : 'D',
                            style: const TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFFB8C00),
                            ),
                          )
                        : null,
                  ),
                ),
                const SizedBox(height: 24),
                
                // NAMA KELAS
                Text(
                  namaKelas,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF5D4037),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                
                // NAMA DOSEN
                Text(
                  pengampu,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 30),
                
                // KARTU RUANGAN DAN JAM
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        _buildInfoRow(Icons.meeting_room, 'Ruangan', ruangan),
                        const SizedBox(height: 16),
                        const Divider(),
                        const SizedBox(height: 16),
                        _buildInfoRow(Icons.access_time, 'Jam', jam),
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

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFFB8C00).withOpacity(0.1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Icon(icon, color: const Color(0xFFFB8C00)),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5D4037),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
