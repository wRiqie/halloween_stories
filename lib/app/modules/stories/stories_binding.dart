import 'package:get/get.dart';
import 'package:halloween_stories/app/data/repository/story_repository.dart';
import 'package:halloween_stories/app/data/repository/tag_repository.dart';
import 'package:halloween_stories/app/modules/stories/stories_controller.dart';

class StoriesBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StoriesController>(() => StoriesController());
    Get.lazyPut<StoryRepository>(() => StoryRepository());
    Get.lazyPut<TagRepository>(() => TagRepository());
  }
}
