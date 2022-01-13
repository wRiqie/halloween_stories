import 'package:halloween_stories/app/data/model/story.dart';

class StoryRepository {
  Future<List<Story>> getStories() {
    return Future.delayed(
        const Duration(
          seconds: 3,
        ), () {
      return [
        Story(
          id: 1,
          title: 'scary friday the 13th',
          text: 'In a very dark night...',
          author: 'wRiqie',
        ),
      ];
    });
  }
}
