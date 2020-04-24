import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'routes.dart';
import 'themes.dart';
import 'screens/register_screen.dart';
import 'screens/tabs_screen.dart';

class App extends StatefulWidget{
  @override
  _AppState createState()=> _AppState();
}

class _AppState extends State<App>{

  Widget _rootPage = Registerscreen();

  Future<Widget> getRootPage() async =>
    await FirebaseAuth.instance.currentUser() == null
        ? Registerscreen()
        : TabsScreen();

  @override
  void initState() {
    super.initState();
    getRootPage().then((Widget page){
      page =_rootPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        color: Colors.black,
        debugShowCheckedModeBanner: false,
        title: 'Todos fire',
        theme: buildAppTheme(),
        routes: routesBuilder(),
        home: Registerscreen()
    );
  }
}
