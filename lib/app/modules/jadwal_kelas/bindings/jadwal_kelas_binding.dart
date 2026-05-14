import 'package:get/get.dart';
import '../controllers/jadwal_kelas_controller.dart';

class JadwalKelasBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<JadwalKelasController>(
      () => JadwalKelasController(),
    );
  }
}
