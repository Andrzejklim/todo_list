import 'package:flutter/material.dart';
import 'package:todo_list/list.dart';

class TodoTiles extends StatefulWidget {
  const TodoTiles(
      {super.key,
      required this.index,
      required this.label,
      required this.toDoItem,
      required this.dropTodoFromList});

  final int index;
  final String label;
  final String toDoItem;
  final Function(int index) dropTodoFromList;

  @override
  State<TodoTiles> createState() => _TodoTilesState();
}

class _TodoTilesState extends State<TodoTiles> {
  final todoController = TextEditingController();
  final _focusNode = FocusNode();
  bool isTextLinedThrough = false;
  int selectedIndex = -1;

  void addTodoToList() {
    setState(() {
      if (todoController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Input can not be empty")));
      } else {
        toDoList.add(widget.label);
        _focusNode.unfocus();
      }
    });
    todoController.clear();
  }

  void lineThroughText(int index) {
    setState(() {
      print('selectedIndex: $selectedIndex');
      selectedIndex = index;
      isTextLinedThrough = !isTextLinedThrough;
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
              onPressed: () {},
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
              onPressed: () {
                widget.dropTodoFromList(widget.index);
              },
            ),
          ],
        ),
      ),
    );
  }
}
