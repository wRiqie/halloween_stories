import 'package:get/get.dart';
import 'package:halloween_stories/app/data/repository/tag_repository.dart';
import 'package:halloween_stories/app/modules/tags/tags_controller.dart';

class TagsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TagsController>(() => TagsController());
    Get.lazyPut<TagRepository>(() => TagRepository());
  }
}
