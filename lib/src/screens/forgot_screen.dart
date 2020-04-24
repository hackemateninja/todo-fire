import 'package:flutter/material.dart';
import '../behaviors/hidden_scroll_behavior.dart';
import 'package:firebase_auth/firebase_auth.dart';


class ForgotScreen extends StatefulWidget{
  @override
  _ForgotScreenState createState()=> _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen>{

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String _email;
  bool _reseting = false;

  _reset() async {

    if(_reseting)return;

    setState(() {

      _reseting= true;

    });

    _scaffoldKey.currentState.showSnackBar(
        SnackBar(
            content: Text("Recover password")
        )
    );

    final form = _formKey.currentState;

    if(!form.validate()){

      _scaffoldKey.currentState.hideCurrentSnackBar();

      setState(() {

        _reseting = false;

      });

      return;
    }

    form.save();

    try{

      await FirebaseAuth.instance.sendPasswordResetEmail(
          email: _email
      );
      Navigator.pop(context);
      Navigator.pushReplacementNamed(context, '/login');

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

        _reseting = false;

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
                  Container(margin: EdgeInsets.only(top: 120.0),),
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
                  Container(margin: EdgeInsets.only(top: 70.0),),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50.0),
                    child: MaterialButton(
                      color: Colors.white,
                      child: Text("Recover password", style: TextStyle(fontSize: 18.0),),
                      onPressed: _reset,
                    ),
                  ),
                ],
              ),
            )
        ),
      ),
    );
  }
}