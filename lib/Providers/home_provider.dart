import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeProvider with ChangeNotifier {
  //attribute
  List<HomeItem> homeExpense = [];

  //functions
  Future<void> fetch_data()async{
    try{
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance.collection('home').get();

      // Iterate through documents
      querySnapshot.docs.forEach((doc) {
        // Extract data from each document
        String id = doc.id;
        String name = doc['name'];
        String type = doc['type'];
        double amount = doc['amount'].toDouble();
        // String date = DateFormat("yyyy-MM-dd").format(doc['date']).toString(); //(doc['date'] as Timestamp).toDate();
        String date = doc["date"];
        HomeItem homeItem = HomeItem(id, name, type, amount, date);
        homeExpense.add(homeItem);
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
      final newEntry = HomeItem(_id, name, type, amount, date);
      await firebaseInstance.collection("home").doc(_id).set({
        "name": name,
        "type": type,
        "amount": amount,
        "date": date,
      }).then((value) {

        homeExpense.add(newEntry);
      });
    }catch(error){
      print("Error : "+error.toString());
    }
    notifyListeners();
  }
  Future<void> deleteEntry(String id)async{
    try {
      final firebaseInstance = await FirebaseFirestore.instance;
      await firebaseInstance.collection("home").doc(id).delete();
    }catch(error){
      print("Error : "+error.toString());
    }
    notifyListeners();
  }

// Filters
//filterByName
}

class HomeItem {
  String _id;
  String _name;
  String _type;
  double _amount;
  final _date;

  HomeItem(this._id, this._name, this._type, this._amount, this._date);
  get id => _id;

  get name => _name;

  get type => _type;

  get amount => _amount;

  get date => _date;
}
