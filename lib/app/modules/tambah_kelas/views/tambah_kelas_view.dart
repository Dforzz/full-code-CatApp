import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/tambah_kelas_controller.dart';

class TambahKelasView extends GetView<TambahKelasController> {
  const TambahKelasView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Kelas'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          color: const Color(0xFFF5F5F5),
          height: double.infinity,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Data Kelas Baru",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF5D4037),
                  ),
                ),
                const SizedBox(height: 24),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        _buildInput(
                          controller: controller.namaKelasC,
                          label: 'Nama Kelas',
                          icon: Icons.class_,
                          hint: 'Contoh: Pemrograman Mobile',
                        ),
                        const SizedBox(height: 16),
                        _buildInput(
                          controller: controller.ruanganC,
                          label: 'Ruangan',
                          icon: Icons.meeting_room,
                          hint: 'Contoh: Lab Komputer A',
                        ),
                        const SizedBox(height: 16),
                        _buildInput(
                          controller: controller.jamC,
                          label: 'Jam',
                          icon: Icons.access_time,
                          hint: 'Contoh: 08:00 - 10:00',
                        ),
                        const SizedBox(height: 16),
                        _buildInput(
                          controller: controller.pengampuC,
                          label: 'Dosen Pengampu',
                          icon: Icons.person,
                          hint: 'Contoh: John Doe',
                        ),
                        const SizedBox(height: 16),
                        _buildInput(
                          controller: controller.fotoDosenC,
                          label: 'URL Foto Dosen (Opsional)',
                          icon: Icons.image,
                          hint: 'Contoh: https://example.com/foto.png',
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Obx(() => SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton.icon(
                    onPressed: controller.isLoading.value
                        ? null
                        : controller.simpanKelas,
                    icon: controller.isLoading.value
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Icon(Icons.save),
                    label: Text(controller.isLoading.value
                        ? "Menyimpan..."
                        : "Simpan Kelas"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFB8C00),
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 5,
                    ),
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInput({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required String hint,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: const Color(0xFF5D4037)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Color(0xFFFB8C00), width: 2),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}
