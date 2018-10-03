import 'package:flutter/material.dart';
import 'mock.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {


    List<String> titles = ["Home","AddTodo"];
    List<Todo> _todoItems = [];
    GlobalKey<_MyHomePageState> mainKey = new GlobalKey();
    List<GlobalKey> keys =[mainKey];
    AppState state = new AppState(titles: titles,list: _todoItems,keys: keys);


    return new MaterialApp(
      title: 'Workshop TodoList',
      initialRoute: '/',
      routes: {
        // When we navigate to the "/" route, build the MyHomePage Widget
        '/': (context) => MyHomePage(state: state)
      },
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class AddTodo extends StatefulWidget{

  AddTodo({Key key, this.state}) : super(key: key);

  final AppState state;

  _AddTodo createState() => _AddTodo();

}

class _AddTodo extends State<AddTodo> {


  Widget _build(BuildContext context) {
    return new Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(),
            TextField(),
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  child: Text("Done"),
                  onPressed: (){

                      Todo t = new Todo(id:widget.state.list.length,title:"test",description: "test",isCompleted: false);
                      MyHomePage.of(context).addTodoItem(t);
                  },
                ),
                FlatButton(
                  child: Text("Back"),
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        "/", (Route<dynamic> route) => false);
                  },
                )
              ],
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Add Todo"),
        ),
        body:
        _build(context) // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class MyHomePage extends StatefulWidget {

  static _MyHomePageState of(BuildContext context) => context.ancestorStateOfType(const TypeMatcher<_MyHomePageState>());

  MyHomePage({Key key, this.state}) : super(key: key);

  final AppState state;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {



  List<Todo> _local;

  @override
  void initState() {
    super.initState();
    _local=widget.state.list;

  }

  void markAsDone(Todo todo) {
    setState(() {
      _local[todo.id] = new Todo(
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



  void addTodoItem(Todo todo) {

     setState(() {

       widget.state.list.add(todo);

     });

  }

  Widget _buildTodoList() {
    return new ListView.builder(
      itemCount: _local.length,
      itemBuilder: (context, index) {
        return _buildTodoItem(widget.state.list[index]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.state.titles[0]),
      ),
      body: _buildTodoList(),
      floatingActionButton: new FloatingActionButton(
        onPressed: (){Navigator.of(context)
            .pushAndRemoveUntil(new MaterialPageRoute(
            builder: (BuildContext context)=>new AddTodo(state:widget.state))
            , (Route<dynamic> route) => false);},
        tooltip: 'Refresh',
        child: new Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }


}
