import 'package:flutter/material.dart';

class TodoItem extends StatelessWidget {
  String _itemName='';
  String _createdDate='';
  int _id = 0;

  TodoItem(this._itemName, this._createdDate, this._id);

  TodoItem.map(dynamic obj) {
    this._itemName = obj["itemName"];
    this._createdDate = obj['createdDate'];
    this._id = obj['id'];
  }

  String get itemName => _itemName;
  String get createdDate => _createdDate;
  int get id => _id;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['itemName'] = _itemName;
    map['createdDate'] = _createdDate;

    map['id'] = _id;
      return map;
  }

  TodoItem.fromMap(Map<String, dynamic> map) {
    this._itemName = map['itemName'];
    this._createdDate = map['createdDate'];
    this._id = map['id'];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _itemName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                color: Colors.black54,
                margin: EdgeInsets.all(8.0),
                child: Text(
                  'Created on: $_createdDate',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.normal,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
