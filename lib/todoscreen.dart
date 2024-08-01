import 'package:flutter/material.dart';


class todoscreen extends StatefulWidget {
  const todoscreen({super.key});

  @override
  State<todoscreen> createState() => _todoscreenState();
}

class _todoscreenState extends State<todoscreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black87,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add Item',
        backgroundColor: Colors.deepPurpleAccent,
        child: ListTile(
          title: Icon(Icons.add,color: Colors.white,) ,
        ),
        onPressed: showformDialog,
      ),
    );
  }
}


  void showformDialog() {
  }

