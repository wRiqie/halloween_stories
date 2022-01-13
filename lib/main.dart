import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:halloween_stories/app/core/theme/halloween/halloween_theme.dart';
import 'package:halloween_stories/app/modules/splash/splash_binding.dart';
import 'package:halloween_stories/app/routes/app_pages.dart';
import 'package:flutter/services.dart';

import 'app/modules/stories/stories_binding.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) {
      runApp(const MyApp());
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: AppPages.pages,
      initialRoute: Routes.splash,
      initialBinding: SplashBinding(),
      theme: halloweenThemeData,
      defaultTransition: Transition.fadeIn,
    );
  }
}
