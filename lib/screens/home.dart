import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_reminder/Util/sharedprefs.dart';
import 'package:todo_reminder/constant/pallete.dart';
import 'package:todo_reminder/constant/string_constant.dart';
import 'package:intl/intl.dart';
import 'package:todo_reminder/model/categoryinfo.dart';
import 'package:todo_reminder/model/networkhandler.dart';
import 'package:todo_reminder/model/todoinfo.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  NetworkHandler networkHandler = NetworkHandler();
  DateTime now = DateTime.now();
  DateTime now1;
  DateTime dateTime;
  String ReminderTime, CurrentTimeForReminder, currentschedule, CategoryId;
  var selectedCat;
  final TextEditingController _currentdatetime = TextEditingController();
  final TextEditingController _note = TextEditingController();
  final TextEditingController _selecteddate = TextEditingController();
  // final TextEditingController _selectedtime = TextEditingController();
  // final TextEditingController _category = TextEditingController();
  Future<TodoInfo> alltasks;
  var tokenupdate;

  FirebaseMessaging _messaging = FirebaseMessaging.instance;

  @override
  void initState() {
    notificationPermission();
    super.initState();
  }
  void getToken() async {
    try {
      var fetchedtoken = await _messaging.getToken();
      print("this is FCM token  " + await _messaging.getToken());
      Map<String, String> token = {
        "token": fetchedtoken,
      };
      tokenupdate = networkHandler.FCMToken(token);
    } catch (error) {
      print("this is token error " + error.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    NetworkHandler networkHandler = NetworkHandler();
    Future<Welcome> _category;
    getToken();

    setState(() {
      _category = networkHandler.getcategoryfordropdown();
      alltasks = networkHandler.getTodolist();
    });
    Size size = MediaQuery.of(context).size;

    // String formattedDate = DateFormat('kk:mm:ss \n EEE d MMM').format(now);
    String currentday = DateFormat('d').format(now);
    String formattedDate =
        DateFormat('kk:mm \n EEE MMM ').format(now); // 02:43 mon dec
    // this is current year:month:day

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
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 2),
                child: Container(
                  // height: size.height ,
                  // decoration: BoxDecoration(
                  //   color: Colors.white,
                  //   borderRadius: BorderRadius.circular(25),
                  //   boxShadow: [
                  //     BoxShadow(
                  //       color: Pallete.bgColor.withOpacity(0.5),
                  //       spreadRadius: 5,
                  //       blurRadius: 7,
                  //       offset: Offset(0, 3), // changes position of shadow
                  //     ),
                  //   ],
                  // ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RotatedBox(
                              quarterTurns: 4,
                              child: Text(
                                currentday,
                                style: GoogleFonts.dancingScript(fontSize: 45),
                              ),
                            ),
                            Text(
                              formattedDate,
                              style: GoogleFonts.montserrat(fontSize: 20),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextField(
                          // onChanged: (content)
                          // {
                          //   _note.text = content;
                          // },
                          controller: _note,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.notes),
                            labelStyle: Pallete.khint,
                            labelText: "Remind me for",
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _selecteddate,
                                enabled: false,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.calendar_today),
                                  labelStyle: Pallete.khint,
                                  labelText: getDateTime(),
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () => pickDateTime(context),
                              child: Text('PickDateTime'),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Text("Select Categories"),
                            FutureBuilder<Welcome>(
                                future: _category,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    var catstring = snapshot.data.todos;
                                    var catid =
                                        snapshot.data.todos.map((e) => e.id);
                                    return DropdownButton<String>(
                                      items: catstring.map((value) {
                                        return new DropdownMenuItem(
                                          value: value.id.toString(),
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
                                    return Center(
                                        child: CircularProgressIndicator());
                                  }
                                }),
                          ],
                        ),
                        Column(
                          children: [
                            FutureBuilder<TodoInfo>(
                              future: alltasks,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  List alarmnote = snapshot.data.todos
                                      .map((e) => e.work)
                                      .toList();
                                  List alarmtime = (snapshot.data.todos.map(
                                          (e) => e.reminderTime.toString()))
                                      .toList();
                                  // String time = DateFormat('yyyy-MM-dd HH:mm').format(alarmtime);
                                  print(
                                      "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
                                  print(alarmnote);
                                  var i = 0;
                                  String time;
                                  for (var item in alarmnote) {
                                    i = ++i % alarmnote.length;
                                    time = alarmtime[i].toString();
                                    // scheduleNotification(time, item);
                                  }
                                  return Container();
                                } else {
                                  print("NODATA ON SNAPSHOT");
                                  return Container();
                                }
                              },
                            )
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 15),
                          width: size.width,
                          decoration: new BoxDecoration(
                            border: Border.all(
                              color: Pallete.bgColor,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                          ),
                          child: TextButton(
                            child: new Text(
                              'Add Task',
                              style: Pallete.kbtn2,
                            ),
                            onPressed: () async {
                              Map<dynamic, dynamic> Taskdata = {
                                "currentDate": _currentdatetime.text,
                                "work": _note.text,
                                "reminderTime": ReminderTime,
                                "categoryId": selectedCat
                              };
                              MySharedPreferences.instance
                                  .setStringValue("remindertime", ReminderTime);
                              MySharedPreferences.instance
                                  .setStringValue("note", _note.text);
                              // scheduleAlarm();
                              print(Taskdata);
                              if (_currentdatetime.text != null &&
                                  _note.text != null &&
                                  ReminderTime != null &&
                                  selectedCat != null) {
                                // scheduleNotification(
                                //     ReminderTime, _note.text);
                                await networkHandler.insertTasks(Taskdata);
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        backgroundColor: Colors.green,
                                        content: Text("Reminder Added")));
                                // Future.delayed(Duration(seconds: 5), () {
                                //   // 5s over, navigate to a new page
                                //   Navigator.push(
                                //       context,
                                //       MaterialPageRoute(
                                //         builder: (context) => TaskPage(),
                                //       ));
                                // });
                              } else {
                                DateTime dt = DateTime.now();
                                print("THis is DT");
                                print(dt);
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        backgroundColor: Colors.red,
                                        content: Text(
                                            "All Fields need to be filled")));
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void initMessaging() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {});
  }

  void notificationPermission() async {
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  String getDateTime() {
    if (dateTime == null) {
      return 'Schedule ';
    } else {
      setState(() {
        now1 = DateTime.now();
        currentschedule = DateFormat('yyyy-MM-dd').format(now1);
        _currentdatetime.text = currentschedule;
        // CurrentTimeForReminder = DateFormat('yyyy-MM-dd').format(dateTime);
        ReminderTime = DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
      });

      print(ReminderTime);
      return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
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
