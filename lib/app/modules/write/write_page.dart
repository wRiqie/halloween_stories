import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:halloween_stories/app/core/theme/halloween/halloween_colors.dart';
import 'package:halloween_stories/app/core/values/halloween_images.dart';
import 'package:halloween_stories/app/modules/write/write_controller.dart';

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
                onPressed: () {},
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
                    child: const TextField(
                      textCapitalization: TextCapitalization.sentences,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.multiline,
                      maxLines: 2,
                      decoration: InputDecoration.collapsed(
                        hintText: 'Story title',
                        hintStyle: TextStyle(
                          color: HalloweenColors.white,
                        ),
                      ),
                      style:
                          TextStyle(fontSize: 30, color: HalloweenColors.white),
                    ),
                  ),
                  const Expanded(
                    child: TextField(
                      textCapitalization: TextCapitalization.sentences,
                      scrollPhysics: BouncingScrollPhysics(),
                      textAlign: TextAlign.left,
                      keyboardType: TextInputType.multiline,
                      maxLines: 99999,
                      decoration: InputDecoration.collapsed(
                        hintText: 'Tell your story...',
                        hintStyle: TextStyle(
                          color: HalloweenColors.white,
                        ),
                      ),
                      style: TextStyle(
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
                      onPressed: () {},
                      child: const Text(
                        'Option Text',
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
