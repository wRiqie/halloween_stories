import 'package:get/get.dart';
import 'package:halloween_stories/app/modules/splash/splash_binding.dart';
import 'package:halloween_stories/app/modules/splash/splash_page.dart';
import 'package:halloween_stories/app/modules/stories/stories_binding.dart';
import 'package:halloween_stories/app/modules/stories/stories_page.dart';
import 'package:halloween_stories/app/modules/write/write_binding.dart';
import 'package:halloween_stories/app/modules/write/write_page.dart';
part './app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.splash,
      page: () => const SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.stories,
      page: () => const StoriesPage(),
      binding: StoriesBinding(),
    ),
    GetPage(
      name: Routes.write,
      page: () => const WritePage(),
      binding: WriteBinding(),
      transition: Transition.circularReveal 
    ),
  ];
}
