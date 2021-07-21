import 'package:flutter/material.dart';
import 'package:todo_list/widgets/group_form/group_form_widget_model.dart';

class GroupForm extends StatefulWidget {
  const GroupForm({Key? key}) : super(key: key);

  @override
  _GroupFormState createState() => _GroupFormState();
}

class _GroupFormState extends State<GroupForm> {
  final _model = GroupFormWidgetModel();

  @override
  Widget build(BuildContext context) {
    return GroupFormWidgetModelProvider(child: const _Body(), model: _model);
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = GroupFormWidgetModelProvider.read(context)?.model;

    return Scaffold(
      appBar: AppBar(
        title: Text('New Group'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: _Form(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => model?.save(),
        child: Icon(Icons.done),
      ),
    );
  }
}

class _Form extends StatelessWidget {
  const _Form({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = GroupFormWidgetModelProvider.read(context)?.model;

    return TextField(
      autofocus: true,
      decoration: InputDecoration(hintText: '"New Group"'),
      onChanged: (value) => model?.value = value,
      onEditingComplete: () => model?.save(),
    );
  }
}
