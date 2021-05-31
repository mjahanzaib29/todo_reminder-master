import 'package:flutter/material.dart';
import 'package:todo_reminder/constant/category_constant.dart';
import 'package:todo_reminder/constant/pallete.dart';
import 'package:todo_reminder/constant/string_constant.dart';
import 'package:todo_reminder/model/categoryinfo.dart';
import 'package:todo_reminder/model/networkhandler.dart';

class Categories_page extends StatefulWidget {
  @override
  _Categories_pageState createState() => _Categories_pageState();
}

class _Categories_pageState extends State<Categories_page> {
  final TextEditingController _addcategoryname = TextEditingController();
  NetworkHandler networkHandler = NetworkHandler();
  CategoryConstant categoryConstant;
  Future<Welcome> _category;
  String codeDialog;
  String valueText, CatresponseMsg;
  var categoryAdd;

  @override
  Widget build(BuildContext context) {
    NetworkHandler networkHandler = NetworkHandler();
    setState(() {
      _category = networkHandler.getcategory();
      print(_category);
    });
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: new Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Pallete.bgColor,
        onPressed: () {
          _displayCatAddDialog(context);
        },
      ),
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
            onPressed: () {
              _displayCatAddDialog(context);
            }),
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
                child: FutureBuilder<Welcome>(
              future: _category,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data.todos.length,
                    itemBuilder: (context, index) {
                      var cat = snapshot.data.todos[index];
                      return Dismissible(
                        background: Container(
                          color: Colors.red,
                        ),
                        key: ValueKey(index),
                        onDismissed: (direction) {
                          setState(() {
                            allcategories.removeAt(index);
                          });
                        },
                        child: ListTile(
                          title: Text(cat.name),
                          leading: Text("ID: " + cat.id.toString()),
                          subtitle:
                              Text("Created: " + cat.createdAt.toString()),
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

  Future<void> _displayCatAddDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Add Category '),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  valueText = value;
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

  void Catadd() async {
    if (codeDialog != null) {
      Map<String, String> CatInsert = {
        "name": codeDialog,
      };
      categoryAdd =
          await networkHandler.addCategory(CatInsert).then((dynamic message) {
        setState(() {
          CatresponseMsg = message;
          if (CatresponseMsg == "The name field is required.") {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.red,
                content: Text("Please Insert a name")));
          }else {ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Pallete.bgColor,
              content: Text("Category Success" + CatresponseMsg)));}
        });
      });
    } else {
      Navigator.pop(context);
    }
  }
}
