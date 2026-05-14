import 'package:get/get.dart';

import '../controllers/youtube_controller.dart';

class YoutubeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<YoutubeController>(
      () => YoutubeController(),
    );
  }
}
