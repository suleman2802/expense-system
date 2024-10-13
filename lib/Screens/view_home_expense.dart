import '../Widgets/drawer_widget.dart';
import './add_home_expense.dart';
import '../Widgets/view_list_widget.dart';

import 'package:flutter/material.dart';

class ViewHomeExpense extends StatelessWidget {
  static const  String routeName = "./viewHomeExpense";

  const ViewHomeExpense({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "View Home Expense",
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
      body: ViewListWidget(true),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () =>
            Navigator.of(context).pushNamed(AddHomeExpense.routeName),
      ),
    );
  }
}
