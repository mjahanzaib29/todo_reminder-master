import 'package:flutter/material.dart';
import 'package:todo_reminder/constant/pallete.dart';
import 'package:todo_reminder/constant/string_constant.dart';
import 'package:todo_reminder/model/networkhandler.dart';
import 'package:todo_reminder/model/todoinfo.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({Key key}) : super(key: key);

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  String EDnote;
  final TextEditingController _addcategoryname = TextEditingController();
  NetworkHandler networkHandler = NetworkHandler();
  Future<TodoInfo> _alltasks;

  @override
  Widget build(BuildContext context) {
    setState(() {
      _alltasks = networkHandler.getTodolist();
    });
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        leading: IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.red,
            ),
            onPressed: () {}),
        title: Text(
          StringConstants.title,
          style: TextStyle(
              color: Pallete.bgColor,
              fontSize: 25,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Align(
        alignment: Alignment.center,
        child: Column(
          children: [
            Expanded(
                child: FutureBuilder<TodoInfo>(
              future: _alltasks,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data.todos.length,
                    itemBuilder: (context, index) {
                      var todoreminder = snapshot.data.todos[index];
                      return Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom:
                                BorderSide(color: Colors.grey[300]))),
                        child: Dismissible(
                          background: Container(
                            color: Colors.red,
                          ),
                          key: ValueKey(index),
                          onDismissed: (direction) {
                            setState(() {
                              snapshot.data.todos.removeAt(index);
                            });
                          },
                          child: ListTile(
                            onTap: () => _editTodo(context),
                            title: Text(todoreminder.work),
                            leading: Text("ID: " + todoreminder.id.toString()),
                            subtitle: Text(
                                "ReminderTime : " + todoreminder.reminderTime.toString()),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ))
          ],
        ),
      ),
    );
  }

  Future<void> _editTodo (BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(' '),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  EDnote = value;
                });
              },
              controller: _addcategoryname,
              decoration: InputDecoration(hintText: "Name"),
            ),
            actions: <Widget>[
              FlatButton(
                color: Colors.red,
                textColor: Colors.white,
                child: Text('CANCEL'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              FlatButton(
                color: Pallete.bgColor,
                textColor: Colors.white,
                child: Text('ADD'),
                onPressed: () {
                  pickDateTime();
                  setState(() {
                    codeDialog = valueText;
                    Navigator.pop(context);
                  });
                  Catadd();
                },
              ),
            ],
          );
        });
  }



  //////////
  Future pickDateTime(BuildContext context) async {
    final date = await pickDate(context);
    if (date == null) return;

    final time = await pickTime(context);
    if (time == null) return;

    setState(() {
      dateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  Future<DateTime> pickDate(BuildContext context) async {
    final initialDateNow = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: initialDateNow,
      firstDate: initialDateNow.subtract(Duration(days: 0)),
      lastDate: DateTime(DateTime.now().year + 5),
    );

    if (newDate == null) return null;

    return newDate;
  }

  Future<TimeOfDay> pickTime(BuildContext context) async {
    final initialTime = TimeOfDay(hour: 9, minute: 0);
    final newTime = await showTimePicker(
      context: context,
      initialTime: dateTime != null
          ? TimeOfDay(hour: dateTime.hour, minute: dateTime.minute)
          : initialTime,
    );

    if (newTime == null) return null;

    return newTime;
  }
}
