import 'package:flutter/material.dart';
// import 'package:todo_list/list.dart';

class TodoTiles extends StatefulWidget {
  const TodoTiles(
      {super.key,
      required this.index,
      required this.label,
      required this.toDoItem,
      required this.dropTodoFromList,
      required this.modifyTodoList});

  final int index;
  final String label;
  final String toDoItem;
  final Function(int index) dropTodoFromList;
  final Function(int index, String label) modifyTodoList;

  @override
  State<TodoTiles> createState() => _TodoTilesState();
}

class _TodoTilesState extends State<TodoTiles> {
  final todoController = TextEditingController();
  // final _focusNode = FocusNode();
  bool isTextLinedThrough = false;
  int selectedIndex = 0;

  // void addTodoToList() {
  //   setState(() {
  //     if (todoController.text.isEmpty) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //           const SnackBar(content: Text("Input can not be empty")));
  //     } else {
  //       toDoList.add(widget.label);
  //       _focusNode.unfocus();
  //     }
  //   });
  //   todoController.clear();
  // }

  void lineThroughText(int index) {
    setState(() {
      print('selectedIndex: $selectedIndex');
      selectedIndex = index;
      isTextLinedThrough = !isTextLinedThrough;
    });
  }

  // @override
  // void dispose() {
  //   // Clean up the controller when the widget is removed from the
  //   // widget tree.
  //   todoController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    Color oddItemColor = Theme.of(context).colorScheme.inversePrimary;
    Color evenItemColor = Theme.of(context).colorScheme.onSecondary;

    return Padding(
      // key: Key('${widget.index}'),
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: widget.index.isOdd ? oddItemColor : evenItemColor,
        ),
        padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8, right: 0),
        child: Row(
          children: [
            Expanded(
              child: Text(widget.toDoItem,
                  style: TextStyle(
                    decoration:
                        selectedIndex == widget.index && isTextLinedThrough
                            ? TextDecoration.lineThrough
                            : null,
                  )),
            ),
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text("Make some modifications: "),
                    content: TextField(
                        controller: todoController,
                        decoration:
                            const InputDecoration(hintText: "add change")),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          widget.modifyTodoList(
                              widget.index, todoController.text);
                          Navigator.pop(context, 'OK');
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.edit),
            ),
            IconButton(
              onPressed: () {
                lineThroughText(widget.index);
              },
              icon: Icon(Icons.done,
                  color: selectedIndex == widget.index && isTextLinedThrough
                      ? Colors.green
                      : null),
            ),
            IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text("Deleting task"),
                  content: const Text("Are you sure you want to do this?"),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'NO'),
                      child: const Text('NO'),
                    ),
                    TextButton(
                      onPressed: () {
                        widget.dropTodoFromList(widget.index);
                        Navigator.pop(context, 'YES');
                      },
                      child: const Text('YES'),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
