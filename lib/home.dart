import 'package:flutter/material.dart';
import 'package:todo_app/todoscreen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TODO APP',
        style: TextStyle(
            fontStyle:FontStyle.italic ,
            color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: todoscreen(),
    );
  }
}