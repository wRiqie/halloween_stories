import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:halloween_stories/app/core/theme/halloween/halloween_colors.dart';
import 'package:halloween_stories/app/core/utils/utility.dart';
import 'package:halloween_stories/app/core/values/halloween_images.dart';
import 'package:halloween_stories/app/modules/write/write_controller.dart';
import 'package:badges/badges.dart';

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
                    title: 'Signature',
                    titleStyle: const TextStyle(color: HalloweenColors.light),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'Author',
                          textAlign: TextAlign.left,
                          style: TextStyle(fontFamily: 'RedHat'),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: controller.authorController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Your name here',
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
                      child: const Text(
                        'Save your story',
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
                      decoration: const InputDecoration.collapsed(
                        hintText: 'Story title',
                        hintStyle: TextStyle(
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
                      decoration: const InputDecoration.collapsed(
                        hintText: 'Tell your story...',
                        hintStyle: TextStyle(
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
                        Get.defaultDialog(
                                      titlePadding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 5),
                                      title: 'Story Photo',
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
                                        child: const Text(
                                          'Swap Photo',
                                        ),
                                      ),
                                    );
                      },
                      child: const Text(
                        'Photo',
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
