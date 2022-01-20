import 'package:halloween_stories/app/data/model/story.dart';
import 'package:halloween_stories/app/data/model/tag.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  DatabaseProvider._();
  static final DatabaseProvider db = DatabaseProvider._();

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDB();
    return _database;
  }

  initDB() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'spooky.db');
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) async {
        await db.execute(_createTableStory);
        await db.execute(_createTableTag);
      },
      onCreate: (Database db, int version) async {
        await db.execute(_createTableStory);
        await db.execute(_createTableTag);
      },
    );
  }

  // Stories
  static const storyTable = 'story';
  static const storyId = 'id';
  static const storyTitle = 'title';
  static const storyText = 'text';
  static const storyAuthor = 'author';
  static const storyPhoto = 'photo';

  final _createTableStory = """
      CREATE TABLE IF NOT EXISTS $storyTable (
        $storyId INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        $storyTitle TEXT,
        $storyText TEXT,
        $storyAuthor TEXT,
        $storyPhoto TEXT
      );
  """;

  Future<int> saveStory(Story story) async {
    final db = await database;
    if (db != null) {
      var res = await db.insert(storyTable, story.toMap());
      return res;
    }
    return -1;
  }

  Future<List<Story>> getStories() async {
    final db = await database;
    if (db != null) {
      var res = await db.query(storyTable);
      List<Story> stories = res.isNotEmpty
          ? res.map((story) => Story.fromMap(story)).toList()
          : [];
      await Future.forEach<Story>(stories, (e) async {
        var tags = await getTags(e.id);
        e.tags = tags;
      });
      return stories;
    }
    return [];
  }

  Future<int> deleteStory(int id) async {
    final db = await database;
    if (db != null) {
      return db.delete(storyTable, where: '$storyId = ?', whereArgs: [id]);
    }
    return -1;
  }

  Future<int> updateStory(Story story) async {
    final db = await database;
    if (db != null) {
      var res = await db.update(storyTable, story.toMap(),
          where: '$storyId = ?', whereArgs: [story.id]);
      return res;
    }
    return -1;
  }

  // Tags
  static const tagTable = 'tag';
  static const tagId = 'id';
  static const tagName = 'name';
  static const tagStoryId = 'storyId';

  final _createTableTag = """
      CREATE TABLE IF NOT EXISTS $tagTable (
        $tagId INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        $tagName TEXT,
        $tagStoryId INTEGER
      );
  """;

  Future<int> saveTags(List<Tag> tags) async {
    final db = await database;
    if (db != null) {
      for (var tag in tags) {
        await db.insert(
          tagTable,
          tag.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
      return 0;
    }
    return -1;
  }

  Future<List<Tag>> getTags(int storyId) async {
    final db = await database;
    if (db != null) {
      var res = await db
          .query(tagTable, where: '$tagStoryId = ?', whereArgs: [storyId]);
      List<Tag> tags =
          res.isNotEmpty ? res.map((tag) => Tag.fromMap(tag)).toList() : [];
      return tags;
    }
    return [];
  }

  Future<int> deleteTag(int id) async {
    final db = await database;
    if (db != null) {
      return db.delete(tagTable, where: '$tagId = ?', whereArgs: [id]);
    }
    return -1;
  }

  Future<int> deleteTags(int storyId) async {
    final db = await database;
    if (db != null) {
      return db
          .delete(tagTable, where: '$tagStoryId = ?', whereArgs: [storyId]);
    }
    return -1;
  }
}
