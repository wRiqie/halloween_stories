class Tag {
  late int id;
  late int storyId;
  late String name;

  Tag({required this.id, required this.storyId, required this.name});

  Tag.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    storyId = map['storyId'];
    name = map['name'];
  }

  Map<String, dynamic> toMap(){
    Map<String, dynamic> data = {};
    data['storyId'] = storyId;
    data['name'] = name;
    return data;
  }
}