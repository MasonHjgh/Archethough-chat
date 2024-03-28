import 'package:flutter/material.dart';
import 'package:personal_village/account/view/account.dart';
import 'package:personal_village/chat/chat.dart';
import 'package:personal_village/dashboard/view/dashboard_widget.dart';
import 'package:personal_village/knowledge_base/view/knowledge_base.dart';
import 'package:personal_village/my_village/my_village.dart';
import 'package:personal_village/utility/get_it_handler.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  int _tabIndex = 0;
  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _setScreens();
  }

  void _setScreens() {
    _screens = <Widget>[
      DashboardWidget(),
      MyVillage(),
      KnowledgeBase(),
      ChatScreen(recipientName: 'John')
      ,
      AccountView()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade300,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.white,
        selectedLabelStyle: TextStyle(
          fontWeight: FontWeight.bold,
        ),
        unselectedItemColor: Colors.white70,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        unselectedLabelStyle: TextStyle(
          fontWeight: FontWeight.w200,
          fontSize: 10,
        ),
        type: BottomNavigationBarType.shifting,
        backgroundColor: Colors.red.shade300,
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
            ),
            backgroundColor: Color(0xFF74393a),
          ),
          BottomNavigationBarItem(
            label: "My Village",
            icon: Icon(
              Icons.reduce_capacity_outlined,
              size: 30,
            ),
            backgroundColor: Color(0xFF74393a),
          ),
          BottomNavigationBarItem(
            label: "RETAIN",
            icon: Icon(
              Icons.menu_book_sharp,
              size: 30,
            ),
            backgroundColor: Color(0xFF74393a),
          ),
          BottomNavigationBarItem(
            label: "Conversation",
            icon: Icon(
              Icons.chat,
              size: 30,
            ),
            backgroundColor: Color(0xFF74393a),
          ),
          BottomNavigationBarItem(
            label: "Profile",
            icon: Icon(
              Icons.person,
              size: 30,
            ),
            backgroundColor: Color(0xFF74393a),
          )
        ],
      ),
      body: SafeArea(child: _screens[_tabIndex]),
    );
  }
}
