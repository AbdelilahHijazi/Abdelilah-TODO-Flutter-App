import 'package:flutter/material.dart';
import 'package:tasks_notebook_project/todo_list_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scrollBehavior: const ScrollBehavior(
        // ignore: deprecated_member_use
        androidOverscrollIndicator: AndroidOverscrollIndicator.stretch,
      ),
      title: 'Daily Tasks Abdelilah NoteBook',
      theme: ThemeData(
        primaryColor: Colors.blue,
        dialogBackgroundColor: Colors.white,
        cardColor: Colors.white,
        shadowColor: const Color.fromARGB(255, 150, 215, 245),
        fontFamily: 'Amaranth',
      ),
      home: const TodoListScreen(),
    );
  }
}
