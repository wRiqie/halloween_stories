import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:halloween_stories/app/core/theme/halloween/halloween_colors.dart';
import 'package:halloween_stories/app/core/values/halloween_images.dart';
import 'package:halloween_stories/app/data/model/tag.dart';
import 'package:halloween_stories/app/modules/tags/tags_controller.dart';

class TagsPage extends GetView<TagsController> {
  const TagsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = Get.size;

    return Scaffold(
      backgroundColor: HalloweenColors.primaryDark,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'addTags'.tr,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              TextField(
                controller: controller.tagsController,
                onSubmitted: (value) {
                  controller.addTag();
                },
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: controller.addTag,
                    icon: const Icon(
                      Icons.add,
                      color: HalloweenColors.light,
                    ),
                  ),
                  label: const Text('Tag'),
                  prefixIcon: const Icon(Icons.tag),
                  hintText: 'tagHint'.tr,
                ),
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(
                height: 30,
              ),
              Obx(() => Expanded(
                      child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Wrap(
                      direction: Axis.horizontal,
                      children: controller.tags
                          .map(
                            (e) => InkWell(
                              onLongPress: () {
                                controller.removeTag(e);
                              },
                              child: _buildTag(e),
                            ),
                          )
                          .toList(),
                    ),
                  ))),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: size.width,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: controller.confirm,
                    child: Text('confirm'.tr),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTag(Tag tag) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: HalloweenColors.orange,
      ),
      child: Text(
        tag.name,
        style: const TextStyle(color: HalloweenColors.primaryDark),
      ),
    );
  }
}
