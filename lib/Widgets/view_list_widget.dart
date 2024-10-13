import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../Providers/vehicle_provider.dart';
import './search_bar_widget.dart';
import '../Providers/home_provider.dart';
import 'list_item_widget.dart';

class ViewListWidget extends StatefulWidget {
  bool isHome;

  ViewListWidget(this.isHome);

  @override
  State<ViewListWidget> createState() => _ViewListWidgetState();
}

class _ViewListWidgetState extends State<ViewListWidget> {
  var list = [];
  double amount = 0;

  //List<VehicleItem> list = [];
  List<String> vehicleList = <String>[
    "All",
    "Maintenance",
    'Petrol',
    'Oil',
    'Other'
  ];
  List<String> homeList = <String>[
    "All",
    "Maintenance",
    'Gas Bill',
    'Internet Bill',
    'Electricity Bill',
    'Water Bill',
    'Sales Tax',
    'Education',
    'Other'
  ];
  String type = "All";

  //bool? isLoadedOnce;
  TextEditingController searchController = TextEditingController();
  bool isLoading = true;
  DateTime? _selectedStartDate;
  DateTime? _selectedEndDate;
  String message = "No Record Entered yet";

  // void CalculateAmount() {
  //   var month = DateTime.now().month;
  //   list.forEach((element) => {
  //         if (element.date == month) {amount += element.amount}
  //       });
  //   print(amount);
  // }
  // void calculateTotalExpenseThisMonth() {
  //   // Get the current month and year
  //   DateTime now = DateTime.now();
  //   int currentMonth = now.month;
  //   int currentYear = now.year;
  //
  //   // Filter expenses for the current month and year
  //   var currentMonthExpenses = list.where((expense) =>
  //   expense.date.month == currentMonth && expense.date.year == currentYear).toList();
  //
  //   // Calculate total amount for the current month
  //   double totalAmount = currentMonthExpenses.fold(0, (previousValue, expense) => previousValue + expense.amount);
  //   amount = totalAmount;
  //   print(amount);
  //  // return totalAmount;
  // }
  void calculateTotalExpenseThisMonth() {
    // Get the current month and year
    DateTime now = DateTime.now();
    int currentMonth = now.month;
    int currentYear = now.year;

    // Filter expenses for the current month and year
    var currentMonthExpenses = list.where((expense) {
      // Convert expense.date from String to DateTime
      DateTime expenseDate = DateTime.parse(expense.date); // Assuming date is stored as "YYYY-MM-DD"
      return expenseDate.month == currentMonth && expenseDate.year == currentYear;
    }).toList();

    currentMonthExpenses.forEach((element) {
      amount += element.amount;
    },);

    // setState(() {
    //   amount = amount;
    // });
    print(" total expense : $amount");

    // Calculate total amount for the current month
    //double totalAmount = currentMonthExpenses.fold(0, (previousValue, expense) => previousValue + expense.amount);
    print('Total expenses for ${DateTime.now().month} / ${DateTime.now().year}: $amount');
  }

  Future<void> fetchData() async {
    try {
      if (widget.isHome) {
        //   await Provider.of<HomeProvider>(context)
        //       .fetch_data();
        list =
            await Provider.of<HomeProvider>(context, listen: false).homeExpense;
      } else {
        // await Provider.of<VehicleProvide>(context)
        //     .fetch_data();

        list = await Provider.of<VehicleProvide>(context, listen: false)
            .VehicleExpense;
      }
      setState(() {
        isLoading = false;
        //isLoadedOnce = false;
      });
    } catch (error) {
      print("Error =>>>> " + error.toString());
    }
  }

  void deleteItem(String id) async {
    try {
      if (widget.isHome) {
        await Provider.of<HomeProvider>(context, listen: false)
            .deleteEntry(id)
            .then((value) {
          setState(() {
            list.removeWhere((element) => element.id == id);
          });
          showSnackBar("Entry Deleted successfully");
        });
      } else {
        await Provider.of<VehicleProvide>(context, listen: false)
            .deleteEntry(id)
            .then((value) {
          setState(() {
            list.removeWhere((element) => element.id == id);
          });
          showSnackBar("Entry Deleted successfully");
        });
      }
    } catch (error) {
      print(error.toString());
      showSnackBar("Having problem in deleting entry Try again later");
    }
  }

  void searchItem() {
    //bool found = list.contains(name);
    //if(found){

    final itemFound = list
        .where((element) =>
            element.name.toString().toLowerCase() ==
            searchController.text!.toLowerCase())
        .toList();
    if (itemFound.isNotEmpty) {
      setState(() {
        searchController.clear();
        list = itemFound;
      });
      print("found ---------------------------------------");
      showSnackBar("Entry Found....");
    } else if (searchController.text.isEmpty) {
      showSnackBar("Enter text to search!....");
    } else {
      showSnackBar("No Entry of ${searchController.text} found!...");
    }
  }

