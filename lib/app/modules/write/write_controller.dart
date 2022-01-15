import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:halloween_stories/app/core/theme/halloween/halloween_colors.dart';
import 'package:halloween_stories/app/data/model/story.dart';
import 'package:halloween_stories/app/data/repository/story_repository.dart';
import 'package:halloween_stories/app/routes/app_pages.dart';

class WriteController extends GetxController {
  final repository = Get.find<StoryRepository>();
  final titleController = TextEditingController();
  final textController = TextEditingController();
  final authorController = TextEditingController();
  final args = Get.arguments;
  Story? editingStory;

  void saveStory() async {
    if (titleController.text.isEmpty ||
        textController.text.isEmpty ||
        authorController.text.isEmpty) {
      Get.rawSnackbar(
        message: 'Hey, finish your story by filling in all the fields',
        backgroundColor: HalloweenColors.orange,
      );
      return;
    }
    int result = 0;
    if(editingStory != null){
      editingStory?.title = titleController.text;
      editingStory?.text = textController.text;
      editingStory?.author = authorController.text;
      result = await repository.updateStory(editingStory!);
    } else {
      Story story = Story(
      title: titleController.text,
      text: textController.text,
      author: authorController.text,
    );
      result = await repository.saveStory(story);
    }
    if (result != -1) {
        Get.offAllNamed(Routes.stories);
        return;
    }
    Get.rawSnackbar(
      message: 'Unable to save your story, please try again',
      backgroundColor: HalloweenColors.orange,
    );
  }

  @override
  void onInit() {
    super.onInit();
    if (args['isEditing'] == true) {
      editingStory = args['story'];
      titleController.text = editingStory?.title ?? '';
      textController.text = editingStory?.text ?? '';
      authorController.text = editingStory?.author ?? '';
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    textController.dispose();
    authorController.dispose();
    super.dispose();
  }
}
