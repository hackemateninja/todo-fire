import 'package:flutter/material.dart';
import 'todos_screen.dart';
import 'history_screen.dart';
import 'settings_screen.dart';

class TabsScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
          length: 3,
          child: Scaffold(
            body: TabBarView(
              children: <Widget>[
                TodosScreen(),
                HistoryScreen(),
                SettingsScreen()
              ],
            ),
            bottomNavigationBar: PreferredSize(
              preferredSize: Size(60.0, 60.0),
              child: Container(
                color: Colors.white,
                height: 70.0,
                child: TabBar(
                  labelColor: Colors.redAccent,
                  labelStyle: TextStyle(fontSize: 15.0),
                  tabs: <Widget>[
                    Tab(
                      icon: Icon(Icons.list),
                      text: 'Todos',
                    ),
                    Tab(
                      icon: Icon(Icons.history),
                      text: 'History',
                    ),
                    Tab(
                      icon: Icon(Icons.settings),
                      text: 'Settings',
                    ),
                  ]
                ),
              ),
            ),
          )
      ),
    );
  }
}