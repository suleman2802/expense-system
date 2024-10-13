import 'package:flutter/material.dart';

class DropdownButtonApp extends StatefulWidget {
  List<String> homeList = <String>["Maintenance",'Gas Bill', 'Internet Bill', 'Electricity Bill', 'Water Bill', 'Sales Tax', 'Education', 'Other'];
  List<String> vechileList = <String>["Maintenance",'Petrol', 'Oil', 'Other'];
  bool isHome;
  var getDropDownValue;


  DropdownButtonApp(this.isHome,this.getDropDownValue);

  @override
  State<DropdownButtonApp> createState() => _DropdownButtonAppState(isHome?homeList:vechileList);
}

class _DropdownButtonAppState extends State<DropdownButtonApp> {
  String dropdownValue = "Maintenance";
  final list;
  _DropdownButtonAppState(this.list);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Select Expense Type",style: Theme.of(context).textTheme.labelMedium,),
          DropdownButton<String>(
                  value: dropdownValue,
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
                      dropdownValue = value!;
                    });
                    print("after $dropdownValue");
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
    );
  }
  String selectedDropdownValue() {
    return dropdownValue;
  }

}
