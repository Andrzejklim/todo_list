import 'package:flutter/material.dart';
import 'package:todo_list/list.dart';

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
      toDoList.removeAt(index);
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    todoController.dispose();
    super.dispose();
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
          Expanded(
            child: ListView.builder(
              itemCount: toDoList.length,
              itemBuilder: (context, index) {
                String toDoItem = toDoList[index];
                Color oddItemColor =
                    Theme.of(context).colorScheme.inversePrimary;
                Color evenItemColor = Theme.of(context).colorScheme.onSecondary;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: index.isOdd ? oddItemColor : evenItemColor,
                    ),
                    padding: const EdgeInsets.only(
                        left: 8, top: 8, bottom: 8, right: 0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(toDoItem),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            dropTodoFromList(index);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ]),
      ),
    );
  }
}
