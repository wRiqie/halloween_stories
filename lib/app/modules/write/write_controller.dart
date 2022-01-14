import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:halloween_stories/app/data/model/story.dart';
import 'package:halloween_stories/app/data/repository/story_repository.dart';
import 'package:halloween_stories/app/routes/app_pages.dart';

class WriteController extends GetxController {
  final repository = Get.find<StoryRepository>();
  final titleController = TextEditingController();
  final textController = TextEditingController();
  final authorController = TextEditingController();

  void saveStory() async {
    // TODO validação de textos
    Story story = Story(
      title: titleController.text,
      text: textController.text,
      author: authorController.text,
    );
    int result = await repository.saveStory(story);
    if(result != -1){
      Get.offAllNamed(Routes.stories);
      return;
    }
    Get.rawSnackbar(message: 'Unable to save your story, please try again');
  }

  @override
  void dispose() {
    titleController.dispose();
    textController.dispose();
    authorController.dispose();
    super.dispose();
  }
}
