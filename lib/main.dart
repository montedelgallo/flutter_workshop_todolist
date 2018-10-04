import 'package:flutter/material.dart';
import 'mock.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Workshop TodoList',
      initialRoute: '/',
      routes: {
        // When we navigate to the "/" route, build the MyHomePage Widget
        '/': (context) => MyHomePage(title: "Todos")
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  static _MyHomePageState of(BuildContext context) =>
      context.ancestorStateOfType(const TypeMatcher<_MyHomePageState>());

  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Todo> _current;
  PersistentBottomSheetController<Null> _bottomSheet;

  @override
  void initState() {
    super.initState();
    _current = [];
  }

  void _add(String title, String description) {
    setState(() {
      Todo todo = Todo(
          id: _current.length,
          title: title,
          description: description,
          isCompleted: false);
      _current.add(todo);
      _bottomSheet.close();
    });
  }

  void _showConfigurationSheet() {
    TextEditingController titleController = TextEditingController();
    TextEditingController descrController = TextEditingController();

    final PersistentBottomSheetController<Null> bottomSheet = _scaffoldKey
        .currentState
        .showBottomSheet((BuildContext bottomSheetContext) {
      return Container(
        height: 200.0,
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Colors.black26)),
        ),
        child: ListView(
          shrinkWrap: true,
          primary: false,
          padding: EdgeInsets.fromLTRB(16.0, 2.0, 16.0, 2.0),
          children: <Widget>[
            TextField(controller: titleController),
            TextField(controller: descrController),
            ButtonBar(
              children: <Widget>[
                FlatButton(
                    child: Text(
                      "Add Todo",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      _add(titleController.text, descrController.text);
                    })
              ],
            )
          ],
        ),
      );
    });

    setState(() {
      _bottomSheet = bottomSheet;
    });

    _bottomSheet.closed.whenComplete(() {
      if (mounted) {
        setState(() {
          _bottomSheet = null;
        });
      }
    });
  }

  void choiceAction(String choice) {
    if (choice == MenuEntry.add) {
      _showConfigurationSheet();
    }
  }

  void markAsDone(Todo todo) {
    setState(() {
      _current[todo.id] = Todo(
          id: todo.id,
          title: todo.title,
          description: todo.description,
          isCompleted: true);
    });
  }

  Widget _buildTodoItem(Todo todo) {
    if (!todo.isCompleted) {
      return Card(
          child: Column(
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
      return Card(
          child: Column(
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

  Widget _buildTodoList() {
    return ListView.builder(
        itemBuilder: (context, index) {
          return _buildTodoItem(_current[index]);
        },
        itemCount: _current.length);
  }

  @override
  Widget build(BuildContext context) {
    print("current lenght" + _current.length.toString());

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title:  Text("Flutter BottomSheet"),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: choiceAction,
            itemBuilder: (BuildContext context) {
              return MenuEntry.choices.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: _buildTodoList(),
      ),
    );
  }
}
