import 'package:flutter/material.dart';

import 'model/todo.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final List<Todo> todos = [];
  final List<TextEditingController> controllers = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // app 머리
      // body 가슴
      // bottomNavigationBar / bottomsheet 다리
      appBar: AppBar(
        title: const Text("Flutter TODO"),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: todos.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Row(children: [
                  IconButton(
                      onPressed: () {
                        setState(() {
                          todos[index].isComplete = !todos[index].isComplete;
                        });
                      },
                      icon: todos[index].isComplete
                          ? Icon(Icons.check_circle_outlined)
                          : Icon(Icons.circle_outlined)),
                  if (todos[index].isEditing) ...[
                    Expanded(
                        child: TextField(
                      controller: controllers[index],
                      onChanged: (value) {
                        todos[index].text = value;
                      },
                    )),
                  ] else ...[
                    Expanded(
                        child: Text(
                      todos[index].text,
                      style: TextStyle(
                          fontSize: 18.0,
                          color: todos[index].isComplete
                              ? Colors.grey
                              : Colors.black,
                          decoration: todos[index].isComplete
                              ? TextDecoration.lineThrough
                              : TextDecoration.none),
                    )),
                  ],
                  IconButton(
                      onPressed: () {
                        setState(() {
                          todos[index].isEditing = !todos[index].isEditing;

                          controllers[index].text = todos[index].text;
                        });
                      },
                      icon: todos[index].isEditing
                          ? Icon(Icons.check)
                          : Icon(Icons.edit)),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          todos.removeAt(index);
                        });
                      },
                      icon: Icon(Icons.delete)),
                ]),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              todos.add(Todo(text: DateTime.now().toString()));
              controllers.add(TextEditingController());
            });
          },
          child: Icon(Icons.add)),
    );
  }
}
