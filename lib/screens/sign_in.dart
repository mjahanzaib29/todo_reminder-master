import 'package:flutter/material.dart';
import 'package:todo_reminder/Util/AlarmReminders.dart';
import 'package:todo_reminder/constant/pallete.dart';
import 'package:todo_reminder/model/networkhandler.dart';
import 'package:todo_reminder/screens/home_page.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _semailTextEditingController =
  TextEditingController();
  final TextEditingController _spasswordTextEditingController =
  TextEditingController();
  final TextEditingController _snameTextEditingController =
  TextEditingController();
  String errorText, successText;

  @override
  Widget build(BuildContext context) {
    NetworkHandler networkHandler = NetworkHandler();
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          child: Stack(
            children: [
              Positioned(
                child: Container(
                  width: size.width,
                  height: size.height * .5,
                  decoration: BoxDecoration(
                    color: Pallete.bgColor,
                    borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(90.0)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 60, horizontal: 10),
                    child: Column(
                      children: [
                        Text(
                          "Welcome back!",
                          style: Pallete.kheading,
                        ),
                        Text(
                          "To keep connected with us please login with personal info",
                          style: Pallete.kpara,
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                top: size.height * .2,
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: size.height * .6,
                    width: size.width * .8,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Pallete.bgColor,
                      ),
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom:
                                    BorderSide(color: Colors.grey[400]))),
                            child: TextField(
                              controller: _snameTextEditingController,
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.person,
                                ),
                                labelStyle: Pallete.khint,
                                labelText: "User Name",
                                hintStyle: TextStyle(color: Colors.white),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom:
                                    BorderSide(color: Colors.grey[400]))),
                            child: TextField(
                              controller: _semailTextEditingController,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.email),
                                labelStyle: Pallete.khint,
                                labelText: "Email",
                                hintStyle: TextStyle(color: Colors.white),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom:
                                    BorderSide(color: Colors.grey[400]))),
                            child: TextField(
                              obscureText: true,
                              controller: _spasswordTextEditingController,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.lock),
                                labelStyle: Pallete.khint,
                                labelText: "Password",
                                hintStyle: TextStyle(color: Colors.white),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 15),
                            width: size.width,
                            decoration: new BoxDecoration(
                              color: Pallete.bgColor,
                              borderRadius:
                              BorderRadius.all(Radius.circular(50.0)),
                            ),
                            child: TextButton(
                              child: new Text(
                                'SIGN IN',
                                style: Pallete.kbtn,
                              ),
                              onPressed: () async {
                                Map<String, String> loginData = {
                                  "email": _semailTextEditingController.text,
                                  "password":
                                  _spasswordTextEditingController.text,
                                  "name": _snameTextEditingController.text,
                                };
                                print(loginData);
                                await networkHandler
                                    .loginUser(loginData)
                                    .then((dynamic message) {
                                  setState(() {
                                    errorText = message;
                                    if (errorText != null &&
                                        errorText == "Login Successful") {
                                      // MultiAlarm().getAllAlarm();
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Homepage(),
                                          ));
                                    } else {ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                         SnackBar(backgroundColor: Colors.red,content: Text("Username or "+errorText)));}
                                  });
                                });
                              },
                            ),
                          ),
                          InkWell(
                            child: RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: "Dont't have an account ?",
                                    style: Pallete.khint),
                                TextSpan(
                                    text: "Sign Up ", style: Pallete.kpopbtn)
                              ]),
                            ),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void loginUser() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog();
      },
    );
  }
}
