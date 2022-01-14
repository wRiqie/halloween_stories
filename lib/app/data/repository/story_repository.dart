import 'package:halloween_stories/app/data/model/story.dart';
import 'package:halloween_stories/app/data/provider/database_provider.dart';

class StoryRepository {
  final db = DatabaseProvider.db;
  
  Future<int> saveStory(Story story)
    => db.saveStory(story);

  Future<List<Story>> getStories()
    => db.getStories();

  Future<int> deleteStory(int id)
    => db.deleteStory(id);
}
