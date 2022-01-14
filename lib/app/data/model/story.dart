class Story {
  late int id;
  late String title;
  late String text;
  late String author;

  Story({
    required this.title,
    required this.text,
    required this.author,
  });

  Story.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    text = map['text'];
    author = map['author'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = {};
    data['title'] = title;
    data['text'] = text;
    data['author'] = author;
    return data;
  }
}
