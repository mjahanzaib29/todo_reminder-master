import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_reminder/constant/pallete.dart';
import 'package:todo_reminder/constant/string_constant.dart';
import 'package:todo_reminder/model/categoryinfo.dart';
import 'package:todo_reminder/model/networkhandler.dart';
import 'package:todo_reminder/model/todoinfo.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({Key key}) : super(key: key);

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  DateTime dateTime;
  DateTime now1;
  var todoreminderIndex, SelectedWork;
  String EDnote, currentschedule, ReminderTime, EDTime;

  DateTime now = DateTime.now();
  String CurrentTimeForReminder, CategoryId;
  var selectedCat;
  final TextEditingController _currentdatetime = TextEditingController();
  final TextEditingController _selecteddate = TextEditingController();
  final TextEditingController _EditNote = TextEditingController();
  Future<TodoInfo> alltasks;
  Future<Welcome> _category;

  var tokenupdate;

  var Datetime;

  NetworkHandler networkHandler = NetworkHandler();
  Future<TodoInfo> _alltasks;

  @override
  Widget build(BuildContext context) {
    setState(() {
      _category = networkHandler.getcategoryfordropdown();
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
                      todoreminderIndex = snapshot.data.todos[index];
                      return GestureDetector(
                        onTap: () {
                          _editTodo(
                              context,
                              snapshot.data.todos[index].work,
                              snapshot.data.todos[index].reminderTime,
                              snapshot.data.todos[index].category);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Colors.grey[300]))),
                          child: ListTile(
                            title: Text(todoreminderIndex.work),
                            leading:
                                Text("ID: " + todoreminderIndex.id.toString()),
                            subtitle: Text("ReminderTime : " +
                                todoreminderIndex.reminderTime.toString()),
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

  Future<void> _editTodo(var ctx, var work, var reminder, var cat) async {
    return showDialog(
        context: ctx,
        builder: (ctx) {
          return AlertDialog(
            title: Text("Edit"),
            content: Column(
              children: [
                TextField(
                  // onChanged: (value) {
                  //   setState(() {
                  //     EDnote = value;
                  //   });
                  // },
                  controller: _EditNote..text = work,
                  decoration: InputDecoration(
                    labelText: "Name",
                  ),
                ),
                //For time and date
                TextField(
                  enabled: false,
                  controller: _selecteddate,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.calendar_today),
                    labelStyle: Pallete.khint,
                    labelText: getDateTime(),
                  ),
                ),
                //Pick time and date
                FlatButton(
                  color: Colors.red,
                  textColor: Colors.white,
                  child: Text('PickDateTime'),
                  onPressed: () => pickDateTime(context),
                ),
                Text("Select Cat"),
                FutureBuilder<Welcome>(
                    future: _category,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var catstring = snapshot.data.todos;
                        var catid = snapshot.data.todos.map((e) => e.id);
                        return DropdownButton<String>(
                          items: catstring.map((value) {
                            return new DropdownMenuItem(
                              value: value.id.toString(),
                              // child: new Text(value.name),
                              child: new Text(value.name),
                            );
                          }).toList(),
                          onChanged: (String newValue) {
                            setState(() {
                              CategoryId = newValue;
                              if (CategoryId != null) {
                                selectedCat = (CategoryId);
                              }
                            });
                          },
                          isExpanded: true,
                          value: selectedCat,
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    }),
              ],
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
                  print(_EditNote.text);
                  // codeDialog = valueText;
                  Navigator.pop(context);
                  // Catadd();
                },
              ),
            ],
          );
        });
  }

  String getDateTime() {
    print("GEt DATE TIME ");
    if (dateTime == null) {
      print("DT FAILED...........................");
      return 'Schedule ';
    } else {
      print("DT pass.....................");
      setState(() {
        now1 = DateTime.now();
        currentschedule = DateFormat('yyyy-MM-dd').format(now1);
        _currentdatetime.text = currentschedule;
        // CurrentTimeForReminder = DateFormat('yyyy-MM-dd').format(dateTime);
        ReminderTime = DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
        return ReminderTime;
      });

      // print(ReminderTime);
      // return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
    }
  }

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
