import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:halloween_stories/app/core/theme/halloween/halloween_colors.dart';
import 'package:halloween_stories/app/data/model/story.dart';
import 'package:halloween_stories/app/data/repository/story_repository.dart';
import 'package:halloween_stories/app/routes/app_pages.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class WriteController extends GetxController {
  final imgSource = ImageSource.gallery;
  final repository = Get.find<StoryRepository>();
  final titleController = TextEditingController();
  final textController = TextEditingController();
  final authorController = TextEditingController();
  final args = Get.arguments;
  final storyPhoto = ''.obs;
  
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
    if (editingStory != null) {
      editingStory?.title = titleController.text;
      editingStory?.text = textController.text;
      editingStory?.author = authorController.text;
      editingStory?.photo = storyPhoto.value;
      result = await repository.updateStory(editingStory!);
    } else {
      Story story = Story(
        title: titleController.text,
        text: textController.text,
        author: authorController.text,
        photo: storyPhoto.value,
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

  swapPhoto() async {
    final pickedFile = await ImagePicker().pickImage(source: imgSource);

    if (pickedFile != null) {
      final imgFile = File(pickedFile.path);

      File? imgCropped = await cropImage(imgFile);
      if (imgCropped != null) {
        List<int> imgBytes = imgCropped.readAsBytesSync();
        storyPhoto.value = base64Encode(imgBytes);
      }
    }
  }

  cropImage(File img) async {
    var imgCropped = await ImageCropper.cropImage(
      sourcePath: img.path,
      androidUiSettings: const AndroidUiSettings(
        toolbarTitle: 'Edit Photo',
        toolbarColor: HalloweenColors.orange,
        toolbarWidgetColor: HalloweenColors.light,
        backgroundColor: HalloweenColors.primaryDark,
        hideBottomControls: true,
      ),
    );

    if (imgCropped != null) {
      return imgCropped;
    }
    return null;
  }

  @override
  void onInit() {
    super.onInit();
    if (args['isEditing'] == true) {
      editingStory = args['story'];
      storyPhoto.value = editingStory?.photo ?? '';
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
