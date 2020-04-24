import 'package:flutter/material.dart';
import '../models/todoitem_model.dart';

class AddTodoScreen extends StatefulWidget{
  @override
  _AddTodoScreenState createState()=> _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen>{

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  String _title;
  String _description;
  
  _saveTodo(){
    final formState = _formKey.currentState;
    if (!formState.validate())return;
    formState.save();
    Navigator.of(context).pop(TodoItemModel(
      _title,
      description: _description,
      complete: false,
      archived: false
    ));
  }
  
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.redAccent,
      title: Text("Add new todo",textAlign: TextAlign.center,),
      contentPadding: EdgeInsets.all(20.0),
      content: Container(
        child: Form(
          key: _formKey,
          child: Flex(
            direction: Axis.vertical,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                onSaved: (val){
                  setState(() {
                    _title = val;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'title'
                ),
                validator: (val)=>val==''?'Please enter a title':null,
              ),
              Container(margin: EdgeInsets.only(top: 20.0),),
              TextFormField(
                onSaved: (val){
                  setState(() {
                    _description = val;
                  });
                },
                maxLines: 3,
                decoration: InputDecoration(
                    labelText: 'Description'
                ),
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        MaterialButton(
          color: Colors.black,
          child: Text("Save todo", style: TextStyle(color: Colors.white),),
          onPressed: _saveTodo
        ),
        MaterialButton(
          color: Colors.white,
          child: Text("Cancel", style: TextStyle(color: Colors.redAccent),),
          onPressed: (){
            Navigator.of(context).pop(null);
          },
        ),
      ],
    );
  }
}