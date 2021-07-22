import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/domain/entity/group.dart';

class TasksWidgetModel extends ChangeNotifier {
  int groupKey;
  late final Group? _group;

  Group? get group => _group;

  TasksWidgetModel({required this.groupKey}) {
    _setup();
  }

  void _setup() async {
    _loadGroup();
  }

  void _loadGroup() async {
    final box = await Hive.openBox<Group>('groups_box');
    _group = box.get(groupKey);
    notifyListeners();
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
