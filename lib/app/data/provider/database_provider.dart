import 'package:halloween_stories/app/data/model/story.dart';
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
        await db.execute(_createTableUser);
      },
      onCreate: (Database db, int version) async {},
    );
  }

  // Stories
  static const storyTable = 'story';
  static const storyId = 'id';
  static const storyTitle = 'title';
  static const storyText = 'text';
  static const storyAuthor = 'author';

  final _createTableUser = """
      CREATE TABLE IF NOT EXISTS $storyTable (
        $storyId INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        $storyTitle TEXT,
        $storyText TEXT,
        $storyAuthor TEXT
      );
  """;

  Future<int> saveStory(Story story) async {
    final db = await database;
    if(db != null){
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
      return stories;
    }
    return [];
  }

  Future<int> deleteStory(int id) async {
    final db = await database;
    if(db != null){
      return db.delete(storyTable, where: '$storyId = ?', whereArgs: [id]);
    }
    return -1;
  }
}
