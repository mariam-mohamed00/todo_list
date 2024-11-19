class Task {
  String? id;
  String? title;
  String? description;
  DateTime? dateTime;
  bool? isDone;

  Task(
      {this.id = '',
      required this.title,
      required this.description,
      required this.dateTime,
      this.isDone = false});

  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dateTime': dateTime!.microsecondsSinceEpoch,
      'isDone': isDone
    };
  }

  Task.fromFireStore(Map<String, dynamic> data)
      : this(
          id: data['id'],
          title: data['title'],
          description: data['description'],
          dateTime: DateTime.fromMicrosecondsSinceEpoch(data['dateTime']) ,
          isDone: data['isDone'],
        );
}
