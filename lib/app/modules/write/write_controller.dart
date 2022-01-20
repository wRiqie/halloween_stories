import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:halloween_stories/app/core/theme/halloween/halloween_colors.dart';
import 'package:halloween_stories/app/data/model/story.dart';
import 'package:halloween_stories/app/data/model/tag.dart';
import 'package:halloween_stories/app/data/repository/story_repository.dart';
import 'package:halloween_stories/app/data/repository/tag_repository.dart';
import 'package:halloween_stories/app/routes/app_pages.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class WriteController extends GetxController {
  final imgSource = ImageSource.gallery;
  final repository = Get.find<StoryRepository>();
  final tagRepository = Get.find<TagRepository>();
  final titleController = TextEditingController();
  final textController = TextEditingController();
  final authorController = TextEditingController();
  final args = Get.arguments;
  final storyPhoto = ''.obs;
  List<Tag> tags = [];

  Story? editingStory;

  void saveStory() async {
    if (titleController.text.isEmpty ||
        textController.text.isEmpty ||
        authorController.text.isEmpty) {
      Get.rawSnackbar(
        message: 'incomplete_story_alert'.tr,
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
      for (var tag in tags) {
        tag.storyId = editingStory?.id ?? 0;
      }
      await tagRepository.saveTags(tags);
    } else {
      Story story = Story(
        title: titleController.text,
        text: textController.text,
        author: authorController.text,
        photo: storyPhoto.value,
        tags: [],
      );
      result = await repository.saveStory(story);
      for (var tag in tags) {
        tag.storyId = result;
      }
      await tagRepository.saveTags(tags);
    }
    if (result != -1) {
      Get.offAllNamed(Routes.stories);
      Get.rawSnackbar(
          message: 'save_success'.tr,
          backgroundColor: HalloweenColors.primaryLight);
      return;
    }
    Get.rawSnackbar(
      message: 'error_save'.tr,
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
      androidUiSettings: AndroidUiSettings(
        toolbarTitle: 'edit_photo'.tr,
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

  addTags() async {
    var res = await Get.toNamed(
      Routes.tags,
      arguments: {'tags': tags},
    );
    if(res != null){
      tags = res['tags'];
    }
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
      tags = editingStory?.tags ?? [];
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
