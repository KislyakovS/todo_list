import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/domain/entity/group.dart';

class GroupWidgetModel extends ChangeNotifier {
  var _groups = <Group>[];

  List<Group> get groups => _groups.toList();

  GroupWidgetModel() {
    _setup();
  }

  void _read(Box<Group> box) {
    _groups = box.values.toList();

    notifyListeners();
  }

  void _setup() async {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(GroupAdapter());
    }

    final box = await Hive.openBox<Group>('groups_box');

    _read(box);

    box.listenable().addListener(() => _read(box));
  }

  void remove(int index) async {
    final box = await Hive.openBox<Group>('groups_box');

    box.deleteAt(index);

    _read(box);
  }
}

class GroupWidgetModelProvider extends InheritedNotifier {
  final GroupWidgetModel model;

  const GroupWidgetModelProvider(
      {Key? key, required Widget child, required this.model})
      : super(key: key, notifier: model, child: child);

  static GroupWidgetModelProvider? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<GroupWidgetModelProvider>();
  }

  static GroupWidgetModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<GroupWidgetModelProvider>()
        ?.widget;

    return widget is GroupWidgetModelProvider ? widget : null;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}
