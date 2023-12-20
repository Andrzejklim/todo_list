import 'package:flutter/material.dart';
import 'package:todo_list/list.dart';
import 'package:todo_list/todo_tiles.dart';

class ToDoHomePage extends StatefulWidget {
  const ToDoHomePage({super.key});

  @override
  State<ToDoHomePage> createState() => _ToDoHomePageState();
}

class _ToDoHomePageState extends State<ToDoHomePage> {
  final todoController = TextEditingController();
  final _focusNode = FocusNode();

  void addTodoToList() {
    setState(() {
      if (todoController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Input can not be empty")));
      } else {
        toDoList.add(todoController.text);
        _focusNode.unfocus();
      }
    });
    todoController.clear();
  }
  
  void dropTodoFromList(int index) {
    setState(() {
      print(index);
      toDoList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "My Todo List",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(children: [
          Center(
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    focusNode: _focusNode,
                    onEditingComplete: addTodoToList,
                    controller: todoController,
                    decoration: const InputDecoration(
                        hintText: "Add your task",
                        border: UnderlineInputBorder()),
                  ),
                ),
                SizedBox(
                  // height: double.infinity,
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          shape: const RoundedRectangleBorder()),
                      onPressed: () {
                        addTodoToList();
                      },
                      child: const Text("Add")),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 50,
          ),

          // *** LISTVIEW
          Expanded(
            child: ListView.builder(
              itemCount: toDoList.length,
              itemBuilder: (context, index) {
              String toDoItem = toDoList[index];

                return TodoTiles(index: index, label: todoController.text, toDoItem: toDoItem, dropTodoFromList: dropTodoFromList,);
              },
              // onReorder: (oldIndex, newIndex) {
              //   setState(() {
              //     if (oldIndex < newIndex) {
              //       newIndex -= 1;
              //     }
              //     final String item = toDoList.removeAt(oldIndex);
              //     toDoList.insert(newIndex, item);
              //   });
              // },
            ),
          )
          // *** LISTVIEW
        ]),
      ),
    );
  }
}
