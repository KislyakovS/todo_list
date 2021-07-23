import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/domain/entity/group.dart';
import 'package:todo_list/domain/entity/task.dart';

class TasksWidgetModel extends ChangeNotifier {
  int groupKey;
  late final Group? _group;
  var _tasks = <Task>[];

  List<Task> get tasks => _tasks.toList();
  Group? get group => _group;

  TasksWidgetModel({required this.groupKey}) {
    _setup();
  }

  void _setup() async {
    _loadGroup();
    _readTasks();
    _tasksListener();
  }

  void _loadGroup() async {
    final box = await Hive.openBox<Group>('groups_box');
    _group = box.get(groupKey);
    notifyListeners();
  }

  void _tasksListener() async {
    final box = await Hive.openBox<Group>('groups_box');
    box.listenable(keys: [groupKey]).addListener(_readTasks);
  }

  void _readTasks() {
    _tasks = _group?.tasks as List<Task>;
    notifyListeners();
  }

  void deleteTask(int taskIndex) {
    _group?.tasks!.deleteFromHive(taskIndex);
  }
}

class TasksWidgetModelPrivate extends InheritedNotifier {
  final TasksWidgetModel model;

  TasksWidgetModelPrivate(
      {Key? key, required Widget child, required this.model})
      : super(key: key, notifier: model, child: child);

  static TasksWidgetModelPrivate? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<TasksWidgetModelPrivate>();
  }

  static TasksWidgetModelPrivate? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<TasksWidgetModelPrivate>()
        ?.widget;

    return widget is TasksWidgetModelPrivate ? widget : null;
  }
}
