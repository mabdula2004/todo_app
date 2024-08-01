import 'package:flutter/material.dart';

class todoItem extends StatelessWidget {

  String itemName = '';
  String createdDate = '';
  int id =0;

  todoItem(this.itemName,this.createdDate,this.id);

  todoItem.map(dynamic obj ){
    this.itemName = obj["itemName1"];
    this.createdDate = obj['createdDate1'];
   this.id         = obj['id1'];
  }

  String get itemName1=>itemName;
  String get createdDate1=>createdDate;
  int get id1=> id;

  Map<String,dynamic> toMap(){
    var map = new Map<String,dynamic>();
    map['itemName1'] = itemName;
    map['createdDate1'] = createdDate;

    if(id!=0)
    {
      map['id1'] = id;
    }
  return map;

  }
  todoItem.fromMap(Map<String,dynamic>map){
    this.itemName = map['itemName1'];
    this.createdDate = map['createdDate1'];
    this.id = map['id1'];
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
                itemName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                margin: EdgeInsets.all(8.0),
                child: Text(
                  createdDate,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.normal,
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
