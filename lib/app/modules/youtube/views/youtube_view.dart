import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/youtube_controller.dart';

import 'package:url_launcher/url_launcher.dart';

class YoutubeView extends GetView<YoutubeController> {
  const YoutubeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7F6),
      appBar: AppBar(
        title: const Text('Materi Edukasi'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.videos.isEmpty) {
          return const Center(child: Text('Tidak ada video'));
        }

        return ListView.builder(
          itemCount: controller.videos.length,
          itemBuilder: (context, index) {
            final video = controller.videos[index];

            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              clipBehavior: Clip.antiAlias,
              elevation: 3,
              child: InkWell(
                onTap: () async {
                  final videoId = video['videoId'];
                  // Perbaiki URL youtube agar mengarah ke video yang benar
                  final Uri url = Uri.parse(
                    'https://www.youtube.com/watch?v=$videoId',
                  );

                  await launchUrl(
                    url,
                    mode: LaunchMode.inAppBrowserView, // 🔥 ini penting
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      video['thumbnail'],
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const SizedBox(
                        height: 200,
                        child: Center(child: Icon(Icons.broken_image, size: 50)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            video['title'] ?? 'Tanpa Judul',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1A237E), // Deep Indigo
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            video['description'] ?? 'Tidak ada deskripsi',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}