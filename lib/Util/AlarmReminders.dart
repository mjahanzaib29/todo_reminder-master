import 'package:flutter/material.dart';
import 'package:todo_reminder/main.dart';
import 'package:todo_reminder/model/networkhandler.dart';
import 'package:todo_reminder/model/todoinfo.dart';

class MultiAlarm {

  Future<TodoInfo> _alltasks;
  NetworkHandler networkHandler = NetworkHandler();
  Future getAllAlarm() async {

    _alltasks = networkHandler.getTodolist();
    FutureBuilder<TodoInfo>(

      future:_alltasks,
      builder:(context, snapshot) {
        if(snapshot.hasData){
            List alarmnote = snapshot.data.todos.map((e) => e.work).toList();
            var alarmtime = snapshot.data.todos.map((e) => e.reminderTime);
            for(var i = 0 ; i<alarmnote.length ; i ++ ) {
              print("loooooop");
              print(alarmnote);
              // scheduleNotification();
            }
          return;
        }
        else{
          print("NODATA ON SNAPSHOT");
          return null;
        }
      },
    );
  }
}