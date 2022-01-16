import 'package:halloween_stories/app/data/model/tag.dart';
import 'package:halloween_stories/app/data/provider/database_provider.dart';

class TagRepository {
  final db = DatabaseProvider.db;

  Future<int> saveTag(Tag tag)
    => db.saveTag(tag);

  Future<List<Tag>> getTags(int storyId)
    => db.getTags(storyId);

  Future<int> deleteTag(int id)
    => db.deleteTag(id);

  Future<int> deleteTags(int storyId)
    => db.deleteTags(storyId);
}