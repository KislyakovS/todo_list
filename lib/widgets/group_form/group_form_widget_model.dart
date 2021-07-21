import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/domain/entity/group.dart';

class GroupFormWidgetModel {
  var value = '';

  void save(BuildContext context) async {
    if (value.isEmpty) return;

    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(GroupAdapter());
    }

    final box = await Hive.openBox<Group>('groups_box');
    final group = Group(name: value);

    box.add(group);

    Navigator.of(context).pop();
  }
}

class GroupFormWidgetModelProvider extends InheritedWidget {
  final GroupFormWidgetModel model;

  const GroupFormWidgetModelProvider(
      {Key? key, required Widget child, required this.model})
      : super(key: key, child: child);

  static GroupFormWidgetModelProvider? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<GroupFormWidgetModelProvider>();
  }

  static GroupFormWidgetModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<GroupFormWidgetModelProvider>()
        ?.widget;

    return widget is GroupFormWidgetModelProvider ? widget : null;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}
