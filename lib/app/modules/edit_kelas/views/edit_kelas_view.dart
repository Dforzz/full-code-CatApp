import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/edit_kelas_controller.dart';

class EditKelasView extends GetView<EditKelasController> {
  const EditKelasView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Jadwal'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          color: const Color(0xFFF4F7F6),
          height: double.infinity,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Formulir Edit Jadwal",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A237E), // Deep Indigo
                    ),
                  ),
                  const SizedBox(height: 24),
                  Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          _buildInput(
                            controller: controller.namaKelasController,
                            label: 'Nama Kelas',
                            icon: Icons.class_,
                          ),
                          const SizedBox(height: 16),
                          _buildInput(
                            controller: controller.ruanganController,
                            label: 'Ruangan',
                            icon: Icons.meeting_room,
                          ),
                          const SizedBox(height: 16),
                          _buildInput(
                            controller: controller.jamController,
                            label: 'Jam Kelas',
                            icon: Icons.access_time,
                            readOnly: true,
                            onTap: () async {
                              final picked = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              if (picked != null) {
                                // ignore: use_build_context_synchronously
                                controller.jamController.text = picked.format(context);
                              }
                            },
                          ),
                          const SizedBox(height: 16),
                          _buildInput(
                            controller: controller.pengampuController,
                            label: 'Pengampu',
                            icon: Icons.person,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Obx(() {
                    return SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton.icon(
                        onPressed: controller.isLoading.value
                            ? null
                            : controller.updateKelas,
                        icon: controller.isLoading.value
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                              )
                            : const Icon(Icons.save),
                        label: Text(controller.isLoading.value ? "Menyimpan..." : "Simpan Perubahan"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1A237E), // Deep Indigo
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 3,
                        ),
                      ),
                    );
                  })
                ],
              ),
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
    bool readOnly = false,
    VoidCallback? onTap,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      onTap: onTap,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: const Color(0xFF1A237E)), // Deep Indigo
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF1A237E), width: 2), // Deep Indigo
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      validator: (v) => (v == null || v.trim().isEmpty) ? 'Wajib diisi' : null,
    );
  }
}
