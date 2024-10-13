import 'dart:core';

import 'package:expense_mangament_system/Providers/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListItemWidget extends StatelessWidget {
  String _id;
  String _title;
  String _amount;
  String _date;
  var deleteItem;

  ListItemWidget(this._id, this._title, this._amount, this._date,this.deleteItem);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor,
            radius: 30,
            child: Padding(
              padding: EdgeInsets.all(6),
              child: FittedBox(
                child: Text(
                  _amount,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          title: Text(
            _title,
            style: TextStyle(fontWeight: FontWeight.w600),
            //style: Theme.of(context).textTheme.title,
          ),
          subtitle: Text(
            //DateFormat.yMMMd().format(transactions[index].date),
            _date,
          ),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            color: Colors.red,
            onPressed: () {
              deleteItem(_id);
            },
          ),
        ),
        Divider(),
      ],
    );
  }
}
