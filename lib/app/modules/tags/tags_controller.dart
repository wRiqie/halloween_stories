import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:halloween_stories/app/data/model/tag.dart';
import 'package:halloween_stories/app/data/repository/tag_repository.dart';

class TagsController extends GetxController {
  final TagRepository repository = Get.find<TagRepository>();
  final args = Get.arguments;
  final tags = <Tag>[].obs;
  final tagsController = TextEditingController();

  addTag() {
    if(tagsController.text.removeAllWhitespace.isNotEmpty){
      tags.add(Tag(id: 0, storyId: 0, name: tagsController.text.trim()));
      tagsController.text = '';
    }
  }

  removeTag(Tag tag) {
    tags.remove(tag);
    if(tag.id != 0){
      repository.deleteTag(tag.id);
    }
  }

  confirm() {
    if(tags.isNotEmpty){
      Get.back(
      result: {
        'tags': tags
      },
    );
    }
  }

  @override
  void onInit() {
    super.onInit();
    if(args['tags'].isNotEmpty){
      tags.value = args['tags']; 
    }
  }

  @override
  void dispose() {
    super.dispose();
    tagsController.dispose();
  }
}