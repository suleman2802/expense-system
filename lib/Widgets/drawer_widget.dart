import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Screens/add_home_expense.dart';
import '../Screens/add_vehicle_expense.dart';
import '../Screens/login_screen.dart';
import '../Providers/user_auth_provider.dart';
import '../Screens/home_screen.dart';
import '../Screens/view_home_expense.dart';
import '../Screens/view_vehicle_expense.dart';

class DrawerWidget extends StatelessWidget {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          SizedBox(
            height: 80,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 25,
                    foregroundImage: AssetImage(
                      'assets/images/pic.jpg',
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Text("Javeed Rashid",style: TextStyle(color: Colors.white,fontSize: 16,),),
                ],
              ),
            ),
          ),
          ListTile(
            title: const Text('Dashboard'),
            selected: _selectedIndex == 0,
            onTap: () {
              Navigator.of(context).pushNamed(HomeScreen.routeName);
            },
          ),
          ListTile(
            title: const Text('Add Home Expense'),
            onTap: () {
              Navigator.of(context).pushNamed(AddHomeExpense.routeName);
            },
          ),
          ListTile(
            title: const Text('Add Vehicle Expense'),
            onTap: () {
              Navigator.of(context).pushNamed(AddVehicleExpense.routeName);
            },
          ),
          ListTile(
            title: const Text('View Home Expense'),
            onTap: () {
              Navigator.of(context).pushNamed(ViewHomeExpense.routeName);
            },
          ),
          ListTile(
            title: const Text('View Vehicle Expense'),
            onTap: () {
              Navigator.of(context).pushNamed(ViewVehicleExpense.routeName);
            },
          ),
          ListTile(
            title: const Text('Logout'),
            //selected: _selectedIndex == 2,
            onTap: () async {
              // Update the state of the app
              // _onItemTapped(2);
              // Then close the drawer
              await Provider.of<UserAuthProvider>(context, listen: false).logout();
              // .then((value) => setState(() {
              Navigator.of(context).pushNamed(LoginScreen.routeName);
              // }));
            },
          ),
          //SizedBox(height: 100,),
          //FittedBox(child: MinuteConsumedWidget()),
        ],
      ),
    );
  }
}
