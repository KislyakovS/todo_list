import 'package:flutter/material.dart';

import 'groups_widget_model.dart';

class Groups extends StatefulWidget {
  const Groups({Key? key}) : super(key: key);

  @override
  _GroupsState createState() => _GroupsState();
}

class _GroupsState extends State<Groups> {
  final _model = GroupWidgetModel();

  @override
  Widget build(BuildContext context) {
    return GroupWidgetModelProvider(
      child: _Body(),
      model: _model,
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Groups'),
      ),
      body: _GroupList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/groups/form');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class _GroupList extends StatefulWidget {
  const _GroupList({Key? key}) : super(key: key);

  @override
  __GroupListState createState() => __GroupListState();
}

class __GroupListState extends State<_GroupList> {
  @override
  Widget build(BuildContext context) {
    final model = GroupWidgetModelProvider.watch(context)?.model;

    return ListView.separated(
      itemBuilder: (_, i) => Dismissible(
        key: Key(model?.groups[i].name ?? i.toString()),
        direction: DismissDirection.endToStart,
        onDismissed: (_) {
          model?.remove(i);
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
      itemCount: model?.groups.length ?? 0,
    );
  }
}

class _Row extends StatelessWidget {
  final int index;
  const _Row({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = GroupWidgetModelProvider.read(context)?.model;

    return ListTile(
      title: Text(model?.groups[index].name ?? ''),
      trailing: Icon(Icons.chevron_right),
      onTap: () => model?.showTasks(context, index),
    );
  }
}
