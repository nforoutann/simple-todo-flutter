import 'package:flutter/material.dart';
import 'package:todo/Task.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My todo list',
      home: TodoScreen(),
    );
  }
}

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  // Moved the task list to the StatefulWidget
  List<Task> tasks = [
    Task(title: 'hello world', done: false),
    Task(title: 'have a good day', done: true),
    Task(title: 'the university is started', done: false),
    Task(title: 'check your emails', done: false),
    Task(title: 'do your hw', done: true),
    Task(title: 'hang out with your friends', done: false),
    Task(title: 'do not forget your ap assignment', done: false),
    Task(title: 'read your book', done: true),
  ];

  // Function to add a new task
  void _addNewTask(String taskTitle) {
    setState(() {
      tasks.add(Task(title: taskTitle, done: false));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        margin: EdgeInsets.only(right: 20, bottom: 10),
        child: FloatingActionButton(
          onPressed: () {
            TextEditingController taskTitle = TextEditingController();
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Create New Task'),
                  content: TextField(
                    decoration: const InputDecoration(hintText: 'Enter task title'),
                    controller: taskTitle,
                  ),
                  actions: [
                    TextButton(
                      child: const Text('Cancel'),
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog
                      },
                    ),
                    TextButton(
                      child: const Text('Create'),
                      onPressed: () {
                        if (taskTitle.text.isNotEmpty && !tasks.contains(Task(title: taskTitle.text, done: false))){
                          _addNewTask(taskTitle.text); // Add the new task
                        }
                        Navigator.of(context).pop(); // Close the dialog
                      },
                    ),
                  ],
                );
              },
            );
          },
          backgroundColor: Colors.indigoAccent,
          elevation: 4.0,
          shape: CircleBorder(),
          child: const Icon(
            Icons.add,
            size: 37,
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Center(
          child: Text(
            'Todo List',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
              fontStyle: FontStyle.italic
            ),
          ),
        ),
      ),
      backgroundColor: const Color(0xFF131315),
      body: TodoList(tasks: tasks),
    );
  }
}

class TodoList extends StatefulWidget {
  final List<Task> tasks;
  TodoList({super.key, required this.tasks});

  @override
  State<TodoList> createState() => _TodoListState(tasks: tasks);
}

class _TodoListState extends State<TodoList> {
  List<Task> tasks;
  _TodoListState({required this.tasks});

  @override
  Widget build(BuildContext context) {
    var doneTasks = tasks.where((task) => task.done).toList();
    var undoneTasks = tasks.where((task) => !task.done).toList();
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: undoneTasks.length,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                margin: const EdgeInsets.only(right: 10, left: 10, top: 8, bottom: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          undoneTasks[index].title,
                          style: const TextStyle(
                              fontSize: 18,
                              fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          onPressed: () {
                            setState(() {
                              tasks.add(Task(title: undoneTasks[index].title, done: true));
                              tasks.remove(undoneTasks[index]);
                            });
                          },
                          icon: const Icon(
                            Icons.check_circle_rounded,
                            color: Colors.green,
                          ),
                        ),
                        IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          onPressed: () {
                            setState(() {
                              tasks.remove(undoneTasks[index]);
                            });
                          },
                          icon: const Icon(
                            Icons.cancel_rounded,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
          if(doneTasks.length != 0)...{
            Container(
              margin: EdgeInsets.all(7),
              child: const Text(
                'Done Tasks',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w900
                ),
              ),
            ),
          },
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: doneTasks.length,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                margin: const EdgeInsets.only(right: 10, left: 10, top: 8, bottom: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          doneTasks[index].title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () {
                        setState(() {
                          tasks.remove(doneTasks[index]);
                        });
                      },
                      icon: const Icon(
                        Icons.cancel_rounded,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
