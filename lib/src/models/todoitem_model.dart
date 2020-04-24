import 'package:cloud_firestore/cloud_firestore.dart';

class TodoItemModel{
  String id;
  String title = '';
  String description = '';
  bool archived = false;
  bool complete = false;

  TodoItemModel(this.title,{this.description, this.complete, this.archived});

  TodoItemModel.from(DocumentSnapshot snapshot):
      id          = snapshot.documentID,
      title       = snapshot['title'],
      description = snapshot['description'],
      complete    = snapshot['complete'],
      archived    = snapshot['archived'];

  Map<String, dynamic> toJson(){
    return{
      'title': title,
      'description': description,
      'complete': complete,
      'archived': archived
    };
  }
}