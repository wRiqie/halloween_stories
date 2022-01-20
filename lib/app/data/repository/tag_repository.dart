import 'package:halloween_stories/app/data/model/tag.dart';
import 'package:halloween_stories/app/data/provider/database_provider.dart';

class TagRepository {
  final db = DatabaseProvider.db;

  Future<int> saveTags(List<Tag> tags)
    => db.saveTags(tags);

  Future<List<Tag>> getTags(int storyId)
    => db.getTags(storyId);

  Future<int> deleteTag(int id)
    => db.deleteTag(id);

  Future<int> deleteSelectedTags(List<int> tagsId)
    => db.deleteSelectedTags(tagsId);

  Future<int> deleteTags(int storyId)
    => db.deleteTags(storyId);
}