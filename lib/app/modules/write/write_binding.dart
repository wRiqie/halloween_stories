import 'package:get/get.dart';
import 'package:halloween_stories/app/modules/write/write_controller.dart';

class WriteBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<WriteController>(() => WriteController());
  }
}