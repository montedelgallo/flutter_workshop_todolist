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

  void _markAsDone() {
    setState(() {});
  }

  Widget _buildTodoItem(Todo todo) {
    return new Card(
        child: new Column(
      children: <Widget>[
        ListTile(title: Text(todo.title), subtitle: Text(todo.description)),
        ButtonBar(
          children: <Widget>[
            FlatButton(
              child: Text("Mark as completed"),
              onPressed: _markAsDone,
            )
          ],
        )
      ],
    ));
  }

  

  void _addTodoItem() {
    setState(() {
      int index = _todoItems.length;
      _todoItems.add(
          new Todo(id: index, title: "task", description: "description"));
    });
  }

  Widget _buildTodoList() {
    return new ListView.builder(
      itemBuilder: (context, index) {
        // itemBuilder will be automatically be called as many times as it takes for the
        // list to fill up its available space, which is most likely more than the
        // number of todo items we have. So, we need to check the index is OK.
        if (index < _todoItems.length) {
          return _buildTodoItem(_todoItems[index]);
        }
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
