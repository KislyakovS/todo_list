import 'package:flutter/material.dart';
import 'package:todo_list/widgets/home.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "ToDo List",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Home(),
    );
  }
}
