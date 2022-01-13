import 'package:get/get.dart';
import 'package:halloween_stories/app/modules/splash/splash_controller.dart';

class SplashBinding implements Bindings {
@override
void dependencies() {
  Get.put<SplashController>(SplashController());
  }
}