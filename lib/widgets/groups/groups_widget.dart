import 'package:flutter/material.dart';

class Groups extends StatelessWidget {
  const Groups({Key? key}) : super(key: key);

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
    return ListView.separated(
      itemBuilder: (_, i) => Dismissible(
        key: Key(i.toString()),
        direction: DismissDirection.endToStart,
        onDismissed: (_) {
          print("Delete");
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
      itemCount: 100,
    );
  }
}

class _Row extends StatelessWidget {
  final int index;
  const _Row({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('ToDo list go $index'),
      trailing: Icon(Icons.chevron_right),
      onTap: () {},
    );
  }
}
