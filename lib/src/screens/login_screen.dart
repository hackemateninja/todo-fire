import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../behaviors/hidden_scroll_behavior.dart';

class LoginScreen extends StatefulWidget{
  @override
  _LoginScreenState createState()=> _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>{

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String _email;
  String _pass;
  bool _isLoggeding = false;

  _login() async {

    if(_isLoggeding)return;

    setState(() {

      _isLoggeding = true;

    });

    _scaffoldKey.currentState.showSnackBar(
        SnackBar(
            content: Text("Login user")
        )
    );

    final form = _formKey.currentState;

    if(!form.validate()){

      _scaffoldKey.currentState.hideCurrentSnackBar();

      setState(() {

        _isLoggeding = false;

      });

      return;
    }

    form.save();

    try{

      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email,
          password: _pass
      );

      Navigator.pop(context);
      Navigator.pushReplacementNamed(context, '/tabs');

    }catch(e){
      print(e.toString());
      _scaffoldKey.currentState.hideCurrentSnackBar();
      _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            duration: Duration(seconds: 5),
            action: SnackBarAction(
                label: 'Dismiss',
                onPressed: (){
                  _scaffoldKey.currentState.hideCurrentSnackBar();
                }
            ),
          )
      );

    }finally{
      setState(() {

        _isLoggeding = false;

      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 90.0, horizontal: 30.0),
        child: ScrollConfiguration(
            behavior: HiddenScrollBehavior(),
            child: Form(
              key: _formKey,
              child: ListView(
                children: <Widget>[
                  Image(image: AssetImage('assets/img/logo_negro.png'), height: 120.0,),
                  Container(margin: EdgeInsets.only(top: 50.0),),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    autocorrect:false,
                    decoration: InputDecoration(
                        labelText: "Email address"
                    ),
                    validator: (val){
                      if (val.isEmpty){
                        return "Please enter a valid email";
                      }else{
                        return null;
                      }
                    },
                    onSaved: (val){
                      setState(() {
                        _email = val;
                      });
                    },
                  ),
                  Container(margin: EdgeInsets.only(top: 50.0),),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    obscureText: true,
                    autocorrect:false,
                    decoration: InputDecoration(
                        labelText: "Password"
                    ),
                    validator: (val){
                      if (val.isEmpty){
                        return "Please enter a valid password";
                      }else{
                        return null;
                      }
                    },
                    onSaved: (val){
                      setState(() {
                        _pass = val;
                      });
                    },
                  ),
                  Container(margin: EdgeInsets.only(top: 20.0),),
                  FlatButton(
                    padding: EdgeInsets.all(0.0),
                    onPressed: (){
                      Navigator.pushNamed(context, '/forgot');
                    },
                    child: Text("Forgot your password?", style: TextStyle(color: Colors.white),),
                  ),
                  Container(margin: EdgeInsets.only(top: 20.0),),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50.0),
                    child: MaterialButton(
                        elevation: 0.0,
                        color: Colors.white,
                        child: Text("Login", style: TextStyle(fontSize: 18.0),),
                        onPressed: _login
                    ),
                  ),
                ],
              ),
            )
        ),
      ),
      persistentFooterButtons: <Widget>[
        FlatButton(
          onPressed: (){
            Navigator.pop(context);
          },
          child: Text("Don´t have account yet?",
            style: TextStyle(color: Colors.white, fontSize: 18.0),),
        )
      ],
    );
  }
}