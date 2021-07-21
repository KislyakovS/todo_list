import 'package:flutter/material.dart';
import 'package:todo_list/widgets/group_form/group_form_widget_model.dart';

import 'group_form/group_form_widget.dart';
import 'groups/groups_widget.dart';

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  final routes = {
    '/groups': (context) => const Groups(),
    '/groups/form': (context) => const GroupForm(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "ToDo List",
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/groups',
      routes: routes,
    );
  }
}
