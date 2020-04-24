import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
class SettingsScreen extends StatefulWidget{
  @override
  _SettingsScreenState createState()=> _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>{
  
  _logout()async{
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, '/login');
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Settings", style: TextStyle(color: Colors.black),),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Center(
          child: FlatButton(
              onPressed: _logout,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text("Logout", style: TextStyle(color: Colors.white, fontSize: 24.0),),
                  Spacer(),
                  Icon(Icons.exit_to_app,color: Colors.white,),
                ],
              )
          ),
        ),
      )
    );
  }
}