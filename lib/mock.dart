

import 'package:flutter/material.dart';

class Todo {
  final int id;
  final String title;
  final String description;
  final bool isCompleted;

  const Todo({this.id, this.title, this.description, this.isCompleted});

}

class AppState {

  final List<Todo> list;
  final List<String> titles;
  final List<GlobalKey> keys;
  const AppState({this.list,this.titles,this.keys});

}


