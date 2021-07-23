import 'package:flutter/material.dart';

import 'tasks_model.dart';

class TasksWidget extends StatefulWidget {
  const TasksWidget({Key? key}) : super(key: key);

  @override
  _TaskState createState() => _TaskState();
}

class _TaskState extends State<TasksWidget> {
  TasksWidgetModel? _model;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_model == null) {
      final groupKey = ModalRoute.of(context)!.settings.arguments as int;
      _model = TasksWidgetModel(groupKey: groupKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    final model = _model;

    if (model != null) {
      return TasksWidgetModelPrivate(child: _Body(), model: model);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Tasks'),
      ),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = TasksWidgetModelPrivate.watch(context)?.model;

    return Scaffold(
      appBar: AppBar(
        title: Text(model?.group?.name ?? 'Tasks'),
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .pushNamed('/groups/tasks/form', arguments: model!.groupKey);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class _GroupList extends StatefulWidget {
  const _GroupList({Key? key}) : super(key: key);

  @override
  __TasksListState createState() => __TasksListState();
}

class __TasksListState extends State<_GroupList> {
  @override
  Widget build(BuildContext context) {
    final model = TasksWidgetModelPrivate.watch(context)?.model;

    return ListView.separated(
      itemBuilder: (_, i) => Dismissible(
        key: Key(model?.tasks[i].text ?? i.toString()),
        direction: DismissDirection.endToStart,
        onDismissed: (_) {
          model?.deleteTask(i);
        },
        background: Container(
          color: Colors.red,
          child: Row(
            children: [
              Spacer(),
              Icon(
                Icons.delete,
                color: Colors.white,
              ),
              const SizedBox(width: 20)
            ],
          ),
        ),
        child: _Row(
          index: i,
        ),
      ),
      separatorBuilder: (_, i) => const Divider(
        height: 1,
      ),
      itemCount: model?.tasks.length ?? 0,
    );
  }
}

class _Row extends StatelessWidget {
  final int index;
  const _Row({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = TasksWidgetModelPrivate.read(context)?.model;

    return ListTile(
      title: Text(model?.tasks[index].text ?? ''),
      trailing: Icon(Icons.chevron_right),
      // onTap: () => model?.showTasks(context, index),
    );
  }
}
