import 'package:expense_mangament_system/Screens/add_vehicle_expense.dart';
import 'package:expense_mangament_system/Widgets/view_list_widget.dart';
import 'package:flutter/material.dart';
import '../Widgets/card_title.dart';
import '../Widgets/drawer_widget.dart';
import '../Widgets/list_item_widget.dart';

class ViewVehicleExpense extends StatelessWidget {
  static const String routeName = "./viewVehicleExpense";

  const ViewVehicleExpense({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "View Vehicle Expense",
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
      body: ViewListWidget(false),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () =>
            Navigator.of(context).pushNamed(AddVehicleExpense.routeName),
      ),
    );
  }
}
