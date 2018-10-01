import 'package:flutter/material.dart';


class Todo {
  final int id;
  final String title;
  final String description;
  final Function onDone;
  const Todo({this.id,this.title,this.description,this.onDone});

}

class TodoCard extends Card {

  TodoCard(Todo todo) :
        super(
          child: new Column(children: <Widget>[
            new ListTile(title : new Text(todo.title),
                subtitle: new Text(todo.description),
                leading: const Icon(Icons.album)),
            new ButtonTheme.bar( // make buttons use the appropriate styles for cards
              child: new ButtonBar(
                children: <Widget>[
                  new FlatButton(
                    child: const Text('Mark as Done'),
                    onPressed:todo.onDone,
                  ),
                ],
              ),
            )
          ],),
      );
}

List<Todo> getCards(int dimension) {
  List<Todo> todos = [];

  for (int i = 0; i < dimension; i++) {

    todos.add(
        new Todo(
            id:i,
            title:"Todos $i",
            description:"Description $i",
            onDone: (){

              print("call api for id:$i");

            }));
  }

  return todos;
}
