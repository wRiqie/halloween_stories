import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:halloween_stories/app/core/theme/halloween/halloween_colors.dart';
import 'package:halloween_stories/app/core/values/halloween_images.dart';
import 'package:halloween_stories/app/data/model/story.dart';
import 'package:halloween_stories/app/modules/stories/stories_controller.dart';
import 'package:halloween_stories/app/routes/app_pages.dart';

class StoriesPage extends GetView<StoriesController> {
  const StoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = Get.size;

    return Scaffold(
      backgroundColor: HalloweenColors.primaryDark,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.write);
        },
        child: const Icon(
          Icons.add,
          size: 36,
        ),
        backgroundColor: HalloweenColors.orange,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                children: const [
                  Text(
                '🎃 Spooky\nInteractive Story',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: HalloweenColors.white,
                  fontSize: 35,
                ),
              ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              const Text(
                'Stories',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: HalloweenColors.yellow,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Expanded(
                child: Obx(() => controller.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(
                        color: HalloweenColors.orange,
                      ))
                    : controller.stories.isNotEmpty
                        ? ListView.builder(
                            itemCount: controller.stories.length,
                            itemBuilder: (_, index) {
                              return _buildStoryCard(controller.stories[index]);
                            })
                        : Column(
                            children: [
                              const SizedBox(
                                height: 80,
                              ),
                              SizedBox(
                                height: size.height * .2,
                                child: Image.asset(
                                  HalloweenImages.witch,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                '🧟 Try adding a story\nto make you shiver...',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: HalloweenColors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStoryCard(Story story) {
    return Card(
      elevation: 2,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(6),
        ),
      ),
      color: HalloweenColors.primaryLight,
      child: InkWell(
        onTap: () {},
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: const EdgeInsets.all(6),
              height: 130,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(6))),
              child: Image.asset(
                HalloweenImages.storyBg,
                fit: BoxFit.fill,
              ),
            ),
            Text(
              story.author,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: HalloweenColors.light,
                  fontFamily: 'RedHat',
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w300),
            ),
            Text(
              story.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: HalloweenColors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Tag line',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: HalloweenColors.white,
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
