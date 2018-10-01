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
//  List<TodoCard> _cardRepository = [];

//  void _refresh() {
//    List<TodoCard> _tmp = [];
//    getCards(5).forEach((f) => _tmp.add(TodoCard(f)));
//
//    setState(() {
//      _cardRepository.addAll(_tmp);
//    });
//  }

  List<Todo> _tmp = getCards(5);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new ListView.builder(itemBuilder: (BuildContext c,int index){
        return new TodoCard(_tmp[index]);
      },itemCount: _tmp.length,),
      floatingActionButton: new FloatingActionButton(
        onPressed:  null,
        tooltip: 'Refresh',
        child: new Icon(Icons.refresh),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
