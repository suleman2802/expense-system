import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:expense_mangament_system/Screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../Providers/home_provider.dart';
import '../Providers/vehicle_provider.dart';
import 'card_title.dart';

class FormWidget extends StatefulWidget {
  bool isHome;

  FormWidget(@required this.isHome);

  @override
  State<FormWidget> createState() => _FormWidgetState(isHome);
}

class _FormWidgetState extends State<FormWidget> {


  List<String> homeList = <String>["Maintenance",'Gas Bill', 'Internet Bill', 'Electricity Bill', 'Water Bill', 'Sales Tax', 'Education', 'Other'];
  List<String> vehicleList = <String>["Maintenance",'Petrol', 'Oil', 'Other'];
  bool isHome;

  _FormWidgetState(this.isHome);

  final _formKey = GlobalKey<FormState>();


  String type = "Maintenance";

  final _dateTimeController = TextEditingController();
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _dateTimeController.clear();
    _amountController.clear();
    _nameController.clear();
  }

  void submitForm() {
    bool isValid = _formKey.currentState!.validate();
    bool isDateValid = _dateTimeController.text!.isNotEmpty;
    if(!isDateValid){
      showSnackBar("please select date");
    }

    if (isValid && isDateValid) {
      _formKey.currentState!.save();

      if (isHome) {
        final homeProvider = Provider.of<HomeProvider>(context, listen: false);
        homeProvider.save_data(
            _nameController.text, type, double.parse(_amountController.text), _dateTimeController.text);
      } else {
        final vehicleProvider =
            Provider.of<VehicleProvide>(context, listen: false);
        vehicleProvider.save_data(
            _nameController.text, type, double.parse(_amountController.text) , _dateTimeController.text);
      }
      showSnackBar("Your entered data saves Successfully");
      Navigator.of(context).pushNamed(HomeScreen.routeName);
    } else {
      showSnackBar("Please fill complete form");
    }
  }
  void showSnackBar(String message) {
    print("insider snackbar");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _dateTimeController.text = DateFormat("yyyy-MM-dd").format(DateTime.now());
    final list = isHome? homeList :vehicleList;
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CardBanner(isHome ? "Home " : "Vechile "),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: _nameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Enter Name of your ${isHome ? "Home " : "Vechile "}expense";
              }
              return null;
            },
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              labelStyle: Theme.of(context).textTheme.labelMedium,
              label: Text("Enter ${isHome ? "Home Expense" : "Vechile "} Name"),
              hintText: isHome
                  ? "The Expense Name e.g Paint,repairing etc"
                  : "Enter Vehicle name e.g Corolla Yaris etc",
              focusColor: Colors.black,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          //DropdownButtonApp(isHome,getDropDownValue),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Select Expense Type",style: Theme.of(context).textTheme.labelMedium,),
                DropdownButton<String>(
                  value: type,
                  icon: const Icon(Icons.arrow_drop_down_sharp),
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    width: double.infinity,
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      print(value);
                      type = value!;
                    });
                    print("after $type");
                  },
                  items: list.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: _amountController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Enter Expense Amount";
              }
            },
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              label: Text("Enter Spend Amount"),
              hintText: "The Expense Amount the amount spend",
              labelStyle: Theme.of(context).textTheme.labelMedium,
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(
            height: 10,
          ),
          DateTimeField(
            style: TextStyle(
              color: Colors.black,
            ),
            // onSaved: (value) {
            //   _selectedDate = value!;
            // },
            controller: _dateTimeController,

            decoration: InputDecoration(
              label: Text(
                "Enter Date of Spending",
              ),
              labelStyle: Theme.of(context).textTheme.labelMedium,
            ),
            format: DateFormat("yyyy-MM-dd"),
            onShowPicker: (context, currentValue) {
              return showDatePicker(
                context: context,
                firstDate: DateTime(1900),
                initialDate: currentValue ?? DateTime.now(),
                lastDate: DateTime(2100),
              );
            },
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
            onPressed: submitForm,
            child: Text("Save"),
          ),
        ],
      ),
    );
  }
}
