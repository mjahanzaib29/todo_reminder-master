import 'package:flutter/material.dart';
import 'package:todo_reminder/screens/categories.dart';
import 'package:todo_reminder/screens/home.dart';
import 'package:todo_reminder/screens/task.dart';

class RouteLinks {
  static List<Widget> routelinks = [
    Home(),
    TaskPage(),
    Categories_page(),
  ];
}
