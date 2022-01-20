import 'package:get/get.dart';
import 'package:halloween_stories/app/routes/app_pages.dart';

class SplashController extends GetxController {
  closeSplashscreen(){
    Future.delayed(const Duration(seconds: 5), (){
      Get.offAndToNamed(Routes.stories);
    });
  }

  @override
  void onInit() {
    super.onInit();
    closeSplashscreen();
  }
}