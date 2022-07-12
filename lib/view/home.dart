import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('首頁'),
        ),
        body: Builder(
          builder: (context) => Center(
              child: FlatButton(
                textColor: Colors.black,
                child: Text('內容頁'),
                onPressed: () {
                  Navigator.pushNamed(context, '/');
                },
              ),
          ),
        ));
  }
}