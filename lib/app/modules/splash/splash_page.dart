import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:halloween_stories/app/core/theme/halloween/halloween_colors.dart';
import 'package:halloween_stories/app/core/values/halloween_images.dart';
import 'package:halloween_stories/app/modules/splash/splash_controller.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = Get.size;

    return Stack(
      children: [
        Scaffold(
          backgroundColor: HalloweenColors.primaryDark,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(0),
                width: size.width,
                height: size.height * .7,
                child: Image.asset(
                  HalloweenImages.pumpkins,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: size.width * .7,
                child: const Text(
                  '🎃 Spooky\nInteractive Story',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: HalloweenColors.white,
                    fontSize: 35,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: size.height * .7,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
              colors: [
                HalloweenColors.primaryDark.withOpacity(0.0),
                const Color(0xFF2B2E44),
              ],
              stops: const [
                0.75,
                1,
              ],
            ),
          ),
        ),
      ],
    );
  }
}
