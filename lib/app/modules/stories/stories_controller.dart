import 'package:get/get.dart';
import 'package:halloween_stories/app/data/repository/story_repository.dart';

class StoriesController extends GetxController {
  final repository = Get.find<StoryRepository>();
  final stories = [].obs;
  final isLoading = false.obs;

  getStories() {
    isLoading.value = true;
    repository.getStories().then((value) {
      stories.value = value;
      isLoading.value = false;
    });
  }

  deleteStory(int id) async {
    var result = await repository.deleteStory(id);
    if (result != -1) {
      stories.removeWhere((x) => x.id == id);
    }
  }

  @override
  void onInit() {
    super.onInit();
    getStories();
  }
}
