import 'package:get/get.dart';
import 'package:halloween_stories/app/core/utils/utility.dart';
import 'package:halloween_stories/app/data/model/story.dart';
import 'package:halloween_stories/app/data/repository/story_repository.dart';
import 'package:halloween_stories/app/data/repository/tag_repository.dart';
import 'package:share_plus/share_plus.dart';

class StoriesController extends GetxController {
  final repository = Get.find<StoryRepository>();
  final tagRepository = Get.find<TagRepository>();
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
      await tagRepository.deleteTags(id);
      stories.removeWhere((x) => x.id == id);
    }
  }

  shareStory(Story story) async {
    String tags = '';
    String separation = '';
    if (story.photo.isNotEmpty) {
      if (story.tags != null && story.tags!.isNotEmpty) {
        separation = '\n';
        for (var tag in story.tags!) {
          tags = tags + '#${tag.name}  ';
        }
      }
      Share.shareFiles(
        [await Utility.createFileFromString(story.photo)],
        text: '*${story.title}*\n$tags\n$separation${story.text}\n\n_By ${story.author}_',
      );
      return;
    }
    Share.share(
      '*${story.title}*\n$tags\n$separation${story.text}\n\n_By ${story.author}_',
    );
  }

  @override
  void onInit() {
    super.onInit();
    getStories();
  }
}
