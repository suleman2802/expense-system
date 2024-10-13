import 'package:expense_mangament_system/Widgets/drawer_widget.dart';
import 'package:flutter/material.dart';

import '../Widgets/FormWidget.dart';

class AddHomeExpense extends StatelessWidget {
  static const  String routeName = "./addHomeExpense";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Home Expense",
        ),
        actions: [
          CircleAvatar(
            radius: 25,
            foregroundImage: AssetImage(
              'assets/images/pic.jpg',
            ),
          ),
        ],
      ),
      drawer: DrawerWidget(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: FormWidget(true),
        ),
      ),
    );
  }
}
