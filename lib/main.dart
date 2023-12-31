import 'package:flutter/material.dart';
import 'package:todo_list/todo_home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'app',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.deepPurple,
              onSecondary: const Color.fromARGB(255, 157, 113, 245)),
          useMaterial3: true,
          textTheme: const TextTheme(
              titleLarge:
                  TextStyle(fontSize: 35, fontWeight: FontWeight.bold))),
      home: const ToDoHomePage(),
    );
  }
}
