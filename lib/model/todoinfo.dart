// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);
//https://app.quicktype.io/

import 'dart:convert';

TodoInfo todoinfoFromJson(String str) => TodoInfo.fromJson(json.decode(str));

String todoinfoToJson(TodoInfo data) => json.encode(data.toJson());

class TodoInfo {
  TodoInfo({
    this.status,
    this.todos,
  });

  bool status;
  List<Todo> todos;

  factory TodoInfo.fromJson(Map<String, dynamic> json) => TodoInfo(
    status: json["status"],
    todos: List<Todo>.from(json["todos"].map((x) => Todo.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "todos": List<dynamic>.from(todos.map((x) => x.toJson())),
  };
}

class Todo {
  Todo({
    this.id,
    this.currentDate,
    this.work,
    this.reminderTime,
    this.isCompleted,
    this.categoryId,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.category,
  });

  int id;
  DateTime currentDate;
  String work;
  DateTime reminderTime;
  String isCompleted;
  int categoryId;
  int userId;
  DateTime createdAt;
  DateTime updatedAt;
  Category category;

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
    id: json["id"],
    currentDate: DateTime.parse(json["currentDate"]),
    work: json["work"],
    reminderTime: DateTime.parse(json["reminderTime"]),
    isCompleted: json["isCompleted"],
    categoryId: json["categoryId"],
    userId: json["userId"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    category: Category.fromJson(json["category"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "currentDate": "${currentDate.year.toString().padLeft(4, '0')}-${currentDate.month.toString().padLeft(2, '0')}-${currentDate.day.toString().padLeft(2, '0')}",
    "work": work,
    "reminderTime": reminderTime.toIso8601String(),
    "isCompleted": isCompleted,
    "categoryId": categoryId,
    "userId": userId,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "category": category.toJson(),
  };
}

class Category {
  Category({
    this.id,
    this.name,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String name;
  int userId;
  DateTime createdAt;
  DateTime updatedAt;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    userId: json["userId"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "userId": userId,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}
