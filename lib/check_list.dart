import 'package:flutter/material.dart';

// class CheckList extends StatefulWidget {
//   @override
//   _CheckListState createState() => _CheckListState();
// }

// class _CheckListState extends State<CheckList> {
//   bool value = false;
//   // save data
//   final List<String> _todoList = <String>[];
//   // text field
//   final TextEditingController _textFieldController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xffd5e4e1),
//       appBar: AppBar(
//         title: const Text('Check List'),
//         backgroundColor: Color(0xff12928f),
//       ),
//       body: ListView(children: _getItems()),
//       floatingActionButton: FloatingActionButton(
//           onPressed: () => _displayDialog(context),
//           tooltip: 'Add Item',
//           child: Icon(Icons.add)),
//     );
//   }

//   void _addTodoItem(String title) {
//     // Wrapping it inside a set state will notify
//     // the app that the state has changed
//     setState(() {
//       _todoList.add(title);
//     });
//     _textFieldController.clear();
//   }

//   // this Generate list of item widgets
//   Widget _buildTodoItem(String title) {
//     return ListTile(
//       leading: Checkbox,
//       title: Text(title));
//     // return CheckboxListTile(
//     //   value: this.value,
//     //   onChanged: (bool? value) => {this.value = !value!},
//     //   title: Text(title,style: TextStyle(

//     //   ),),
//     );
//   }

//   // display a dialog for the user to enter items
//   Future<AlertDialog> _displayDialog(BuildContext context) async {
//     // alter the app state to show a dialog
//     return await showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: const Text('Add a task to your list'),
//             content: TextField(
//               controller: _textFieldController,
//               decoration: const InputDecoration(hintText: 'Enter task here'),
//             ),
//             actions: <Widget>[
//               // add button
//               FlatButton(
//                 child: const Text('ADD'),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                   _addTodoItem(_textFieldController.text);
//                 },
//               ),
//               // Cancel button
//               FlatButton(
//                 child: const Text('CANCEL'),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               )
//             ],
//           );
//         });
//   }

//   // iterates through our todo list title
//   List<Widget> _getItems() {
//     final List<Widget> _todoWidgets = <Widget>[];
//     for (String title in _todoList) {
//       _todoWidgets.add(_buildTodoItem(title));
//     }
//     return _todoWidgets;
//   }
// }

class TodoLIst extends StatefulWidget {
  @override
  _TodoLIstState createState() => _TodoLIstState();
}

class _TodoLIstState extends State<TodoLIst> {
  final TextEditingController _textFieldController = TextEditingController();
  final List<Todo> _todos = <Todo>[];
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Todo list'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        children: _todos.map((Todo todo) {
          return TodoItem(
            todo: todo,
            onTodoChanged: _handleTodoChange,
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => _displayDialog(),
          tooltip: 'Add Item',
          child: Icon(Icons.add)),
    );
  }

  Future<void> _displayDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add a new todo item'),
          content: TextField(
            controller: _textFieldController,
            decoration: const InputDecoration(hintText: 'Type your new todo'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                Navigator.of(context).pop();
                _addTodoItem(_textFieldController.text);
              },
            ),
          ],
        );
      },
    );
  }

  void _addTodoItem(String name) {
    setState(() {
      _todos.add(Todo(name: name, checked: false));
    });
    _textFieldController.clear();
  }

  void _handleTodoChange(Todo todo) {
    setState(() {
      todo.checked = !todo.checked;
    });
  }
}

class Todo {
  Todo({required this.name, required this.checked});
  final String name;
  bool checked;
}

class TodoItem extends StatelessWidget {
  TodoItem({
    required this.todo,
    required this.onTodoChanged,
  }) : super(key: ObjectKey(todo));

  final Todo todo;
  final onTodoChanged;

  TextStyle? _getTextStyle(bool checked) {
    if (!checked) return null;

    return TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onTodoChanged(todo);
      },
      leading: CircleAvatar(
        child: Text(todo.name[0]),
      ),
      title: Text(todo.name, style: _getTextStyle(todo.checked)),
    );
  }
}
