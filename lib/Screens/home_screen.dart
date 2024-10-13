import 'package:flutter/material.dart';
import '../Widgets/drawer_widget.dart';
import './add_home_expense.dart';
import './add_vehicle_expense.dart';
import '../Widgets/home_item.dart';
import './view_home_expense.dart';
import './view_vehicle_expense.dart';

class HomeScreen extends StatelessWidget {
  static const  String routeName = "./homeScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expense Management System",style: TextStyle(fontSize: 18,),),
        actions: [
          CircleAvatar(
            radius: 25,
            foregroundImage: AssetImage(
              'assets/images/pic.jpg',
            ),
            // child: Image.asset(
            //   'assets/images/pic.jpg',
            //   fit: BoxFit.cover,
            // ),
          ),
        ],
      ),
      drawer: DrawerWidget(),
      body: GridView(
          padding: const EdgeInsets.all(30),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 2 / 2,
            crossAxisSpacing: 30,
            mainAxisSpacing: 50,
          ),
          children: [
            HomeItem(
                "Add Home Expense",
                () =>
                    Navigator.of(context).pushNamed(AddHomeExpense.routeName)),
            HomeItem(
                "Add Vehicle Expense",
                () => Navigator.of(context)
                    .pushNamed(AddVehicleExpense.routeName)),
            HomeItem(
                "View Home Expense",
                () =>
                    Navigator.of(context).pushNamed(ViewHomeExpense.routeName)),
            HomeItem(
                "View Vehicle Expense",
                () => Navigator.of(context)
                    .pushNamed(ViewVehicleExpense.routeName)),
          ]),
    );
  }
}
//
// FittedBox(
// child: Padding(
// padding: EdgeInsets.all(30),
// child: Column(
// //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// children: [
// Text("Welcome Javid Rasheed"),
// Row(
// //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// children: [
// ListTile(
// title: Text("Add House Expense"),
// onTap: (){},
// ),
// ListTile(
// title: Text("Add Vechile Expense"),
// onTap: (){},
// ),
// ],
// ),
// Row(
// //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// children: [
// ListTile(
// title: Text("View House Expense"),
// onTap: (){},
// ),
// ListTile(
// title: Text("View Vechile Expense"),
// onTap: (){},
// ),
// ],
// ),
// ],
// ),
// ),
// ),
