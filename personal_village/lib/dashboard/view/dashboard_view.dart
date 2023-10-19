import 'package:flutter/material.dart';
import 'package:personal_village/dashboard/view/dashboard_widget.dart';
import 'package:personal_village/utility/get_it_handler.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  State<DashboardView> createState() => _DashboardViewState();
}


class _DashboardViewState extends State<DashboardView> {
  int _tabIndex = 0;

  List<Widget> screens = [
    DashboardWidget(),
    Center(
      child: Container(
          child: Text(
        "Screen Two",
        style: TextStyle(fontSize: 33),
      )),
    ),
    Center(
      child: Container(
        child: Text(
          "Screen Three",
          style: TextStyle(fontSize: 33),
        ),
      ),
    ),
    Center(
      child: Container(
        child: Text(
          "Screen Four",
          style: TextStyle(fontSize: 33),
        ),
      ),
    ),

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.red[900],
        unselectedItemColor: Colors.green[900],
        showUnselectedLabels: true,
        showSelectedLabels: true,
        backgroundColor: Colors.blue,
        currentIndex: _tabIndex,
        onTap: (index) {
          print("What about here? ${pvSettingsLogic.currentUserInfo.value}");
          setState(() {
            _tabIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              label: "Dashboard",
              icon: Icon(
                Icons.home,
                size: 30,
              )),
          BottomNavigationBarItem(
              label: "My Village",
              icon: Icon(
                Icons.reduce_capacity_outlined,
                size: 30,
              )),
          BottomNavigationBarItem(
              label: "Knowledge Base",
              icon: Icon(
                Icons.menu_book_sharp,
                size: 30,
              )),
          BottomNavigationBarItem(
              label: "Chat",
              icon: Icon(
                Icons.chat,
                size: 30,
              )),

        ],
      ),
      body: screens[_tabIndex],
    );
  }
}
