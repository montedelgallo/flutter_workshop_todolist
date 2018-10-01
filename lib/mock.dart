import 'package:flutter/material.dart';


class Todo {
  final String title;
  final String description;
  const Todo({this.title,this.description});

}

class TodoCard extends Card {

  TodoCard(Todo contact) :
        super(
          child: new Column(children: <Widget>[
            new ListTile(title : new Text(contact.title),
                subtitle: new Text(contact.description),
                leading: const Icon(Icons.album)),
            new ButtonTheme.bar( // make buttons use the appropriate styles for cards
              child: new ButtonBar(
                children: <Widget>[
                  new FlatButton(
                    child: const Text('Mark as Done'),
                    onPressed:,
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
    todos.add(new Todo(title:"Todos $i", description:"Description $i"));
  }

  return todos;
}
