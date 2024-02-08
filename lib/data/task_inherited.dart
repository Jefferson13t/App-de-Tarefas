import 'package:flutter/material.dart';
import 'package:teste_drive/components/task.dart';

class TaskInherited extends InheritedWidget {
  TaskInherited({
    Key? key,
    required Widget child,
  }) : super(key: key, child: child );

  final List<Task> taskList = [
      Task("Aprender Flutter", 'assets/images/flutter-mascot.png', 4),
      Task("Jogar", 'assets/images/kako-epifania.jpg', 0),
    ];

  void newTask(String name, String photo, int difficulty){
    taskList.add(Task(name, photo, difficulty));
  }

  static TaskInherited of(BuildContext context){
    final TaskInherited? result = context.dependOnInheritedWidgetOfExactType<TaskInherited>();
    assert(result != null, 'No TaskInherited found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(TaskInherited oldWidget){
    return oldWidget.taskList.length != taskList.length;
  }
}