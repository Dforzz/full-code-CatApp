import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class SplashController extends GetxController {
  final isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    checkAuthStatus();
  }

  Future<void> checkAuthStatus() async {
    await Future.delayed(const Duration(seconds: 1));
    isLoading.value = false;
  }

  Future<void> goToLogin() async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 2));
    Get.offAllNamed(Routes.LOGIN);
  }
}