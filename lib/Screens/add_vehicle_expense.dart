import 'package:flutter/material.dart';

import '../Widgets/FormWidget.dart';
import '../Widgets/drawer_widget.dart';

class AddVehicleExpense extends StatelessWidget {
  static const  String routeName = "./addVehicleExpense";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Vechile Expense",
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
          child: FormWidget(false),
        ),
      ),
    );
  }
}
