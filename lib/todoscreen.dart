import 'package:flutter/material.dart';
import 'package:todo_app/TodoItem.dart';
import 'database_client.dart';
import 'date_Formator.dart';

class TodoScreen extends StatefulWidget {
  final TextEditingController textEditingController = TextEditingController();
  var db = DatabaseHelper();
  final List<TodoItem> itemList = <TodoItem>[];

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  void initState() {
    super.initState();
    readNoTodoList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              reverse: false,
              itemCount: widget.itemList.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  color: Colors.white,
                  child: ListTile(
                    title: Text(widget.itemList[index].itemName),
                    onLongPress: () => updateItem(widget.itemList[index], index),
                    trailing: Listener(
                      key: Key(widget.itemList[index].id.toString()),
                      onPointerDown: (pointerEvent) => deleteItem(widget.itemList[index].id, index),
                      child: const Icon(
                        Icons.delete,
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const Divider(height: 1,)
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add Item',
        backgroundColor: Colors.deepPurpleAccent,
        child: Icon(Icons.add, color: Colors.white),
        onPressed: showFormDialog,
      ),
    );
  }

  void showFormDialog() async{
    var alert = AlertDialog(
      content: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: widget.textEditingController,
              autofocus: true,
              decoration: const InputDecoration(
                labelText: "Item",
                hintText: "Buy Stuff From There",
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
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        ),
      ],
    );
    showDialog(
      context: context,
      builder: (_) {
        return alert;
      },
    );
  }

  void handleSubmitted(String text) async {
    widget.textEditingController.clear();

    TodoItem newItem = TodoItem(text, dateFormatted(), 0);
    int savedItemId = await widget.db.saveItem(newItem);

    TodoItem? addedItem = await widget.db.getItem(savedItemId);

    setState(() {
      if (addedItem != null) {
        widget.itemList.insert(0, addedItem);
      }
    });

    print('Item saved id: $savedItemId');
  }

  void readNoTodoList() async {
    List<TodoItem> items = await widget.db.getItems();
    setState(() {
      widget.itemList.clear();
      items.forEach((item) {
        widget.itemList.add(TodoItem.fromMap(item as Map<String, dynamic>));
      });
    });
    print("DB items: ${widget.itemList.map((item) => item.itemName).toList()}");
  }

  void deleteItem(int id, int index) async {
    await widget.db.deleteItem(id);

    setState(() {
      widget.itemList.removeWhere((item) => item.id == id);
    });
  }

  void updateItem(TodoItem item, int index) async {
    var alert = AlertDialog(
      title: const Text("Update Item"),
      content: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: widget.textEditingController,
              autofocus: true,
              decoration: const InputDecoration(
                labelText: "Item",
                hintText: "eg. Don't buy stuff",
                icon: Icon(Icons.update),
              ),
            ),
          ),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () async {
            TodoItem newItemUpdated = TodoItem.fromMap({
              "itemName": widget.textEditingController.text,
              "dateCreated": dateFormatted(),
              "id": item.id,
            });

            await widget.db.updateItem(newItemUpdated);
            setState(() {
              readNoTodoList();
            });
            Navigator.pop(context);
          },
          child: Text("Update"),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cancel"),
        ),
      ],
    );
    showDialog(context: context, builder: (_) => alert);
  }

  void handleSubmittedUpdate(int index, TodoItem item) async {
    setState(() {
      widget.itemList.removeWhere((element) => widget.itemList[index].itemName == item.itemName);
    });
  }
}
