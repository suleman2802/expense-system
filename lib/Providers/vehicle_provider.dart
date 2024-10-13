import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class VehicleProvide with ChangeNotifier {
  //attribute
  List<VehicleItem> VehicleExpense = [];

  //functions
  //fetch_data
  Future<void> fetch_data()async{
    try{
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance.collection('vehicle').get();

      // Iterate through documents
      querySnapshot.docs.forEach((doc) {
        // Extract data from each document
        String id = doc.id;
        String name = doc['name'];
        String type = doc['type'];
        double amount = doc['amount'].toDouble();
        // String date = DateFormat("yyyy-MM-dd").format(doc['date']).toString(); //(doc['date'] as Timestamp).toDate();
        String date = doc["date"];
        VehicleItem vehcileItem = VehicleItem(id, name, type, amount, date);
        VehicleExpense.add(vehcileItem);
      });
      // print("Data");
      // for(int i = 0 ;i < homeExpense.length;i++ ){
      //   print(homeExpense[i]._name);
      //   print(homeExpense[i]._date);
      // }
    }catch(error){
      print("Error : "+error.toString());
    }
    notifyListeners();

  }
  Future<void> save_data(String name, String type, double amount, String date) async {
    final _id = DateTime.now().toString();
    try {
      final firebaseInstance = await FirebaseFirestore.instance;
      final newEntry = VehicleItem(_id, name, type, amount, date);
      await firebaseInstance.collection("vehicle").doc(_id).set({
        "name": name,
        "type": type,
        "amount": amount,
        "date": date,
      }).then((value) {

        VehicleExpense.add(newEntry);
      });
    }catch(error){
      print("Error : "+error.toString());
    }
    notifyListeners();
  }
  Future<void> deleteEntry(String id)async{
    try {
      final firebaseInstance = await FirebaseFirestore.instance;
      await firebaseInstance.collection("vehicle").doc(id).delete();
    }catch(error){
      print("Error : "+error.toString());
    }
    notifyListeners();
  }

// Filters
//filterByName
}

class VehicleItem {
  String _id;
  String _name;
  String _type;
  double _amount;
  final _date;

  VehicleItem(this._id, this._name, this._type, this._amount, this._date);
  get id => _id;

  get name => _name;

  get type => _type;

  get amount => _amount;

  get date => _date;
}
