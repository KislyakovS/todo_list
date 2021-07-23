import 'package:flutter/material.dart';
import 'package:todo_list/widgets/task_form/task_form_model.dart';

class TaskForm extends StatefulWidget {
  const TaskForm({Key? key}) : super(key: key);

  @override
  _TaskFormState createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  TaskFormWidgetModel? _model;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_model == null) {
      final groupKey = ModalRoute.of(context)?.settings.arguments as int;
      _model = TaskFormWidgetModel(groupKey: groupKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    final model = _model;

    if (model != null) {
      return TaskFormWidgetModelProvider(
        child: _Body(),
        model: model,
      );
    }

    return Scaffold(
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
    final model = TaskFormWidgetModelProvider.read(context)?.model;

    return Scaffold(
      appBar: AppBar(
        title: Text('New Task'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: _Form(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => model?.save(context),
        child: Icon(Icons.done),
      ),
    );
  }
}

class _Form extends StatelessWidget {
  const _Form({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = TaskFormWidgetModelProvider.read(context)?.model;

    return TextField(
      autofocus: true,
      maxLines: null,
      minLines: null,
      expands: true,
      decoration: InputDecoration(hintText: '"New Task"'),
      onChanged: (value) => model?.value = value,
      onEditingComplete: () => model?.save(context),
    );
  }
}
