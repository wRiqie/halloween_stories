import 'package:halloween_stories/app/data/model/tag.dart';

class Story {
  late int id;
  late String title;
  late String text;
  late String author;
  late String photo;
  List<Tag>? tags;

  Story({
    required this.title,
    required this.text,
    required this.author,
    required this.photo,
    required this.tags,
  });

  Story.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    text = map['text'];
    author = map['author'];
    photo = map['photo'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = {};
    data['title'] = title;
    data['text'] = text;
    data['author'] = author;
    data['photo'] = photo;
    return data;
  }
}
