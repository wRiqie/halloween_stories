import 'package:get/get.dart';
import 'package:halloween_stories/app/data/repository/story_repository.dart';
import 'package:halloween_stories/app/data/repository/tag_repository.dart';
import 'package:halloween_stories/app/modules/write/write_controller.dart';

class WriteBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WriteController>(() => WriteController());
    Get.lazyPut<StoryRepository>(() => StoryRepository());
    Get.lazyPut<TagRepository>(() => TagRepository());
  }
}
