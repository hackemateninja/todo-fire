import 'package:flutter/material.dart';
import '../behaviors/hidden_scroll_behavior.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Registerscreen extends StatefulWidget{
  @override
  _RegisterScreenState createState()=> _RegisterScreenState();
}

class _RegisterScreenState extends State<Registerscreen>{

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String _email;
  String _pass;
  bool _isRegistering = false;

  _register() async {

    if(_isRegistering)return;

    setState(() {

      _isRegistering = true;

    });

    _scaffoldKey.currentState.showSnackBar(
        SnackBar(
        content: Text("Registering user")
      )
    );

    final form = _formKey.currentState;

    if(!form.validate()){

      _scaffoldKey.currentState.hideCurrentSnackBar();

      setState(() {

        _isRegistering = false;

      });

      return;
    }

    form.save();

    try{

      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _email,
          password: _pass
      );

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

        _isRegistering = false;

      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 50.0, horizontal: 30.0),
        child: ScrollConfiguration(
          behavior: HiddenScrollBehavior(),
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                Image(image: AssetImage('assets/img/logo_negro.png'), height: 120.0,),
                Container(margin: EdgeInsets.only(top: 50.0),),
                Text(
                  "welcome to todos fire app, please fill the fields to register",
                  style: TextStyle(color: Colors.white, fontSize: 15.0,),
                  textAlign: TextAlign.center,
                ),
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
                Container(margin: EdgeInsets.only(top: 50.0),),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50.0),
                  child: MaterialButton(
                    color: Colors.white,
                    child: Text("Sign Up", style: TextStyle(fontSize: 18.0),),
                    onPressed: _register,
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
            Navigator.pushNamed(context, '/login');
          },
          child: Text("Already have account?",
            style: TextStyle(color: Colors.white, fontSize: 18.0),),
        )
      ],
    );
  }
}