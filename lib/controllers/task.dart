import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/task.dart';
import 'package:flutter_application_2/shared/shared.dart';
import 'package:flutter_application_2/shared/task.dart';

void search(value, isChecked) {
  if (!isChecked) {
    filterdTasks = tasks
        .where((element) => element.name
            .toString()
            .toLowerCase()
            .contains(value.toString().toLowerCase()))
        .toList();
  } else {
    filterdTasks = finishedTasks
        .where((element) => element.name
            .toString()
            .toLowerCase()
            .contains(value.toString().toLowerCase()))
        .toList();
  }

  if (filterdTasks.isEmpty && !showSnakBar) {
    showSnakBar = true;
    ScaffoldFeatureController scaffoldFeatureController =
        ScaffoldMessenger.of(navigatorKey.currentState!.context).showSnackBar(
      const SnackBar(
        content: Text('There is no data found'),
      ),
    );

    scaffoldFeatureController.closed.then((onValue) {
      showSnakBar = false;
    });
  }
  taskStreamController.sink.add("update Task");
}

void updateTaskData(Task oldTask, Task newTask) {
  int index = tasks.indexOf(oldTask);
  tasks.removeAt(index);
  tasks.insert(index, newTask);
  taskStreamController.sink.add("update Task");
}

void deleteTask(Task task) {
  int index = tasks.indexOf(task);
  index != -1 ? tasks.removeAt(index) : null;
  index = finishedTasks.indexOf(task);
  index != -1 ? finishedTasks.removeAt(index) : null;
  taskStreamController.sink.add("update Task");
}

void finishedTask(Task task) {
  int index = tasks.indexOf(task);
  finishedTasks.add(task);
  tasks.removeAt(index);
  taskStreamController.sink.add("update Task");
}
