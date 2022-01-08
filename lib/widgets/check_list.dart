import 'package:flutter/material.dart';

class TodoLIst extends StatefulWidget {
  @override
  _TodoLIstState createState() => _TodoLIstState();
}

class _TodoLIstState extends State<TodoLIst>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController _textFieldController = TextEditingController();
  final List<Todo> _todos = <Todo>[
    Todo(name: 'Ticket', checked: false),
    Todo(name: 'Passport', checked: false),
    Todo(name: 'Id Proof', checked: false),
    Todo(name: 'Mask & Shield', checked: false),
    Todo(name: 'Sanitizer', checked: false),
    Todo(name: 'Luggage under 15kg', checked: false),
    Todo(name: 'HandBag under 7kg', checked: false),
  ];
  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color(0xffd5e4e1),
      appBar: new AppBar(
        backgroundColor: Color(0xff12928f),
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

  bool get wantKeepAlive => true;
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
