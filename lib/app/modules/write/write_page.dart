import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:halloween_stories/app/core/theme/halloween/halloween_colors.dart';
import 'package:halloween_stories/app/core/utils/utility.dart';
import 'package:halloween_stories/app/core/values/halloween_images.dart';
import 'package:halloween_stories/app/modules/write/write_controller.dart';
import 'package:badges/badges.dart';
import 'package:halloween_stories/app/routes/app_pages.dart';

class WritePage extends GetView<WriteController> {
  const WritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = Get.size;

    return Stack(
      children: [
        SizedBox(
          height: size.height,
          child: Image.asset(
            HalloweenImages.writeBg,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          height: size.height,
          color: HalloweenColors.primaryDark.withOpacity(0.95),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Image.asset(HalloweenImages.arrowBack),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Get.defaultDialog(
                    titlePadding: const EdgeInsets.symmetric(vertical: 5),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    title: 'signature'.tr,
                    titleStyle: const TextStyle(color: HalloweenColors.light),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'author'.tr,
                          textAlign: TextAlign.left,
                          style: const TextStyle(fontFamily: 'RedHat'),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: controller.authorController,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            hintText: 'your_name'.tr,
                          ),
                          style: const TextStyle(
                            fontSize: 16,
                            fontFamily: 'RedHat',
                          ),
                        )
                      ],
                    ),
                    confirm: ElevatedButton(
                      onPressed: () {
                        controller.saveStory();
                      },
                      child: Text(
                        'save'.tr,
                      ),
                    ),
                  );
                },
                icon: Image.asset(HalloweenImages.share),
              ),
            ],
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 23),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    width: size.width * .8,
                    height: size.height * .1,
                    child: TextField(
                      controller: controller.titleController,
                      textCapitalization: TextCapitalization.sentences,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.multiline,
                      maxLines: 2,
                      decoration: InputDecoration.collapsed(
                        hintText: 'story_title'.tr,
                        hintStyle: const TextStyle(
                          color: HalloweenColors.white,
                        ),
                      ),
                      style: const TextStyle(
                          fontSize: 30, color: HalloweenColors.white),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: controller.textController,
                      textCapitalization: TextCapitalization.sentences,
                      scrollPhysics: const BouncingScrollPhysics(),
                      textAlign: TextAlign.left,
                      keyboardType: TextInputType.multiline,
                      maxLines: 99999,
                      decoration: InputDecoration.collapsed(
                        hintText: 'tell_story'.tr,
                        hintStyle: const TextStyle(
                          color: HalloweenColors.white,
                        ),
                      ),
                      style: const TextStyle(
                        fontSize: 18,
                        fontFamily: 'RedHat',
                        color: HalloweenColors.white,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (_) {
                            return Wrap(
                              children: [
                                ListTile(
                                    leading: const Icon(
                                      Icons.tag,
                                      color: HalloweenColors.orange,
                                    ),
                                    title: const Text('Add Tags'),
                                    onTap: () {
                                      Get.back();
                                      controller.addTags();
                                    }),
                                ListTile(
                                  leading: const Icon(
                                    Icons.photo,
                                    color: HalloweenColors.orange,
                                  ),
                                  title: const Text('Story Photo'),
                                  onTap: () {
                                    Get.back();
                                    Get.defaultDialog(
                                      titlePadding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 5),
                                      title: 'story_photo'.tr,
                                      titleStyle: const TextStyle(
                                          color: HalloweenColors.light),
                                      content: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          GestureDetector(
                                            onTap: controller.swapPhoto,
                                            child: Obx(
                                              () => Container(
                                                color:
                                                    HalloweenColors.primaryDark,
                                                height: 200,
                                                width: 200,
                                                child: controller.storyPhoto
                                                        .value.isEmpty
                                                    ? Image.asset(
                                                        HalloweenImages.storyBg,
                                                        fit: BoxFit.contain,
                                                      )
                                                    : Utility
                                                        .imageFromBase64String(
                                                        controller
                                                            .storyPhoto.value,
                                                      ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      confirm: TextButton(
                                        onPressed: controller.swapPhoto,
                                        child: Text(
                                          'swap_photo'.tr,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: const Text(
                        'More',
                        style: TextStyle(
                          fontFamily: 'RedHat',
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            HalloweenColors.primaryLight),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
