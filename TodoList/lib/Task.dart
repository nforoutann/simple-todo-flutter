class Task{
  late String title;
  late bool done;
  Task({required this.title,required this.done});

  factory Task.fromJson(Map<String, dynamic> jsonMap){
    return Task(
        title: jsonMap['title'],
        done: jsonMap['done']
    );
  }


  @override
  bool operator ==(Object other) {
    if (other is Task) {
      return title == other.title;
    }
    return false;
  }
}
