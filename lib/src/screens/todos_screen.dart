import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/todoitem_model.dart';
import 'addtodo_screen.dart';

class TodosScreen extends StatefulWidget{
  @override
  _TodosScreenState createState()=> _TodosScreenState();
}

class _TodosScreenState extends State<TodosScreen>{

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  
  CollectionReference _todoRef;
  FirebaseUser _user;

  @override
  void initState() {
    super.initState();
    _setUpTodosPage();
  }

  void _setUpTodosPage() async{
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    setState(() {
      _user = user;
      _todoRef = Firestore.instance.collection('users').document(_user.uid).collection('todos');
    });
  }


  Widget _buildBody(){
    if(_todoRef == null){
      return Center(
        child: CircularProgressIndicator(),
      );
    }else{
      return StreamBuilder(
        stream: _todoRef.where('archived', isEqualTo: false).snapshots(),
        builder: _buildTodoList
      );
    }
  }

  Widget _buildTodoList(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
    if(!snapshot.hasData){
      return Center(child: CircularProgressIndicator(),);
    }else{
      if (snapshot.data.documents.length == 0){
        return _buildEmptyMessage();
      }else{
        return ListView(
          children: snapshot.data.documents.map((DocumentSnapshot document){
            TodoItemModel item = TodoItemModel.from(document);
            return Dismissible(
              key: Key(item.id),
              background: Container(
                color: Colors.greenAccent,
                child: Center(
                  child: Text(
                    'Archivar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0
                    ),
                  ),
                ),
              ),
              onDismissed: (DismissDirection direction){
                document.reference.updateData({'archived': true});
              },
              child: Card(
                child: CheckboxListTile(
                  title: Text(item.title),
                  subtitle: Text(item.description),
                  value: item.complete,
                  onChanged: (bool value){
                    document.reference.updateData({'complete':value});
                  },
                ),
              ),
            );
          }).toList()
        );
      }
    }
  }

  Widget _buildEmptyMessage(){
    return Center(
      child: Flex(
        direction: Axis.vertical,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            Icons.check,
            size: 45.0,
            color: Colors.white,
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: Text(
              "No hay todos",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0
              ),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
  
  _addTodo()async{
    TodoItemModel item = await showDialog(
      context: context,
      builder: (_)=> AddTodoScreen()
    );
    if(item!=null){
      await _todoRef.add(item.toJson());
    }
  }
  
 @override
 Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      floatingActionButton: FloatingActionButton(
        elevation: 0.0,
        backgroundColor: Colors.white,
        child: Icon(Icons.add,color: Colors.black,),
        onPressed: _addTodo,
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Todos", style: TextStyle(color: Colors.black),),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: _buildBody(),
      ),
    );
  }
}