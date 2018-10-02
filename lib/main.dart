import 'package:flutter/material.dart';
import 'mock.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Workshop TodoList',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Workshop TodoList'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Todo> _todoItems = [];

  void markAsDone(Todo todo) {
    setState(() {
      _todoItems[todo.id] = new Todo(
          id: todo.id,
          title: todo.title,
          description: todo.description,
          isCompleted: true);
    });
  }

  Widget _buildTodoItem(Todo todo) {
    if (!todo.isCompleted) {
      return new Card(
          child: new Column(
        children: <Widget>[
          ListTile(title: Text(todo.title), subtitle: Text(todo.description)),
          ButtonBar(
            children: <Widget>[
              FlatButton(
                child: Text("Mark as done"),
                onPressed: () => markAsDone(todo),
              )
            ],
          )
        ],
      ));
    } else {
      return new Card(
          child: new Column(
        children: <Widget>[
          ListTile(
              title: Text(
                todo.title,
                style: TextStyle(
                    color: Colors.grey, decoration: TextDecoration.lineThrough),
              ),
              subtitle: Text(
                todo.description,
                style: TextStyle(
                    color: Colors.grey, decoration: TextDecoration.lineThrough),
              )),
          ButtonBar(
            children: <Widget>[
              FlatButton(
                child: Text("Mark as completed"),
                onPressed: null,
              )
            ],
          )
        ],
      ));
    }
  }

  void _addTodoItem() {
    setState(() {
      int index = _todoItems.length;
      _todoItems
          .add(new Todo(id: index, title: "task", description: "description",isCompleted: false));
    });
  }

  Widget _buildTodoList() {
    return new ListView.builder(
      itemCount: _todoItems.length,
      itemBuilder: (context, index) {
        return _buildTodoItem(_todoItems[index]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: _buildTodoList(),
      floatingActionButton: new FloatingActionButton(
        onPressed: _addTodoItem,
        tooltip: 'Refresh',
        child: new Icon(Icons.refresh),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