  void _StartDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      } else {
        try {
          final startFilterList = list.where((element) {
            DateTime tempDate = DateTime.parse(element.date);
            //final date = DateFormat("yyyy-MM-dd").format(tempDate);
            //tempDate = DateTime.parse(date);

            if (tempDate.isAfter(pickedDate)) {
              return true;
            } else {
              return false;
            }
          }).toList();
          setState(() {
            //if(startFilterList.isNotEmpty) {
            list = startFilterList;
            message = "No Match Entry found!...";
            // }
            _selectedStartDate = pickedDate;
          });
          showSnackBar("Start Date Filter Applied Successfully");
        } catch (error) {
          print("Start Error : " + error.toString());
          showSnackBar("Start Date Filter failed Try again later");
        }
      }
    });
  }

  void _EndDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      } else {
        try {
          final endFilterList = list.where((element) {
            DateTime tempDate = DateTime.parse(element.date);
            //final date = DateFormat("yyyy-MM-dd").format(tempDate);
            //tempDate = DateTime.parse(date);

            if (tempDate.isBefore(pickedDate)) {
              return true;
            } else {
              return false;
            }
          }).toList();
          setState(() {
            // if(endFilterList.isNotEmpty) {
            list = endFilterList;
            message = "No Match Entry found!...";
            //  }
            _selectedEndDate = pickedDate;
          });
          showSnackBar("End Date Filter Applied Successfully");
        } catch (error) {
          print("Start Error : " + error.toString());
          showSnackBar("End Date Filter failed Try again later");
        }
      }
    });
  }

  void applyFilter(String _type) {
    if (_type == "All") {
      if (widget.isHome) {
        List<HomeItem> allList =
            Provider.of<HomeProvider>(context, listen: false).homeExpense;
        setState(() {
          list = allList;
          type = _type;
        });
      } else {
        List<VehicleItem> allList =
            Provider.of<VehicleProvide>(context, listen: false).VehicleExpense;
        setState(() {
          list = allList;
          type = _type;
        });
      }
    } else {
      final filterList =
          list.where((element) => element.type == _type).toList();
      setState(() {
        message = "No Match Entry found!...";
        list = filterList;
        type = _type;
      });
    }
    showSnackBar("Filter applied Successfully");
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
        ),
      ),
    );
  }

  // @override
  // void didChangeDependencies() {
  //   // TODO: implement didChangeDependencies
  //   super.didChangeDependencies();
  //   if (isLoadedOnce == null && list.isEmpty && list.length == 0) {
  //     print("inside did if");
  //     // if(isLoadedOnce == null ){
  //     fetchData();
  //     isLoadedOnce = false;
  //   }
  //   else {
  //     print("false");
  //   }
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //isLoadedOnce = true;
    fetchData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //CalculateAmount();
    calculateTotalExpenseThisMonth();
    print("length Build =>  " + list.length.toString());
    //isLoadedOnce = true;
    final typeList = widget.isHome ? homeList : vehicleList;
    return Column(
      children: [
        Container(
          color: Theme.of(context).primaryColor,
          margin: EdgeInsets.symmetric(horizontal: 20,vertical: 2),
          height: 55,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FittedBox(
              child: Text(
                "This Month Expense : $amount Rs ",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                ),
              ),
            ),
          ),
        ),
        SearchBarWidget(searchItem, searchController),
        // SizedBox(height: 10,),
        // CardBanner("View Home Expense"),
        // SizedBox(
        //   height: 10,
        // ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  _selectedStartDate == null
                      ? 'Start Date'
                      : DateFormat("yyyy-MM-dd").format(_selectedStartDate!),
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                IconButton(
                    icon: Icon(
                      Icons.calendar_month,
                      color: Theme.of(context).primaryColor,
                    ),
                    onPressed: _StartDatePicker)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  _selectedEndDate == null
                      ? 'End Date'
                      : DateFormat("yyyy-MM-dd").format(_selectedEndDate!),
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                IconButton(
                    icon: Icon(
                      Icons.calendar_month,
                      color: Theme.of(context).primaryColor,
                    ),
                    onPressed: _EndDatePicker)
              ],
            ),
            ElevatedButton.icon(
              onPressed: () {
                var reset = [];
                widget.isHome
                    ? reset = Provider.of<HomeProvider>(context, listen: false)
                        .homeExpense
                    : list = Provider.of<VehicleProvide>(context, listen: false)
                        .VehicleExpense;
                setState(() {
                  list = reset;
                  type = "All";
                  _selectedStartDate = null;
                  _selectedEndDate = null;
                });
              },
              label: Text("Reset"),
              icon: Icon(Icons.refresh),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Filter Expense Type",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
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
                  applyFilter(value!);
                },
                items: typeList.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        isLoading
            ? Center(child: CircularProgressIndicator())
            : list.isEmpty
                ? LayoutBuilder(builder: (ctx, constraints) {
                    return Center(
                      child: Text(
                        message,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 24,
                        ),
                      ),
                    );
                  })
                : Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        //DateTime tempDate = DateTime.parse(list[index]
                        //.date); //new DateFormat("yyyy-MM-dd").parse(list[index].date);
                        return Dismissible(
                          key: UniqueKey(),
                          background: Container(
                            color: Colors.red,
                          ),
                          onDismissed: (_) => deleteItem(list[index].id),
                          child: ListItemWidget(
                            list[index].id,
                            list[index].name,
                            list[index].amount.toString(),
                            list[index].date,
                            deleteItem,
                          ),
                        );
                      },
                      itemCount: list.length,
                    ),
                  ),
      ],
    );
  }
}
