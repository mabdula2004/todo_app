import 'package:flutter/material.dart';

class todoscreen extends StatefulWidget {
  final TextEditingController textEditingController = TextEditingController();
  @override
  State<todoscreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<todoscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add Item',
        backgroundColor: Colors.deepPurpleAccent,
        child: Icon(Icons.add, color: Colors.white),
        onPressed: showFormDialog,
      ),
    );
  }

  void showFormDialog() {
    var alert = AlertDialog(
      content: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: widget.textEditingController,
              autofocus: true,
              decoration: InputDecoration(
                labelText: "Item",
                hintText: "By Stuff From There",
                icon: Icon(Icons.note_add),
              ),
            ),
          )
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            handleSubmitted(widget.textEditingController.text);
            widget.textEditingController.clear();
            Navigator.pop(context);
          },
          child: Text("Save"),
        ),
        ElevatedButton(
          onPressed:()=> Navigator.pop(context), child: Text('Cancle'),),
      ],
    );
    showDialog(
      context: context,
      builder: (_) {
        return alert;
      },
    );
  }

  void handleSubmitted(String text) {
    // Add your logic here
  }
}
