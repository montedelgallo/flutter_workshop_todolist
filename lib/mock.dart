import 'package:flutter/material.dart';

class Todo {
  final int id;
  final String title;
  final String description;
  final bool isCompleted;

  const Todo({this.id, this.title, this.description, this.isCompleted});
}

class MenuEntry {
  static const String add = 'Add Todo';
  static const List<String> choices = <String>[add];
}

class TodoRemix {
  String _test;

  String get() => _test;

  void set(String test) => _test = test;
}
