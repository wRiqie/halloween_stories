import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:halloween_stories/app/core/theme/halloween/halloween_colors.dart';
import 'package:halloween_stories/app/core/utils/utility.dart';
import 'package:halloween_stories/app/core/values/halloween_images.dart';
import 'package:halloween_stories/app/data/model/story.dart';
import 'package:halloween_stories/app/modules/stories/stories_controller.dart';
import 'package:halloween_stories/app/routes/app_pages.dart';
import 'package:share/share.dart';

class StoriesPage extends GetView<StoriesController> {
  const StoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = Get.size;

    return Scaffold(
      backgroundColor: HalloweenColors.primaryDark,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.write, arguments: {'isEditing': false});
        },
        child: const Icon(
          Icons.add,
          size: 36,
        ),
        backgroundColor: HalloweenColors.orange,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: size.height * .3,
                  child: Image.asset(
                    HalloweenImages.pumpkins,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  height: size.height * .3,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: FractionalOffset.topCenter,
                      end: FractionalOffset.bottomCenter,
                      colors: [
                        HalloweenColors.primaryDark.withOpacity(0),
                        const Color(0xFF2B2E44),
                      ],
                      stops: const [
                        0.7,
                        1,
                      ],
                    ),
                  ),
                ),
                Container(
                  height: size.height * .3,
                  color: HalloweenColors.primaryDark.withOpacity(0.7),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: SizedBox(
                    height: size.height * .3,
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '🎃\nSpooky\nInteractive\nStory',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: HalloweenColors.white,
                          fontSize: 35,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Stories',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: HalloweenColors.yellow,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Expanded(
              child: Obx(
                () => controller.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(
                        color: HalloweenColors.orange,
                      ))
                    : controller.stories.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: ListView.builder(
                                itemCount: controller.stories.length,
                                itemBuilder: (_, index) {
                                  return _buildStoryCard(
                                    context,
                                    controller.stories[index],
                                  );
                                }),
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 30,
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
                            ),
                          ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStoryCard(BuildContext context, Story story) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                controller.deleteStory(story.id);
              },
              backgroundColor: Colors.redAccent,
              foregroundColor: HalloweenColors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: Card(
          elevation: 2,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(6),
            ),
          ),
          color: HalloweenColors.primaryLight,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (_) {
                    return Wrap(
                      children: [
                        ListTile(
                            leading: const Icon(
                              Icons.edit,
                              color: HalloweenColors.orange,
                            ),
                            title: const Text('Edit'),
                            onTap: () {
                              Get.back();
                              Get.toNamed(
                                Routes.write,
                                arguments: {
                                  'isEditing': true,
                                  'story': story,
                                },
                              );
                            }),
                        ListTile(
                          leading: const Icon(
                            Icons.share,
                            color: HalloweenColors.orange,
                          ),
                          title: const Text('Share'),
                          onTap: () async {
                            Get.back();
                            if (story.photo.isNotEmpty) {
                              Share.shareFiles(
                                [
                                  await Utility.createFileFromString(
                                      story.photo)
                                ],
                                text:
                                    '*${story.title}*\n\n${story.text}\n\n_By ${story.author}_',
                              );
                              return;
                            }
                            Share.share(
                              '*${story.title}*\n\n${story.text}\n\n_By ${story.author}_',
                            );
                          },
                        ),
                      ],
                    );
                  });
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  constraints: const BoxConstraints(maxHeight: 200),
                  margin: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(6))),
                  child: story.photo.isEmpty
                      ? Image.asset(HalloweenImages.storyBg,
                          fit: BoxFit.contain)
                      : Utility.imageFromBase64String(story.photo),
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
                  maxLines: 2,
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
        ),
      ),
    );
  }
}
