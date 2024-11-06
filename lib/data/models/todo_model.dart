class TodoDM {
  static const String collectionName = 'Tasks';
  String? title;
  String? description;
  bool? isDone;
  String? id;
  DateTime? dateTime;

  TodoDM({
    this.title,
    this.description,
    this.id,
    this.dateTime,
    this.isDone = false,
  });

  TodoDM.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    id = json['id'];
    isDone = json['isDone'];
    dateTime = json['dateTime'].toDate();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'title': title,
      'isDone': isDone,
      'dateTime': dateTime,
    };
  }
}
