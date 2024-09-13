class Task{
  late String title;
  late bool done;
  Task({required this.title,required this.done});


  @override
  bool operator ==(Object other) {
    if (other is Task) {
      return title == other.title;
    }
    return false;
  }
}
