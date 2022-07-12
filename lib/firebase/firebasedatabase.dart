import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_practice/set.dart';

Set set = Set();

class FirebaseDataBaseDemo extends StatelessWidget {
  final databaseReference = FirebaseDatabase.instance.reference();

  @override Widget build(BuildContext context) {
    FirebaseDatabase.instance.setPersistenceEnabled(true);
    FirebaseDatabase.instance.setPersistenceCacheSizeBytes(10000000);
    return Padding(
      padding: set.initEdgeInsetsTop(20.0),
      child: Center(
        child: Column(
          children: <Widget>[
            set.initText2('FireBase DataBase', Colors.black, Colors.transparent, 24),
            Column(
                children: [
                  RaisedButton(
                    child: set.initText('Create Record'), onPressed: () {
                    createRecord();
                  },),
                  RaisedButton(
                    child: set.initText('View Record'), onPressed: () {
                    getData();
                  },),
                  RaisedButton(
                    child: set.initText('Update Record'), onPressed: () {
                    updateData();
                  },),
                  RaisedButton(
                    child: set.initText('Delete Record'), onPressed: () {
                    deleteData();
                  },),
                ],
              ),
            ],
        )));
  }

  void createRecord() {
    databaseReference.child('1').set({
      'title': 'Mastering EJB',
      'description': 'Programming Guide for J2EE'
    });
    databaseReference.child('2').set({
      'title': 'Flutter in Action',
      'description': 'Complete Programming Guide to learn Flutter'
    });
  }

  void getData() async {
    final DataSnapshot snapshot = (await databaseReference.once()) as DataSnapshot;
    debugPrint('Data : ${snapshot.value} ');
  }

  void updateData() {
    databaseReference.child('1').update({'description': 'J2EE complete Reference'});
  }

  void deleteData() {
    databaseReference.child('1').remove();
  }

}