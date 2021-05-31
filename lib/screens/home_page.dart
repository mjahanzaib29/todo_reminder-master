import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_reminder/constant/pallete.dart';
import 'package:todo_reminder/constant/route_constant.dart';
import 'package:todo_reminder/constant/route_links.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _currentindex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RouteLinks.routelinks[_currentindex],
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
        child: BottomNavigationBar(
          unselectedLabelStyle: Pallete.knavunselected,
          unselectedItemColor: Pallete.knav,
          selectedItemColor: Colors.white,
          selectedLabelStyle: Pallete.knavselected,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Pallete.bgColor,
          iconSize: 0,
          currentIndex: _currentindex,
          onTap: (int index) {
            setState(() {
              _currentindex = index;
            });
          },
          items: _items,
          // items:allNavItems.map((NavItems navitems) {
          //   Divider(height: 10,color: Colors.black,thickness: 2,);
          //   return BottomNavigationBarItem(
          //       icon: Icon(navitems.icon),
          //       label: navitems.title,);
          // }).toList(),
        ),
      ),
    );
  }
}

final _items = [
  BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: RouteConstants.home,
      backgroundColor: Pallete.bgColor),
  BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: RouteConstants.task,
      backgroundColor: Pallete.bgColor),
  BottomNavigationBarItem(
      icon: Icon(Icons.event),
      label: RouteConstants.categories,
      backgroundColor: Pallete.bgColor),
];
